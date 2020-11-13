SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: January, 2018
-- Description:	Statistical distribution of alerts based on severity for a specified period of time
-- =============================================
CREATE FUNCTION [ApexSQL].[fnRAlertsSeverityDistribution]
(
	@SourceId uniqueidentifier,
	@StartTime datetimeoffset(7),
	@EndTime datetimeoffset(7)
)
RETURNS TABLE
AS
RETURN
(
	SELECT TOP 1000000 sc.[SeverityConverted] + ' - ' + CAST([ApexSQL].[fnRoundMeasuredValue](COUNT(ma.[Id]) * 100.0 / SUM(COUNT(ma.[Id])) OVER()) AS nvarchar(256)) + '%' AS [X],
		               [ApexSQL].[fnRoundMeasuredValue](COUNT(ma.Id) * 100.0 / SUM(COUNT(ma.[Id])) OVER()) AS [Y],
		               'Alert severity statistics [%] - ' + ss.[Name] AS [NonTemplateSerie],
                       'Alert severity statistics [%]' AS [TemplateSerie]
    FROM [ApexSQL].[vMonitorAlertSeverityStatusConverters] AS sc
	LEFT JOIN [ApexSQL].[MonitorAlerts] AS ma ON
        sc.[Severity] = ma.[Severity]
    AND ma.[SourceId] IN (SELECT * FROM [ApexSQL].[fnParseListGuid](@SourceId, ' '))
    AND ma.[TimeRaised] >= @StartTime
	AND ma.[TimeRaised] <= @EndTime
	LEFT JOIN (SELECT * FROM [ApexSQL].[fnRParseListSources](@SourceId, 2)) AS ss ON 
	    ss.[SelectedId] = ma.[SourceId]
	GROUP BY sc.[Severity],
             sc.[SeverityConverted],
             ss.[Name]
    ORDER BY sc.[Severity] DESC
)
GO

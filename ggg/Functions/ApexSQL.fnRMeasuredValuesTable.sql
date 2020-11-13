SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: July, 2018
-- Description:	Reports datasources
-- =============================================
CREATE FUNCTION [ApexSQL].[fnRMeasuredValuesTable]
(
	@Sources nvarchar(MAX),
	@FilterOptions int,
	@Measurments nvarchar(MAX),
	@StartDate datetimeoffset(7),
    @EndDate datetimeoffset(7)
)
RETURNS TABLE
AS
RETURN
(
	SELECT 
		sc.[ValueConverted] + ' - ' + CAST([ApexSQL].[fnRoundMeasuredValue](COUNT(mv.[Id]) * 100.0 / SUM(COUNT(mv.[Id])) OVER()) AS nvarchar(256)) + '%' AS [Status] 
	FROM [ApexSQL].[vMonitorStatusConverters] as sc
	LEFT OUTER JOIN [ApexSQL].[fnMeasuredValuesMultiParam](@StartDate, @EndDate, @Sources, @Measurments) AS mv ON
		sc.[MeasurementId] = mv.[MeasurementId]
	AND sc.[Value] = mv.[Value]
	LEFT JOIN (SELECT * FROM [ApexSQL].[fnRParseListMeasurments](@Measurments)) AS mm ON 
		mv.[MeasurementId] = mm.[SelectedId]
	WHERE 
		sc.[MeasurementId] IN (SELECT * FROM [ApexSQL].[fnParseListGuid](@Measurments, ' ')) 
		AND mv.[Value] IN (SELECT [Value] FROM [ApexSQL].[vMonitorStatusConverters])
    GROUP BY 
        sc.[ValueConverted]
)
GO

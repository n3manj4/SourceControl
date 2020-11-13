SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: September, 2018
-- Description:	Reports datasources
-- =============================================
CREATE FUNCTION [ApexSQL].[fnRSystemMetricTimeComparison]
(
	@SystemSources nvarchar(MAX),
	@Measurments   nvarchar(MAX),
	@StartDate	   nvarchar(MAX), 
	@EndDate       nvarchar(MAX)
)
RETURNS TABLE
AS
RETURN
(
	SELECT 
	    [ApexSQL].[fnUnixTime](MAX([ApexSQL].[fnTruncateDate](CAST(DATEADD(DAY, -DATEDIFF(DAY, t.[DefaultStartDate], t.[StartDate]), mv.[MeasuredAt]) AS datetimeoffset(7)), [ApexSQL].[fnCalculateInterval](t.[DefaultStartDate], t.[DefaultEndDate])))) AS [X],
	    [ApexSQL].[fnRoundMeasuredValue](AVG(mv.[Value])) AS [Y],
	    CASE
		    WHEN mm.[Unit] = '' THEN (mm.[Name] + ' [-]' + ' - ' + ss.[MachineName] + CASE WHEN ss.[DeviceName] IS NULL THEN '' ELSE ' - ' + ss.[DeviceName] END)
		    ELSE (mm.[Name] + ' [' + mm.[Unit] + ']'     + ' - ' + ss.[MachineName] + CASE WHEN ss.[DeviceName] IS NULL THEN '' ELSE ' - ' + ss.[DeviceName] END) 
	    END AS [TemplateSerie],
        t.[StartDate] + ' - ' + t.[EndDate] AS [NonTemplateSerie]
    FROM [ApexSQL].[fnRSplitTimePeriods](@StartDate, @EndDate) AS t 
    CROSS APPLY [ApexSQL].[fnMeasuredValuesMultiParam](t.[StartDate], t.[EndDate], @SystemSources, @Measurments) AS mv 
    LEFT JOIN (SELECT * FROM [ApexSQL].[fnRParseListMeasurments](@Measurments)) AS mm ON 
	    mv.[MeasurementId] = mm.[SelectedId]
    LEFT JOIN [ApexSQL].[vMonitoredObjects] AS ss ON 
	    ss.[Id] = mv.[SourceId]
    GROUP BY 
	    mm.[Name],
	    mm.[Unit],
	    ss.[DeviceName],
        ss.[MachineName],
		[ApexSQL].[fnGetDateDiff](mv.[MeasuredAt], [ApexSQL].[fnCalculateInterval](t.[DefaultStartDate], t.[DefaultEndDate])),
		t.[StartDate],
		t.[EndDate]
)
GO

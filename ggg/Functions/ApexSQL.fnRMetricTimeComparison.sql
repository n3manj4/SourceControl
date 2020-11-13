SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: September, 2018
-- Description:	Reports datasources
-- =============================================
CREATE FUNCTION [ApexSQL].[fnRMetricTimeComparison]
(
	@Sources nvarchar(MAX),
	@FilterOptions int,
	@Measurments nvarchar(MAX),
	@StartDate   nvarchar(MAX), 
	@EndDate     nvarchar(MAX)
)
RETURNS TABLE
AS
RETURN
(
	SELECT 
	    [ApexSQL].[fnUnixTime](MAX([ApexSQL].[fnTruncateDate](CAST(DATEADD(DAY, -DATEDIFF(DAY, t.[DefaultStartDate], t.[StartDate]), mv.[MeasuredAt]) AS datetimeoffset(7)), [ApexSQL].[fnCalculateInterval](t.[DefaultStartDate], t.[DefaultEndDate])))) AS [X],
	    [ApexSQL].[fnRoundMeasuredValue](AVG(mv.[Value])) AS [Y],
	    CASE
		    WHEN mm.[Unit] = '' THEN (mm.[Name] + ' [-]' + ' - ' + ss.[Name])
		    ELSE (mm.[Name] + ' [' + mm.[Unit] + ']' + ' - ' + ss.[Name]) 
	    END AS [TemplateSerie],
        t.[StartDate] + ' - ' + t.[EndDate] AS [NonTemplateSerie]
    FROM [ApexSQL].[fnRSplitTimePeriods](@StartDate, @EndDate) AS t 
    CROSS APPLY [ApexSQL].[fnMeasuredValuesMultiParam](t.[StartDate], t.[EndDate], @Sources, @Measurments) AS mv
    LEFT JOIN (SELECT * FROM [ApexSQL].[fnRParseListMeasurments](@Measurments)) AS mm ON 
	    mv.[MeasurementId] = mm.[SelectedId]
    LEFT JOIN (SELECT * FROM [ApexSQL].[fnRParseListSources](@Sources, @FilterOptions)) AS ss ON 
	    ss.[SelectedId] = mv.[SourceId]
    WHERE 
	    mv.[MeasuredAt] >= t.[StartDate]
    AND mv.[MeasuredAt] <= t.[EndDate]
    GROUP BY 
	    mm.[Name],
	    mm.[Unit],
	    ss.[Name],
		[ApexSQL].[fnGetDateDiff](mv.[MeasuredAt], [ApexSQL].[fnCalculateInterval](t.[DefaultStartDate], t.[DefaultEndDate])),
		t.[StartDate],
		t.[EndDate]
)
GO

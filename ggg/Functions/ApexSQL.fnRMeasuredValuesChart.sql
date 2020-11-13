SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: February, 2018
-- Description:	Reports datasources
-- =============================================
CREATE FUNCTION [ApexSQL].[fnRMeasuredValuesChart]
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
    SELECT [ApexSQL].[fnUnixTime](MAX(ApexSQL.fnTruncateDate(mv.[MeasuredAt], [ApexSQL].[fnCalculateInterval](@StartDate, @EndDate) ))) AS [X],
	       [ApexSQL].[fnRoundMeasuredValue](AVG(mv.[Value])) AS [Y],
	       CASE WHEN mm.[Unit] = '' THEN (mm.[Name] + ' [-]' + ' - ' + ss.[Name])
		        ELSE (mm.[Name] + ' [' + mm.[Unit] + ']' + ' - ' + ss.[Name]) 
	       END AS [NonTemplateSerie],
           CASE WHEN mm.[Unit] = '' THEN (mm.[Name] + ' [-]')
		        ELSE (mm.[Name] + ' [' + mm.[Unit] + ']') 
	       END AS [TemplateSerie]
    FROM [ApexSQL].[fnMeasuredValuesMultiParam](@StartDate, @EndDate, @Sources, @Measurments) AS mv
    LEFT JOIN (SELECT * FROM [ApexSQL].[fnRParseListMeasurments](@Measurments)) AS mm ON 
	    mv.[MeasurementId] = mm.[SelectedId]
    LEFT JOIN (SELECT * FROM [ApexSQL].[fnRParseListSources](@Sources, @FilterOptions)) AS ss ON 
	    ss.[SelectedId] = mv.[SourceId]
    GROUP BY 
        mm.[Name],
	    mm.[Unit],
	    ss.[Name],
	    [ApexSQL].[fnGetDateDiff](MeasuredAt, [ApexSQL].[fnCalculateInterval](@StartDate, @EndDate))
    
)
GO

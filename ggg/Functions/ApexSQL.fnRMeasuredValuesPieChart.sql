SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: February, 2018
-- Description:	Reports datasources
-- =============================================
CREATE FUNCTION [ApexSQL].[fnRMeasuredValuesPieChart]
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
	SELECT TOP 1000000 sc.[ValueConverted] + ' - ' + CAST([ApexSQL].[fnRoundMeasuredValue](COALESCE(COUNT(mv.[Id]) * 100.0 / NULLIF(SUM(COUNT(mv.[Id])) OVER(), 0), 0)) AS nvarchar(256)) + '%' AS [X], 
		               [ApexSQL].[fnRoundMeasuredValue](COALESCE(COUNT(mv.[Id]) * 100.0 / NULLIF(SUM(COUNT(mv.[Id])) OVER(), 0), 0)) AS [Y],
		               (mm.[Name] + ' - ' + ss.[Name]) AS [NonTemplateSerie],
                       mm.[Name] AS [TemplateSerie]
	FROM [ApexSQL].[vMonitorStatusConverters] AS sc
	LEFT OUTER JOIN [ApexSQL].[fnMeasuredValuesMultiParam](@StartDate, @EndDate, @Sources, @Measurments) AS mv ON
		sc.[MeasurementId] = mv.[MeasurementId]
	AND sc.[Value] = mv.[Value]
	LEFT JOIN (SELECT * FROM [ApexSQL].[fnRParseListMeasurments](@Measurments)) AS mm ON 
		mv.[MeasurementId] = mm.[SelectedId]
	LEFT JOIN (SELECT * FROM [ApexSQL].[fnRParseListSources](@Sources, @FilterOptions)) AS ss ON 
		ss.[SelectedId] = mv.[SourceId]
	WHERE sc.[MeasurementId] IN (SELECT * FROM [ApexSQL].[fnParseListGuid](@Measurments, ' ')) 
    GROUP BY sc.[Value],
             sc.[ValueConverted],
             mm.[Name], 
             ss.[Name]
    ORDER BY sc.[Value]
)
GO

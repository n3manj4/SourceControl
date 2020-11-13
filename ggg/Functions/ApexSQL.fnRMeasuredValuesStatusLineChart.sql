SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: November, 2018
-- Description:	Returns grouped statuses for line chart
-- =============================================
CREATE FUNCTION [ApexSQL].[fnRMeasuredValuesStatusLineChart]
(
    @sources       varchar(MAX),
    @filterOptions int,
    @measurements  varchar(MAX),
    @startDate     datetimeoffset(7),
    @endDate       datetimeoffset(7)
)
RETURNS TABLE AS
RETURN
(
    WITH allValues AS
    (
        SELECT ROW_NUMBER() OVER (ORDER BY [MeasuredAt]) AS [RowNumber],
               mv.*
        FROM [ApexSQL].[fnMeasuredValuesMultiParam](@startDate, @endDate, @sources, @measurements) AS mv
    ),
    groupedValues AS 
    (
        SELECT * FROM (SELECT TOP 1 * FROM allValues) AS firstRecord
        UNION ALL
        SELECT r1.*
        FROM       allValues AS r1
        INNER JOIN allValues AS r2 ON
            r1.[RowNumber] - 1 = r2.[RowNumber]
        WHERE r1.[Value] - r2.[Value] <> 0
        UNION ALL
        SELECT * FROM (SELECT TOP 1 * FROM allValues ORDER BY [RowNumber] DESC) AS lastRecord
    )
    SELECT TOP 1000000 [ApexSQL].[fnUnixTime](gv.[MeasuredAt]) AS [X],
                       gv.[Value]                              AS [Y],
                       sc.[ValueConverted]                     AS [YValueConverted],
                       mm.[Name] + ' [-] - ' + ss.[Name]       AS [NonTemplateSerie],
                       mm.[Name] + ' [-]'                      AS [TemplateSerie]
    FROM groupedValues AS gv
    LEFT JOIN [ApexSQL].[vMonitorStatusConverters] AS sc ON
        sc.[MeasurementId] = gv.[MeasurementId]
    AND sc.[Value] = gv.[Value]
    LEFT JOIN (SELECT * FROM [ApexSQL].[fnRParseListMeasurments](@measurements)) AS mm ON
        mm.[SelectedId] = gv.[MeasurementId]
    LEFT JOIN (SELECT * FROM [ApexSQL].[fnRParseListSources](@sources, @filterOptions)) AS ss ON 
		ss.[SelectedId] = gv.[SourceId]
    ORDER BY gv.[MeasuredAt]
)
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: January, 2019
-- Description:	Returns all measured values for multiple parameters
-- =============================================
CREATE FUNCTION [ApexSQL].[fnMeasuredValuesMultiParam]
(
    @startDate    datetimeoffset(7),
    @endDate      datetimeoffset(7),
    @sources      nvarchar(MAX),
    @measurements nvarchar(MAX)
)
RETURNS TABLE
AS
RETURN
(
    WITH selectedMVA AS
    (
        SELECT [Id],
               [SourceId],
               [MeasurementId],
               [WaitTypeId],
               [Values],
               [MeasuredAt],
               [Periods]
        FROM [ApexSQL].[MonitorMeasuredValuesArchive] AS mva WITH (NOLOCK)
        LEFT JOIN [ApexSQL].[fnParseListGuid](@sources, ' ') AS s ON
            s.[SelectedId] = mva.[SourceId]
        LEFT JOIN [ApexSQL].[fnParseListGuid](@measurements, ' ') AS m ON
            m.[SelectedId] = mva.[MeasurementId]
        WHERE (@startDate IS NULL OR DATEADD(dd, 0, DATEDIFF(dd, 0, [MeasuredAt])) >= DATEADD(dd, 0, DATEDIFF(dd, 0, @startDate)))
          AND (@endDate   IS NULL OR DATEADD(dd, 0, DATEDIFF(dd, 0, [MeasuredAt])) <= DATEADD(dd, 0, DATEDIFF(dd, 0, @endDate  )))
          AND (s.[SelectedId] IS NOT NULL OR (@sources      IS NULL AND s.[SelectedId] IS NULL))
		  AND (m.[SelectedId] IS NOT NULL OR (@measurements IS NULL AND m.[SelectedId] IS NULL))
    )
    SELECT (SELECT [Id] FROM [ApexSQL].[vGenerateNewId]) AS [Id],
		   archive.[Id] AS [GroupId],
		   archive.[SourceId],
		   archive.[MeasurementId],
		   archive.[WaitTypeId],
		   a.[Value],
		   DATEADD(SECOND, a.[Period], [MeasuredAt]) AS [MeasuredAt]
	FROM selectedMVA AS archive
	CROSS APPLY
	(
		SELECT [Value], [Period] FROM [ApexSQL].[fnSplitValuesPeriods](archive.[Values], archive.[Periods])
	) AS a
    WHERE (DATEADD(SECOND, a.[Period], [MeasuredAt]) >= @startDate OR @startDate IS NULL)
      AND (DATEADD(SECOND, a.[Period], [MeasuredAt]) <= @endDate   OR @endDate   IS NULL)
    UNION ALL
    SELECT [Id],
           [Id] AS [GroupId],
           [SourceId],
           [MeasurementId],
           [WaitTypeId],
           [Value],
           [MeasuredAt]
    FROM [ApexSQL].[MonitorMeasuredValues] AS mv WITH (NOLOCK)
	LEFT JOIN [ApexSQL].[fnParseListGuid](@sources, ' ') AS s ON
		s.[SelectedId] = mv.[SourceId]
	LEFT JOIN [ApexSQL].[fnParseListGuid](@measurements, ' ') AS m ON
		m.[SelectedId] = mv.[MeasurementId]
    WHERE ([MeasuredAt] >= @startDate OR @startDate IS NULL)
      AND ([MeasuredAt] <= @endDate   OR @endDate   IS NULL)
      AND (s.[SelectedId] IS NOT NULL OR (@sources      IS NULL AND s.[SelectedId] IS NULL))
      AND (m.[SelectedId] IS NOT NULL OR (@measurements IS NULL AND m.[SelectedId] IS NULL))
)
GO

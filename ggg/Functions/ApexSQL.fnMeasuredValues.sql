SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: January, 2019
-- Description:	Returns all measured values
-- =============================================
CREATE FUNCTION [ApexSQL].[fnMeasuredValues]
(
    @startDate     datetimeoffset(7),
    @endDate       datetimeoffset(7),
    @sourceId      uniqueidentifier,
    @measurementId uniqueidentifier
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
        WHERE (@startDate IS NULL OR DATEADD(dd, 0, DATEDIFF(dd, 0, [MeasuredAt])) >= DATEADD(dd, 0, DATEDIFF(dd, 0, @startDate)))
          AND (@endDate   IS NULL OR DATEADD(dd, 0, DATEDIFF(dd, 0, [MeasuredAt])) <= DATEADD(dd, 0, DATEDIFF(dd, 0, @endDate  )))
          AND (@sourceId      IS NULL OR [SourceId]      = @sourceId     )
		  AND (@measurementId IS NULL OR [MeasurementId] = @measurementId)
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
    WHERE ([MeasuredAt] >= @startDate OR @startDate IS NULL)
      AND ([MeasuredAt] <= @endDate   OR @endDate   IS NULL)
      AND (@sourceId      IS NULL OR [SourceId]      = @sourceId     )
      AND (@measurementId IS NULL OR [MeasurementId] = @measurementId)
)
GO

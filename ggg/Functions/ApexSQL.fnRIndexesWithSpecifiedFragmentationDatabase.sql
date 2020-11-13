SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: January, 2018
-- Description:	Report on indexes with Fragmentation above xx% in a specified database
-- =============================================
CREATE FUNCTION [ApexSQL].[fnRIndexesWithSpecifiedFragmentationDatabase]
(
	@SourceId uniqueidentifier,
	@Fragmentation int,
	@StartTime DateTimeOffset(7),
	@EndTime DateTimeOffset(7)
)
RETURNS TABLE
AS
RETURN
(
	SELECT TOP 1000000 si.SourceName AS [Index],
		               R.[Value] AS [Fragmentation [%]]],
		               MI.[DatabaseName] AS [Database],
		               MI.[TableName] AS [Table],
		               R.[MeasuredAt] AS [Measured at]
	FROM 
	(
		SELECT M.[SourceId],
			   M.[MeasurementId],
			   M.[Value],
			   M.[MeasuredAt],
			   ROW_NUMBER() OVER(PARTITION BY M.SourceId,M.MeasurementId ORDER BY M.MeasuredAt DESC) AS rn
		FROM [ApexSQL].[fnMeasuredValues](@StartTime, @EndTime, NULL, 'C3E8D1AF-F16C-476D-B785-10817C5352E0') AS M 
		WHERE M.SourceId IN (SELECT SourceId FROM [ApexSQL].[fnRGetAllIndexesForDatabase](@SourceId))
	) AS R 
	LEFT JOIN (SELECT * FROM [ApexSQL].[fnRGetAllIndexesForDatabase](@SourceId)) AS si ON
		R.SourceId = si.SourceId
	LEFT JOIN [ApexSQL].[MonitorIndexes] AS MI ON
		MI.Id = R.SourceId
	WHERE R.rn <= 1 
	  AND R.Value > @Fragmentation
	  AND R.MeasuredAt >= @StartTime
	  AND R.MeasuredAt <= @EndTime
	ORDER BY R.[Value] DESC, 
             MI.[DatabaseName]
)
GO

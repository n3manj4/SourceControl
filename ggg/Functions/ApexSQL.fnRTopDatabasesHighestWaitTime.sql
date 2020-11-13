SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: January, 2018
-- Description:	Top 10 databases with the highest wait time
-- =============================================
CREATE FUNCTION [ApexSQL].[fnRTopDatabasesHighestWaitTime]
(
	@SourceId uniqueidentifier,
	@StartTime DateTimeOffset(7),
	@EndTime DateTimeOffset(7)
)
RETURNS TABLE
AS
RETURN
(
	SELECT TOP 10 MAX(MD.[DatabaseName]) AS [Database|X],
		          [ApexSQL].[fnRRoundWaitTime](SUM([WaitTime])) AS [Wait time [s]]|Y]
	FROM [ApexSQL].[MonitorQueryWaits] AS QW 
	LEFT JOIN [ApexSQL].[MonitorDatabases] AS MD ON 
		QW.DatabaseNameId = MD.Id
	WHERE QW.SourceId = @SourceId
	  AND QW.MeasuredAt > @StartTime
	  AND QW.MeasuredAt < @EndTime
	GROUP BY [DatabaseNameId]
	ORDER BY [Wait time [s]]|Y] DESC
)
GO

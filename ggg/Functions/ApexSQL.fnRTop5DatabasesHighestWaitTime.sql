SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: July, 2018
-- Description:	Top 5 databases with the highest wait time
-- =============================================
CREATE FUNCTION [ApexSQL].[fnRTop5DatabasesHighestWaitTime]
(
	@SourceId uniqueidentifier,
	@StartTime DateTimeOffset(7),
	@EndTime DateTimeOffset(7)
)
RETURNS TABLE
AS
RETURN
(
	SELECT 
		TOP 5 MAX(MD.[DatabaseName]) AS [Database],
		[ApexSQL].[fnRRoundWaitTime](SUM([WaitTime])) AS [Wait time [s]]]
	FROM [ApexSQL].[MonitorQueryWaits] AS QW 
	LEFT JOIN [ApexSQL].[MonitorDatabases] MD ON 
		QW.DatabaseNameId = MD.Id
	WHERE 
		QW.SourceId = @SourceId
	AND QW.MeasuredAt > @StartTime
	AND QW.MeasuredAt < @EndTime
	GROUP BY 
		[DatabaseNameId]
	ORDER BY 
		[Wait time [s]]] DESC
)
GO

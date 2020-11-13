SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: September, 2017
-- Description:	Return 10 queries for all servers in specific group and its childrens
-- =============================================
CREATE FUNCTION [ApexSQL].[fnGetTop10QueriesForAllServerInGroup]
(
	@GroupId uniqueidentifier,
	@StartDate DateTimeOffset(7),
	@EndDate DateTimeOffset(7)
) 
RETURNS TABLE 
AS
RETURN 
(WITH s AS 
(
  SELECT SourceId, Id, QueryTextId, SqlHandle, StmOffsetStart, StmOffsetEnd, [ExecCount] , TotalWaitTime , rn = ROW_NUMBER()
  OVER (PARTITION BY SourceId ORDER BY TotalWaitTime DESC)
  FROM 
  (
    SELECT SourceId, Id, QueryTextId, MAX(SqlHandle) AS SqlHandle, StmOffsetStart, StmOffsetEnd,  COUNT(*) as [ExecCount], TotalWaitTime = SUM([WaitTime])
    FROM [ApexSQL].[MonitorQueryWaits]
	WHERE MeasuredAt >= @StartDate AND MeasuredAt <= @EndDate  AND  
		  SourceId IN (SELECT ws.Id FROM [ApexSQL].[fnGetAllServersNoClusterByGroup](@GroupId) AS ws)
    GROUP BY SourceId, QueryTextId, StmOffsetStart, StmOffsetEnd, Id
  ) AS s2
)
SELECT s.SourceId as [SourceId], s.Id as Id, TotalWaitTime, ExecCount, s.SqlHandle AS SqlHandle, QueryName, 
SUBSTRING( [SqlText], StmOffsetStart/2 +1, 
(CASE WHEN StmOffsetEnd = -1  THEN LEN(CONVERT(NVARCHAR(MAX), [SqlText])) * 2 ELSE StmOffsetEnd + 2 END - StmOffsetStart )/2 ) AS [SqlText]
FROM s LEFT JOIN [ApexSQL].[MonitorQueryTexts] qt ON s.QueryTextId = qt.Id
WHERE rn <= 10)
GO

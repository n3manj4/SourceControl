SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: July, 2018
-- Description:	Compare total wait time with previous period
-- =============================================
CREATE FUNCTION [ApexSQL].[fnRCompareWaitTime]
(
	@SourceId uniqueidentifier,
	@StartDate DateTimeOffset(7), 
	@EndDate DateTimeOffset(7)
)
RETURNS TABLE
AS
RETURN
(
	WITH cte AS 
    (
	    SELECT [ApexSQL].[fnRRoundWaitTime](ISNULL(SUM(WaitTime),0)) AS [Period1], 
			0 AS [Period2]
	    FROM [ApexSQL].[MonitorQueryWaits] 
	    WHERE MeasuredAt >= @StartDate 
		AND MeasuredAt <= @EndDate 
		AND SourceId = @SourceId
		UNION ALL
		SELECT 0 AS [Period1], 
			[ApexSQL].[fnRRoundWaitTime](ISNULL(SUM(WaitTime),0)) AS [Period2]
		FROM [ApexSQL].[MonitorQueryWaits] 
		WHERE MeasuredAt >= DATEADD(DAY , -DATEDIFF(DAY ,  @StartDate, @EndDate), @StartDate) 
		AND MeasuredAt <= @StartDate 
		AND SourceId = @SourceId
    )
    SELECT SUM(Period1)					AS [Total wait time [s]]], 
		   SUM(Period2)					AS [Total wait time in previous period [s]]],
		   SUM(Period1) - SUM(Period2)	AS [Difference in total wait times [s]]],
		   CASE
			   WHEN (SUM(Period1) - SUM(Period2)) = 0 THEN 0
               WHEN SUM(Period2) = 0 THEN 100 
               ELSE ABS(((SUM(Period1) - SUM(Period2)) * 100 ) / SUM(Period2))
           END AS [Difference [%]]],
		   CASE 
               WHEN SUM(Period1) > SUM(Period2) THEN 'increase'
               WHEN SUM(Period1) < SUM(Period2) THEN 'decrease'
               ELSE ''
           END AS [Status]
    FROM cte
)
GO

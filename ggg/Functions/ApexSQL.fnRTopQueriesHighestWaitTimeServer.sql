SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: January, 2018
-- Description:	Top 10 queries with highest wait time per monitored SQL Server
-- =============================================
CREATE FUNCTION [ApexSQL].[fnRTopQueriesHighestWaitTimeServer]
(
	@SourceId uniqueidentifier,
	@StartDate DateTimeOffset(7),
	@EndDate DateTimeOffset(7)
)
RETURNS TABLE
AS
RETURN
(
	SELECT TOP 10 CONVERT(varchar(MAX), QW.[SqlHandle], 1) AS [Query handle],
                  [ApexSQL].[fnRRoundWaitTime](SUM([WaitTime])) AS [Wait time [s]]],
	              MAX(MD.[DatabaseName]) AS [Database],
                  CONVERT(varchar(MAX), QW.[PlanHandle], 1) AS [Plan handle],
	              ISNULL(MAX(QT.[SqlText]), 'Query not available') AS [T-SQL],
	              ISNULL(MAX(QT.QueryName), 'Q#' + CAST(ABS(CHECKSUM(QW.[SqlHandle])) AS nvarchar(256))) AS [Caption]
	FROM [ApexSQL].[MonitorQueryWaits] AS QW 
	LEFT JOIN [ApexSQL].[MonitorQueryTexts] AS QT ON 
		QW.QueryTextId = QT.Id
	LEFT JOIN [ApexSQL].[MonitorDatabases] AS MD ON 
		QW.DatabaseNameId = MD.Id
	WHERE QW.SourceId = @SourceId
	  AND [MeasuredAt] >= @StartDate 
	  AND [MeasuredAt] <= @EndDate
	GROUP BY QW.[QueryTextId], 
		     QW.[SqlHandle],
		     QW.[PlanHandle],
		     QW.[StmOffsetStart],
		     QW.[StmOffsetEnd],
	         QW.[SourceId],
	         QW.DatabaseNameId
	ORDER BY [Wait time [s]]] DESC
)
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: January, 2018
-- Description:	Top 10 queries with the highest wait time for a specific wait type per database
-- =============================================
CREATE FUNCTION [ApexSQL].[fnRTopQueriesHighestWaitTimeWaitTypeDatabase]
(
	@SourceId uniqueidentifier,
	@WaitType nvarchar(MAX),
	@StartDate datetimeoffset(7),
	@EndDate datetimeoffset(7)
)
RETURNS TABLE
AS
RETURN
(
	SELECT TOP 10 CONVERT(varchar(MAX), QW.[SqlHandle], 1) AS [SQL handle],
		          CONVERT(varchar(MAX), QW.[PlanHandle], 1) AS [Plan handle],
		          [ApexSQL].[fnRRoundWaitTime](SUM(QW.[WaitTime])) AS [Total wait [s]]],
		          ISNULL(MAX(QT.[SqlText]), 'Query not available') AS [T-SQL],
		          ISNULL(MAX(QT.QueryName), 'Q#' + CAST(ABS(CHECKSUM(QW.[SqlHandle])) AS nvarchar(256))) AS [Caption]
	FROM [ApexSQL].[vMonitorQuerySingleWaits] QW 
	LEFT JOIN [ApexSQL].[MonitorQueryTexts] AS QT ON 
		QW.QueryTextId = QT.Id
	LEFT JOIN [ApexSQL].[MonitorDatabases] AS MD ON 
		QW.DatabaseNameId = MD.Id
	WHERE QW.DatabaseNameId = @SourceId 
	  AND WaitTypeName = @WaitType 
	  AND QT.SqlText IS NOT NULL 
	  AND [MeasuredAt] >= @StartDate 
	  AND [MeasuredAt]<= @EndDate
	GROUP BY QW.[QueryTextId],
		     QW.[SqlHandle],
		     QW.[PlanHandle],
		     QW.[StmOffsetStart],
		     QW.[StmOffsetEnd],
		     QW.[SourceId],
		     QW.DatabaseNameId,
		     QW.[WaitTypeName]
	ORDER BY [Total wait [s]]] DESC
)
GO

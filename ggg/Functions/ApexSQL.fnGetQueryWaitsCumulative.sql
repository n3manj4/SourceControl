SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: January, 2017
-- Description:	Returns cumulative table for query waits
-- =============================================
CREATE FUNCTION [ApexSQL].[fnGetQueryWaitsCumulative]
(
	@StartDate datetimeoffset(7),
	@EndDate datetimeoffset(7),
	@SourceId uniqueidentifier,
	@Interval int,
	@Nonblockers int) 

RETURNS TABLE 
AS
RETURN 
(
SELECT
	  CAST(MAX(CAST(QW.[Id] as binary(16))) as uniqueidentifier) as [Id],
	  QW.[SourceId],
      QW.[DatabaseNameId],
	  MAX(MD.[DatabaseName]) as [DatabaseName],
      QW.[SqlHandle],
	  CAST(MAX(CAST(QW.[QueryTextId] as binary(16))) as uniqueidentifier) as [QueryTextId],
	  CAST(MAX(CAST(QW.[QueryPlanId] as binary(16))) as uniqueidentifier) as [QueryPlanId],
      QW.[PlanHandle],
      QW.[StmOffsetStart],
      QW.[StmOffsetEnd],
	  ISNULL(MAX(QT.[QueryName]), 'Q#' + CAST(ABS(CHECKSUM(QW.[SqlHandle])) AS nvarchar(256))) AS [LocalId],
	  SUM(QW.[WaitTime]) as [WaitTime],
      ApexSQL.fnTruncateDate(QW.[MeasuredAt], @Interval) as MeasuredAt,
      SUM(QW.[PhysicalReads]) as [PhysicalReads],
      SUM(QW.[LogicalWrites]) as [LogicalWrites],
      SUM(QW.[LogicalReads]) as [LogicalReads],
      SUM(QW.[IO]) as [IO],
      SUM(QW.[ElapsedTime]) as [ElapsedTime],
	  SUM(QW.[CPUTime]) as [CPUTime],
      SUM(QW.[RowCount]) as [RowCount],
	  COUNT(*) as [ExecutionCount],
	  (  
		SELECT [WaitTypeName] + ';' + CAST(SUM(WaitTime) as NVARCHAR(MAX)) + ',' 
		FROM [ApexSQL].[vMonitorQuerySingleWaits] MV
		WHERE MV.[SourceId]       = QW.[SourceId] AND 
			  MV.[SqlHandle]      = QW.[SqlHandle] AND 
			  MV.[PlanHandle]     = QW.[PlanHandle] AND 
			  MV.[DatabaseNameId] = QW.[DatabaseNameId] AND 
			  MV.[StmOffsetStart] = QW.[StmOffsetStart] AND
			  MV.[StmOffsetEnd]   = QW.[StmOffsetEnd] AND
			  MV.MeasuredAt >= @StartDate AND MV.MeasuredAt <= @EndDate AND
			  ApexSQL.fnTruncateDate(MV.MeasuredAt , @Interval) = ApexSQL.fnTruncateDate(QW.MeasuredAt , @Interval)
		GROUP BY MV.[SourceId], MV.[SqlHandle], MV.[PlanHandle], MV.[DatabaseNameId], MV.[StmOffsetEnd], MV.[StmOffsetStart], MV.[WaitTypeName]
		FOR XML PATH('')) AS SingleWaits
  FROM [ApexSQL].[MonitorQueryWaits] QW LEFT JOIN 
	   [ApexSQL].[MonitorQueryTexts] QT ON QW.[QueryTextId] = QT.Id LEFT JOIN
	   [ApexSQL].MonitorDatabases MD ON QW.DatabaseNameId = MD.Id
  WHERE QW.SourceId = @SourceId AND
		ISNULL(QT.Enabled,1) = 1 AND
		ISNULL(MD.Enabled,1) = 1 AND
		QW.MeasuredAt >= @StartDate AND QW.MeasuredAt <= @EndDate AND 
		(@Nonblockers = 1 OR QW.WaitResource IS NOT NULL)
  GROUP BY QW.[SourceId], QW.[DatabaseNameId], QW.[SqlHandle], QW.[PlanHandle], QW.[StmOffsetStart], QW.[StmOffsetEnd], ApexSQL.fnTruncateDate(QW.[MeasuredAt], @Interval)
)
GO

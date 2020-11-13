SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: January, 2017
-- Description:	Returns statistic for single query handle
-- =============================================
CREATE FUNCTION [ApexSQL].[fnGetQueryWaitsSingle]
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
SELECT QW.[Id]
      ,QW.[SourceId]
      ,QW.[QueryTextId]
      ,QW.[QueryPlanId]
      ,L.[Name] as [LoginName]
      ,D.[DatabaseName] as [DatabaseName]
      ,H.[Name] as [HostName]
      ,A.[Name] as [ApplicationName]
      ,ISNULL(QT.[QueryName], 'Q#' + CAST(ABS(CHECKSUM(QW.[SqlHandle])) AS nvarchar(256))) AS [LocalId]
      ,QW.[SPID]
      ,QW.[SqlHandle]
      ,QW.[WaitTime]
      ,Qw.[PlanHandle]
      ,QW.[StmOffsetStart]
      ,QW.[StmOffsetEnd]
      ,QW.[MeasuredAt]
      ,QW.[WaitSPIDS]
      ,QW.[WaitResource]
      ,QW.[PhysicalReads]
      ,QW.[LogicalWrites]
      ,QW.[LogicalReads]
      ,QW.[IO]
      ,QW.[ElapsedTime]
      ,QW.[CPUTime]
      ,QW.[RowCount]
      ,QW.[SingleWaits]
      ,QW.[Blockers]
  FROM [ApexSQL].[MonitorQueryWaits] QW 
  LEFT JOIN [ApexSQL].[MonitorQueryLookupInfo] L ON QW.LoginNameId = L.Id
  LEFT JOIN [ApexSQL].[MonitorQueryLookupInfo] H ON QW.HostNameId = H.Id
  LEFT JOIN [ApexSQL].[MonitorQueryLookupInfo] A ON QW.ApplicationNameId = A.Id
  LEFT JOIN [ApexSQL].[MonitorDatabases] D ON QW.DatabaseNameId = D.Id
  LEFT JOIN [ApexSQL].[MonitorQueryTexts] QT ON QW.QueryTextId = QT.Id
  WHERE QW.SourceId = @SourceId AND
		ISNULL(QT.Enabled,1) = 1 AND
		ISNULL(D.Enabled,1) = 1 AND
		QW.MeasuredAt >= @StartDate AND QW.MeasuredAt <= @EndDate AND 
		(@Nonblockers = 1 OR QW.WaitResource IS NOT NULL)
)
GO

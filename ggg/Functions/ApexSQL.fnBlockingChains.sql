SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================            
-- Author:		ApexSQL LLC
-- Create date: March, 2019
-- Description:	Returns query blocking chains
-- =============================================
CREATE FUNCTION [ApexSQL].[fnBlockingChains]
(
    @serverId uniqueidentifier,
    @fromTime datetimeoffset(7),
    @toTime   datetimeoffset(7)
)
RETURNS TABLE
AS
RETURN
(
    SELECT TOP 1000000 qw.[Id],
                       ISNULL(qt.QueryName, 'Q#' + CAST(ABS(CHECKSUM(qw.[SqlHandle])) AS nvarchar(256))) AS [LocalId],
                       db.[DatabaseName] AS [DatabaseName],
                       qw.[WaitTime],
                       qw.[MeasuredAt],
                       l.[Name] AS [LoginName],
                       h.[Name] AS [HostName],
                       a.[Name] AS [ApplicationName],
                       qw.[QueryPlanId],
                       qw.[SPID],
                       qw.[WaitSPIDS],
                       qw.[WaitResource],
                       qw.[SqlHandle],
                       qw.[PlanHandle],
                       qw.[StmOffsetStart],
                       qw.[StmOffsetEnd],
                       qw.[PhysicalReads],
                       qw.[LogicalWrites],
                       qw.[LogicalReads],
                       qw.[IO],
                       qw.[ElapsedTime],
                       qw.[CPUTime],
                       qw.[RowCount],
                       qw.[SingleWaits],
                       qw.[HeadBlocker],
                       hb.[SelectedId] AS [HeadBlockerId],
    	               qb.[SelectedId] AS [BlockerId],
                       qw.[Blockers]
    FROM [ApexSQL].[MonitorQueryWaits] AS qw
    CROSS APPLY (SELECT [SelectedId] FROM [ApexSQL].[fnParseListGuid](qw.[HeadBlockerIds], ' ')) AS hb
    INNER JOIN [ApexSQL].[MonitorQueryWaits] AS headBlockers ON
        headBlockers.[Id] = hb.[SelectedId]
    CROSS APPLY (SELECT [SelectedId] FROM [ApexSQL].[fnParseListGuid](ISNULL(qw.[Blockers], ''), ' ')) AS qb
    LEFT JOIN [ApexSQL].[MonitorQueryLookupInfo] AS  l ON  l.[Id] = qw.[LoginNameId]
    LEFT JOIN [ApexSQL].[MonitorQueryLookupInfo] AS  h ON  h.[Id] = qw.[HostNameId]
    LEFT JOIN [ApexSQL].[MonitorQueryLookupInfo] AS  a ON  a.[Id] = qw.[ApplicationNameId]
    LEFT JOIN [ApexSQL].[MonitorDatabases]       AS db ON db.[Id] = qw.[DatabaseNameId]
    LEFT JOIN [ApexSQL].[MonitorQueryTexts]      AS qt ON qt.[Id] = qw.[QueryTextId]
    WHERE qw.[SourceId] = @serverId
      AND headBlockers.[SourceId]    = @serverId
      AND headBlockers.[MeasuredAt] >= @fromTime
      AND headBlockers.[MeasuredAt] <= @toTime
      AND headBlockers.[HeadBlocker] = 1
    ORDER BY qw.[MeasuredAt]
)
GO

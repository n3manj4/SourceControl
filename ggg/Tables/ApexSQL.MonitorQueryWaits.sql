SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [ApexSQL].[MonitorQueryWaits] (
		[Id]                    [uniqueidentifier] NOT NULL,
		[SourceId]              [uniqueidentifier] NOT NULL,
		[QueryTextId]           [uniqueidentifier] NULL,
		[QueryPlanId]           [uniqueidentifier] NULL,
		[LoginNameId]           [uniqueidentifier] NULL,
		[DatabaseNameId]        [uniqueidentifier] NULL,
		[HostNameId]            [uniqueidentifier] NULL,
		[ApplicationNameId]     [uniqueidentifier] NULL,
		[SPID]                  [int] NOT NULL,
		[SqlHandle]             [binary](20) NOT NULL,
		[WaitTime]              [bigint] NOT NULL,
		[PlanHandle]            [varbinary](64) NOT NULL,
		[StmOffsetStart]        [int] NOT NULL,
		[StmOffsetEnd]          [int] NOT NULL,
		[MeasuredAt]            [datetimeoffset](7) NOT NULL,
		[WaitSPIDS]             [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[WaitResource]          [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PhysicalReads]         [bigint] NOT NULL,
		[LogicalWrites]         [bigint] NOT NULL,
		[LogicalReads]          [bigint] NOT NULL,
		[IO]                    [bigint] NOT NULL,
		[ElapsedTime]           [bigint] NOT NULL,
		[CPUTime]               [bigint] NOT NULL,
		[RowCount]              [bigint] NOT NULL,
		[SingleWaits]           [nvarchar](512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[HeadBlocker]           [tinyint] NOT NULL,
		[Blockers]              [varchar](512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[HeadBlockerIds]        [varchar](1024) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK_MonitorQueryWaits]
		PRIMARY KEY
		CLUSTERED
		([Id])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [ApexSQL].[MonitorQueryWaits] SET (LOCK_ESCALATION = TABLE)
GO

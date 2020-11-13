SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [ApexSQL].[MonitorAvailabilityReplicas] (
		[Id]                      [uniqueidentifier] NOT NULL,
		[ParentId]                [uniqueidentifier] NOT NULL,
		[ReplicaId]               [uniqueidentifier] NOT NULL,
		[ParentNodeId]            [uniqueidentifier] NOT NULL,
		[AvailabilityGroupId]     [uniqueidentifier] NOT NULL,
		[Instance]                [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Enabled]                 [bit] NOT NULL,
		CONSTRAINT [PK_MonitorAvailabilityReplicas]
		PRIMARY KEY
		CLUSTERED
		([Id])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [ApexSQL].[MonitorAvailabilityReplicas] SET (LOCK_ESCALATION = TABLE)
GO

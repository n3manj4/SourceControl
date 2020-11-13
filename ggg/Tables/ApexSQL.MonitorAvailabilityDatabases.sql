SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [ApexSQL].[MonitorAvailabilityDatabases] (
		[Id]                      [uniqueidentifier] NOT NULL,
		[ParentId]                [uniqueidentifier] NOT NULL,
		[DatabaseId]              [int] NOT NULL,
		[DatabaseGroupId]         [uniqueidentifier] NOT NULL,
		[AvailabilityGroupId]     [uniqueidentifier] NOT NULL,
		[ReplicaId]               [uniqueidentifier] NOT NULL,
		[DatabaseName]            [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		CONSTRAINT [PK_MonitorAvailabilityDatabases]
		PRIMARY KEY
		CLUSTERED
		([Id])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [ApexSQL].[MonitorAvailabilityDatabases] SET (LOCK_ESCALATION = TABLE)
GO

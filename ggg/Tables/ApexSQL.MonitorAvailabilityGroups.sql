SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [ApexSQL].[MonitorAvailabilityGroups] (
		[Id]                    [uniqueidentifier] NOT NULL,
		[GroupId]               [uniqueidentifier] NOT NULL,
		[WsfcClusterParent]     [uniqueidentifier] NOT NULL,
		[ClusterName]           [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Name]                  [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[BackupPreference]      [int] NOT NULL,
		[Enabled]               [bit] NOT NULL,
		CONSTRAINT [PK_MonitorAvailabilityGroups]
		PRIMARY KEY
		CLUSTERED
		([Id])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [ApexSQL].[MonitorAvailabilityGroups]
	WITH CHECK
	ADD CONSTRAINT [FK_MonitorAvailabilityGroups_MonitorWsfcClusters]
	FOREIGN KEY ([WsfcClusterParent]) REFERENCES [ApexSQL].[MonitorWsfcClusters] ([Id])
ALTER TABLE [ApexSQL].[MonitorAvailabilityGroups]
	CHECK CONSTRAINT [FK_MonitorAvailabilityGroups_MonitorWsfcClusters]

GO
ALTER TABLE [ApexSQL].[MonitorAvailabilityGroups] SET (LOCK_ESCALATION = TABLE)
GO

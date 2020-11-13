SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [ApexSQL].[MonitorWsfcNodes] (
		[Id]                    [uniqueidentifier] NOT NULL,
		[ParentId]              [uniqueidentifier] NOT NULL,
		[WsfcClusterParent]     [uniqueidentifier] NOT NULL,
		[ClusterName]           [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Name]                  [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Type]                  [int] NOT NULL,
		CONSTRAINT [PK_MonitorWsfcNodes]
		PRIMARY KEY
		CLUSTERED
		([Id])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [ApexSQL].[MonitorWsfcNodes]
	WITH CHECK
	ADD CONSTRAINT [FK_MonitorWsfcNodes_MonitorWsfcClusters]
	FOREIGN KEY ([WsfcClusterParent]) REFERENCES [ApexSQL].[MonitorWsfcClusters] ([Id])
ALTER TABLE [ApexSQL].[MonitorWsfcNodes]
	CHECK CONSTRAINT [FK_MonitorWsfcNodes_MonitorWsfcClusters]

GO
ALTER TABLE [ApexSQL].[MonitorWsfcNodes] SET (LOCK_ESCALATION = TABLE)
GO

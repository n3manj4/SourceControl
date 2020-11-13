SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [ApexSQL].[MonitorWsfcClusters] (
		[Id]              [uniqueidentifier] NOT NULL,
		[Name]            [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[QuorumType]      [int] NOT NULL,
		[QuorumState]     [int] NOT NULL,
		CONSTRAINT [PK_MonitorWsfcClusters]
		PRIMARY KEY
		CLUSTERED
		([Id])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [ApexSQL].[MonitorWsfcClusters] SET (LOCK_ESCALATION = TABLE)
GO

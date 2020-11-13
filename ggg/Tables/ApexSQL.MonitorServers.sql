SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [ApexSQL].[MonitorServers] (
		[Id]                     [uniqueidentifier] NOT NULL,
		[GroupId]                [uniqueidentifier] NOT NULL,
		[ParentId]               [uniqueidentifier] NOT NULL,
		[MachineName]            [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ServerName]             [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Enabled]                [bit] NOT NULL,
		[AuthenticationType]     [int] NOT NULL,
		[Username]               [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Password]               [nvarchar](2048) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ServerVersion]          [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[IsClustered]            [int] NOT NULL,
		[ConnectionTimeout]      [int] NOT NULL,
		[ExecutionTimeout]       [int] NOT NULL,
		[Encrypted]              [bit] NOT NULL,
		[DefaultDatabase]        [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CloudType]              [int] NOT NULL,
		CONSTRAINT [PK_MonitorServers]
		PRIMARY KEY
		CLUSTERED
		([Id])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [ApexSQL].[MonitorServers]
	ADD
	CONSTRAINT [DF_MonitorServers_Enabled]
	DEFAULT ((1)) FOR [Enabled]
GO
ALTER TABLE [ApexSQL].[MonitorServers]
	WITH CHECK
	ADD CONSTRAINT [FK_MonitorServers_MonitorGroups]
	FOREIGN KEY ([GroupId]) REFERENCES [ApexSQL].[MonitorGroups] ([Id])
ALTER TABLE [ApexSQL].[MonitorServers]
	CHECK CONSTRAINT [FK_MonitorServers_MonitorGroups]

GO
ALTER TABLE [ApexSQL].[MonitorServers]
	WITH CHECK
	ADD CONSTRAINT [FK_MonitorServers_MonitorMachines]
	FOREIGN KEY ([ParentId]) REFERENCES [ApexSQL].[MonitorMachines] ([Id])
ALTER TABLE [ApexSQL].[MonitorServers]
	CHECK CONSTRAINT [FK_MonitorServers_MonitorMachines]

GO
ALTER TABLE [ApexSQL].[MonitorServers] SET (LOCK_ESCALATION = TABLE)
GO

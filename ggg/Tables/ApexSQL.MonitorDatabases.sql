SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [ApexSQL].[MonitorDatabases] (
		[Id]               [uniqueidentifier] NOT NULL,
		[ParentId]         [uniqueidentifier] NOT NULL,
		[DatabaseId]       [int] NOT NULL,
		[DatabaseName]     [nvarchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Enabled]          [bit] NOT NULL,
		[Synchronized]     [bit] NOT NULL,
		CONSTRAINT [PK_MonitorDatabases]
		PRIMARY KEY
		CLUSTERED
		([Id])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [ApexSQL].[MonitorDatabases]
	WITH NOCHECK
	ADD CONSTRAINT [FK_MonitorDatabases_MonitorServers]
	FOREIGN KEY ([ParentId]) REFERENCES [ApexSQL].[MonitorServers] ([Id])
ALTER TABLE [ApexSQL].[MonitorDatabases]
	CHECK CONSTRAINT [FK_MonitorDatabases_MonitorServers]

GO
ALTER TABLE [ApexSQL].[MonitorDatabases] SET (LOCK_ESCALATION = TABLE)
GO

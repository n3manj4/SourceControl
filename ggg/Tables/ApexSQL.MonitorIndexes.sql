SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [ApexSQL].[MonitorIndexes] (
		[Id]                [uniqueidentifier] NOT NULL,
		[ParentId]          [uniqueidentifier] NOT NULL,
		[DatabaseId]        [smallint] NOT NULL,
		[DatabaseName]      [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TableId]           [int] NOT NULL,
		[TableName]         [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[IndexId]           [int] NOT NULL,
		[IndexName]         [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[IndexType]         [int] NOT NULL,
		[IsUnique]          [bit] NOT NULL,
		[IsPrimaryKey]      [bit] NOT NULL,
		[Enabled]           [bit] NOT NULL,
		[DataSpaceType]     [nvarchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK_MonitorIndexes]
		PRIMARY KEY
		CLUSTERED
		([Id])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [ApexSQL].[MonitorIndexes]
	WITH CHECK
	ADD CONSTRAINT [FK_MonitorIndexes_MonitorDatabases]
	FOREIGN KEY ([ParentId]) REFERENCES [ApexSQL].[MonitorDatabases] ([Id])
ALTER TABLE [ApexSQL].[MonitorIndexes]
	CHECK CONSTRAINT [FK_MonitorIndexes_MonitorDatabases]

GO
ALTER TABLE [ApexSQL].[MonitorIndexes] SET (LOCK_ESCALATION = TABLE)
GO

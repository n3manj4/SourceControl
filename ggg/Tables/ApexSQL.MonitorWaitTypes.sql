SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [ApexSQL].[MonitorWaitTypes] (
		[Id]                            [uniqueidentifier] NOT NULL,
		[WaitTypeName]                  [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Description]                   [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SupportedSQLServerVersion]     [int] NULL,
		[WaitCategoryId]                [int] NULL,
		[Excluded]                      [bit] NULL,
		[IsImportant]                   [bit] NULL,
		CONSTRAINT [PK_MonitorWaitTypes]
		PRIMARY KEY
		CLUSTERED
		([Id])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [ApexSQL].[MonitorWaitTypes]
	WITH NOCHECK
	ADD CONSTRAINT [FK_MonitorWaitTypes_MonitorWaitCategories]
	FOREIGN KEY ([WaitCategoryId]) REFERENCES [ApexSQL].[MonitorWaitCategories] ([Id])
ALTER TABLE [ApexSQL].[MonitorWaitTypes]
	CHECK CONSTRAINT [FK_MonitorWaitTypes_MonitorWaitCategories]

GO
ALTER TABLE [ApexSQL].[MonitorWaitTypes] SET (LOCK_ESCALATION = TABLE)
GO

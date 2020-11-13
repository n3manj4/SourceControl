SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [ApexSQL].[MonitorReports] (
		[Id]                [uniqueidentifier] NOT NULL,
		[Name]              [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CategoryId]        [uniqueidentifier] NOT NULL,
		[Metadata]          [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FilterOptions]     [int] NOT NULL,
		[JsonMetadata]      [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[IsTemplate]        [tinyint] NULL,
		CONSTRAINT [PK_MonitorReports]
		PRIMARY KEY
		CLUSTERED
		([Id])
	ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [ApexSQL].[MonitorReports]
	WITH CHECK
	ADD CONSTRAINT [FK_MonitorReports_MonitorReportCategories]
	FOREIGN KEY ([CategoryId]) REFERENCES [ApexSQL].[MonitorReportCategories] ([Id])
ALTER TABLE [ApexSQL].[MonitorReports]
	CHECK CONSTRAINT [FK_MonitorReports_MonitorReportCategories]

GO
ALTER TABLE [ApexSQL].[MonitorReports] SET (LOCK_ESCALATION = TABLE)
GO

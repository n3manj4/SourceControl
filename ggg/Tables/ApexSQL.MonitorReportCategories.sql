SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [ApexSQL].[MonitorReportCategories] (
		[Id]       [uniqueidentifier] NOT NULL,
		[Name]     [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		CONSTRAINT [PK_MonitorReportCategories]
		PRIMARY KEY
		CLUSTERED
		([Id])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [ApexSQL].[MonitorReportCategories] SET (LOCK_ESCALATION = TABLE)
GO

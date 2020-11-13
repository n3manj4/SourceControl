SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [ApexSQL].[MonitorAlertActionProfiles] (
		[Id]       [uniqueidentifier] NOT NULL,
		[Name]     [nvarchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[col]      [nchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK_MonitorAlertActionProfiles]
		PRIMARY KEY
		CLUSTERED
		([Id])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [ApexSQL].[MonitorAlertActionProfiles] SET (LOCK_ESCALATION = TABLE)
GO

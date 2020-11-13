SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [ApexSQL].[MonitorEmailProfiles] (
		[Id]                 [uniqueidentifier] NOT NULL,
		[Name]               [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ToAddress]          [nvarchar](320) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CcAddress]          [nvarchar](512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SmtpSettingsId]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_MonitorEmailProfiles]
		PRIMARY KEY
		CLUSTERED
		([Id])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [ApexSQL].[MonitorEmailProfiles]
	WITH CHECK
	ADD CONSTRAINT [FK_MonitorEmailProfiles_MonitorSmtpSettings]
	FOREIGN KEY ([SmtpSettingsId]) REFERENCES [ApexSQL].[MonitorSmtpSettings] ([Id])
ALTER TABLE [ApexSQL].[MonitorEmailProfiles]
	CHECK CONSTRAINT [FK_MonitorEmailProfiles_MonitorSmtpSettings]

GO
ALTER TABLE [ApexSQL].[MonitorEmailProfiles] SET (LOCK_ESCALATION = TABLE)
GO

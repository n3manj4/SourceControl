SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [ApexSQL].[MonitorSmtpSettings] (
		[Id]                      [uniqueidentifier] NOT NULL,
		[Host]                    [nvarchar](512) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Port]                    [int] NOT NULL,
		[EnableSSL]               [bit] NOT NULL,
		[UserName]                [nvarchar](320) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Password]                [nvarchar](512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[UseUsernameAsSender]     [bit] NOT NULL,
		[SenderAddress]           [nvarchar](320) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		CONSTRAINT [PK_MonitorSmtpSettings]
		PRIMARY KEY
		CLUSTERED
		([Id])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [ApexSQL].[MonitorSmtpSettings] SET (LOCK_ESCALATION = TABLE)
GO

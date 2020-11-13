SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [ApexSQL].[MonitorAlertActions] (
		[Id]                         [uniqueidentifier] NOT NULL,
		[ActionType]                 [int] NOT NULL,
		[ActionText]                 [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[OrderNumber]                [int] NULL,
		[Enabled]                    [bit] NOT NULL,
		[ProfileId]                  [uniqueidentifier] NOT NULL,
		[SnmpSettingsId]             [uniqueidentifier] NULL,
		[EmailProfileId]             [uniqueidentifier] NULL,
		[EmailFrequencyType]         [int] NULL,
		[NumberOfMinutes]            [int] NULL,
		[LastEmailScheduledTime]     [datetimeoffset](7) NULL,
		[EmailHighAlerts]            [bit] NULL,
		[EmailMediumAlerts]          [bit] NULL,
		[EmailLowAlerts]             [bit] NULL,
		CONSTRAINT [PK_MonitorAlertActions]
		PRIMARY KEY
		CLUSTERED
		([Id])
	ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [ApexSQL].[MonitorAlertActions] SET (LOCK_ESCALATION = TABLE)
GO

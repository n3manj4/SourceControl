SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [ApexSQL].[MonitorScheduler] (
		[Id]                  [uniqueidentifier] NOT NULL,
		[ScheduledObject]     [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Type]                [int] NULL,
		CONSTRAINT [PK_MonitorScheduler]
		PRIMARY KEY
		CLUSTERED
		([Id])
	ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [ApexSQL].[MonitorScheduler] SET (LOCK_ESCALATION = TABLE)
GO

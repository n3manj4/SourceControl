SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [ApexSQL].[MonitorDevices] (
		[Id]             [uniqueidentifier] NOT NULL,
		[ParentId]       [uniqueidentifier] NOT NULL,
		[DeviceName]     [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DeviceType]     [int] NOT NULL,
		[Enabled]        [bit] NOT NULL,
		CONSTRAINT [PK_MonitorDevices]
		PRIMARY KEY
		CLUSTERED
		([Id])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [ApexSQL].[MonitorDevices] SET (LOCK_ESCALATION = TABLE)
GO

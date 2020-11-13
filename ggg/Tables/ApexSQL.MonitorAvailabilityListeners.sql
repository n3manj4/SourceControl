SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [ApexSQL].[MonitorAvailabilityListeners] (
		[Id]                      [uniqueidentifier] NOT NULL,
		[ListenerId]              [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[AvailabilityGroupId]     [uniqueidentifier] NOT NULL,
		[DnsName]                 [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[IpAddress]               [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Port]                    [int] NOT NULL,
		CONSTRAINT [PK_MonitorAvailabilityListeners]
		PRIMARY KEY
		CLUSTERED
		([Id])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [ApexSQL].[MonitorAvailabilityListeners] SET (LOCK_ESCALATION = TABLE)
GO

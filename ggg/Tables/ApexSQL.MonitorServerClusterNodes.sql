SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [ApexSQL].[MonitorServerClusterNodes] (
		[Id]            [uniqueidentifier] NOT NULL,
		[MachineId]     [uniqueidentifier] NOT NULL,
		[ServerId]      [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_MonitorServerClusterNodes]
		PRIMARY KEY
		CLUSTERED
		([Id])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [ApexSQL].[MonitorServerClusterNodes] SET (LOCK_ESCALATION = TABLE)
GO

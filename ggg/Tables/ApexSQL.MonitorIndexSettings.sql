SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [ApexSQL].[MonitorIndexSettings] (
		[Id]                         [uniqueidentifier] NOT NULL,
		[ServerId]                   [uniqueidentifier] NOT NULL,
		[IndexMonitoringEnabled]     [bit] NOT NULL,
		[MinimumIndexSize]           [float] NOT NULL,
		CONSTRAINT [PK_MonitorIndexSettings]
		PRIMARY KEY
		CLUSTERED
		([Id])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [ApexSQL].[MonitorIndexSettings] SET (LOCK_ESCALATION = TABLE)
GO

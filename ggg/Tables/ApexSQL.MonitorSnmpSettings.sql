SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [ApexSQL].[MonitorSnmpSettings] (
		[Id]            [uniqueidentifier] NOT NULL,
		[Name]          [nvarchar](512) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Ip]            [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Port]          [int] NOT NULL,
		[Community]     [nvarchar](512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Version]       [int] NOT NULL,
		CONSTRAINT [PK_MonitorSnmpSettings]
		PRIMARY KEY
		CLUSTERED
		([Id])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [ApexSQL].[MonitorSnmpSettings] SET (LOCK_ESCALATION = TABLE)
GO

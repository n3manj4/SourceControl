SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [ApexSQL].[MonitorMachines] (
		[Id]              [uniqueidentifier] NOT NULL,
		[ParentId]        [uniqueidentifier] NOT NULL,
		[MachineName]     [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[IP]              [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Enabled]         [bit] NOT NULL,
		[Username]        [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Password]        [nvarchar](2048) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK_MonitorMachines]
		PRIMARY KEY
		CLUSTERED
		([Id])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [ApexSQL].[MonitorMachines] SET (LOCK_ESCALATION = TABLE)
GO

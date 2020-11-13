SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [ApexSQL].[MonitorGroups] (
		[Id]                      [uniqueidentifier] NOT NULL,
		[GroupId]                 [uniqueidentifier] NOT NULL,
		[GroupName]               [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Enabled]                 [bit] NOT NULL,
		[IsDefault]               [bit] NOT NULL,
		[AvailabilityGroupId]     [uniqueidentifier] NULL,
		CONSTRAINT [PK_MonitorGroups]
		PRIMARY KEY
		CLUSTERED
		([Id])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [ApexSQL].[MonitorGroups] SET (LOCK_ESCALATION = TABLE)
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [ApexSQL].[MonitorQueryLookupInfo] (
		[Id]           [uniqueidentifier] NOT NULL,
		[SourceId]     [uniqueidentifier] NOT NULL,
		[Name]         [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Type]         [int] NOT NULL,
		[Enabled]      [bit] NOT NULL,
		CONSTRAINT [PK_MonitorQueryLookupInfo]
		PRIMARY KEY
		CLUSTERED
		([Id])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [ApexSQL].[MonitorQueryLookupInfo] SET (LOCK_ESCALATION = TABLE)
GO

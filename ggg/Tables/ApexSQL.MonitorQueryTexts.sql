SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [ApexSQL].[MonitorQueryTexts] (
		[Id]            [uniqueidentifier] NOT NULL,
		[SourceId]      [uniqueidentifier] NOT NULL,
		[SqlHandle]     [binary](20) NOT NULL,
		[SqlText]       [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[QueryName]     [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Enabled]       [bit] NOT NULL,
		CONSTRAINT [PK_MonitorQueryTexts]
		PRIMARY KEY
		CLUSTERED
		([Id])
	ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IND_MonitorQueryTexts_Source_Id_SqlHandle]
	ON [ApexSQL].[MonitorQueryTexts] ([SourceId])
	INCLUDE ([Id], [SqlHandle])
	ON [PRIMARY]
GO
ALTER TABLE [ApexSQL].[MonitorQueryTexts] SET (LOCK_ESCALATION = TABLE)
GO

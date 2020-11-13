SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [ApexSQL].[MonitorDeadlocks] (
		[Id]                 [uniqueidentifier] NOT NULL,
		[SourceId]           [uniqueidentifier] NOT NULL,
		[DatabaseNameId]     [uniqueidentifier] NOT NULL,
		[TimeRaised]         [datetimeoffset](7) NOT NULL,
		[PlanXdl]            [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		CONSTRAINT [PK_MonitorDeadlocks]
		PRIMARY KEY
		CLUSTERED
		([Id])
	ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [ApexSQL].[MonitorDeadlocks] SET (LOCK_ESCALATION = TABLE)
GO

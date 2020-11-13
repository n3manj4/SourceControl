SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [ApexSQL].[MonitorQueryPlans] (
		[Id]             [uniqueidentifier] NOT NULL,
		[SourceId]       [uniqueidentifier] NOT NULL,
		[PlanHandle]     [varbinary](64) NOT NULL,
		[PlanXml]        [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK_MonitorQueryPlans]
		PRIMARY KEY
		CLUSTERED
		([Id])
	ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IND_MonitorQueryPlans_Source_Id_PlanlHandle]
	ON [ApexSQL].[MonitorQueryPlans] ([SourceId])
	INCLUDE ([Id], [PlanHandle])
	ON [PRIMARY]
GO
ALTER TABLE [ApexSQL].[MonitorQueryPlans] SET (LOCK_ESCALATION = TABLE)
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [ApexSQL].[MonitorPurgingTime] (
		[Id]                            [uniqueidentifier] NOT NULL,
		[SourceId]                      [uniqueidentifier] NOT NULL,
		[AutomatedPurgingOn]            [bit] NOT NULL,
		[AlertsPeriodOn]                [bit] NOT NULL,
		[MeasuredValuesPeriodOn]        [bit] NOT NULL,
		[QueryWaitsPeriodOn]            [bit] NOT NULL,
		[DeadlocksPeriodOn]             [bit] NOT NULL,
		[AlertsPeriodValue]             [int] NOT NULL,
		[MeasuredValuesPeriodValue]     [int] NOT NULL,
		[QueryWaitsPeriodValue]         [int] NOT NULL,
		[DeadlocksPeriodValue]          [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [ApexSQL].[MonitorPurgingTime] SET (LOCK_ESCALATION = TABLE)
GO

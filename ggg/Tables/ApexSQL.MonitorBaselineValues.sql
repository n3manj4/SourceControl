SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [ApexSQL].[MonitorBaselineValues] (
		[Id]                [uniqueidentifier] NOT NULL,
		[SourceId]          [uniqueidentifier] NOT NULL,
		[MeasurementId]     [uniqueidentifier] NOT NULL,
		[WaitTypeId]        [uniqueidentifier] NULL,
		[Average]           [float] NULL,
		[Min]               [float] NULL,
		[Max]               [float] NULL,
		[StdDeviation]      [float] NULL,
		[HourOfDay]         [int] NULL,
		[DayOfWeek]         [int] NULL,
		CONSTRAINT [PK_MonitorBaselineValue]
		PRIMARY KEY
		CLUSTERED
		([Id])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [ApexSQL].[MonitorBaselineValues]
	WITH CHECK
	ADD CONSTRAINT [FK_MonitorBaselineValues_MonitorWaitTypes]
	FOREIGN KEY ([WaitTypeId]) REFERENCES [ApexSQL].[MonitorWaitTypes] ([Id])
ALTER TABLE [ApexSQL].[MonitorBaselineValues]
	CHECK CONSTRAINT [FK_MonitorBaselineValues_MonitorWaitTypes]

GO
ALTER TABLE [ApexSQL].[MonitorBaselineValues] SET (LOCK_ESCALATION = TABLE)
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [ApexSQL].[MonitorMeasuredValues] (
		[Id]                [uniqueidentifier] NOT NULL,
		[SourceId]          [uniqueidentifier] NOT NULL,
		[MeasurementId]     [uniqueidentifier] NOT NULL,
		[WaitTypeId]        [uniqueidentifier] NULL,
		[Value]             [float] NULL,
		[MeasuredAt]        [datetimeoffset](7) NOT NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IND_MonitorMeasuredValues_Measurment_Source_MeasuredAt]
	ON [ApexSQL].[MonitorMeasuredValues] ([MeasuredAt], [SourceId], [MeasurementId])
	INCLUDE ([Id], [WaitTypeId], [Value])
	ON [PRIMARY]
GO
ALTER TABLE [ApexSQL].[MonitorMeasuredValues] SET (LOCK_ESCALATION = TABLE)
GO

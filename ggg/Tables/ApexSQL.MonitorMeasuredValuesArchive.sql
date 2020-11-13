SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [ApexSQL].[MonitorMeasuredValuesArchive] (
		[Id]                [uniqueidentifier] NOT NULL,
		[SourceId]          [uniqueidentifier] NOT NULL,
		[MeasurementId]     [uniqueidentifier] NOT NULL,
		[WaitTypeId]        [uniqueidentifier] NULL,
		[Values]            [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MeasuredAt]        [datetimeoffset](7) NOT NULL,
		[Periods]           [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IND_MonitorMeasuredValuesArchive_Measurment_Source_MeasuredAt]
	ON [ApexSQL].[MonitorMeasuredValuesArchive] ([MeasuredAt], [SourceId], [MeasurementId])
	INCLUDE ([Id], [WaitTypeId])
	ON [PRIMARY]
GO
ALTER TABLE [ApexSQL].[MonitorMeasuredValuesArchive] SET (LOCK_ESCALATION = TABLE)
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [ApexSQL].[MonitorMeasurementConfigs] (
		[Id]                            [uniqueidentifier] NOT NULL,
		[SourceId]                      [uniqueidentifier] NOT NULL,
		[MeasurementId]                 [uniqueidentifier] NOT NULL,
		[AlertEnabled]                  [bit] NOT NULL,
		[AlertOperator]                 [nchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[AlertThresholdCounter]         [int] NOT NULL,
		[AlertThresholdValueLow]        [float] NULL,
		[AlertThresholdValueMedium]     [float] NULL,
		[AlertThresholdValueHigh]       [float] NULL,
		[Period]                        [bigint] NOT NULL,
		[Enabled]                       [bit] NOT NULL,
		[Config]                        [bit] NOT NULL,
		[AlertActionProfileId]          [uniqueidentifier] NULL,
		[AlertUsingBaselines]           [bit] NOT NULL,
		[JsonOptions]                   [nvarchar](512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK_MonitorMeasurementConfigs]
		PRIMARY KEY
		CLUSTERED
		([Id])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [ApexSQL].[MonitorMeasurementConfigs]
	ADD
	CONSTRAINT [DF_MonitorMeasurementConfigs_Id]
	DEFAULT (newid()) FOR [Id]
GO
ALTER TABLE [ApexSQL].[MonitorMeasurementConfigs]
	ADD
	CONSTRAINT [DF_MonitorMeasurementConfigs_Config]
	DEFAULT ((0)) FOR [Config]
GO
ALTER TABLE [ApexSQL].[MonitorMeasurementConfigs]
	ADD
	CONSTRAINT [DF_MonitorMeasurementsConfigs_AlertThresholdCounter]
	DEFAULT ((0)) FOR [AlertThresholdCounter]
GO
ALTER TABLE [ApexSQL].[MonitorMeasurementConfigs]
	ADD
	CONSTRAINT [DF_MonitorMeasurementConfigs_Enabled]
	DEFAULT ((1)) FOR [Enabled]
GO
ALTER TABLE [ApexSQL].[MonitorMeasurementConfigs]
	WITH NOCHECK
	ADD CONSTRAINT [FK_MonitorMeasurementConfigs_MonitorMeasurements]
	FOREIGN KEY ([MeasurementId]) REFERENCES [ApexSQL].[MonitorMeasurements] ([Id])
ALTER TABLE [ApexSQL].[MonitorMeasurementConfigs]
	CHECK CONSTRAINT [FK_MonitorMeasurementConfigs_MonitorMeasurements]

GO
ALTER TABLE [ApexSQL].[MonitorMeasurementConfigs] SET (LOCK_ESCALATION = TABLE)
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [ApexSQL].[MonitorBaselineConfigs] (
		[Id]                       [uniqueidentifier] NOT NULL,
		[ServerId]                 [uniqueidentifier] NOT NULL,
		[MeasurementId]            [uniqueidentifier] NOT NULL,
		[FromDate]                 [datetimeoffset](7) NULL,
		[ToDate]                   [datetimeoffset](7) NULL,
		[AutomaticCalculation]     [bit] NOT NULL,
		CONSTRAINT [PK_MonitorBaselineConfigs]
		PRIMARY KEY
		CLUSTERED
		([Id])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [ApexSQL].[MonitorBaselineConfigs]
	WITH CHECK
	ADD CONSTRAINT [FK_MonitorBaselineConfigs_MonitorMeasurements]
	FOREIGN KEY ([MeasurementId]) REFERENCES [ApexSQL].[MonitorMeasurements] ([Id])
ALTER TABLE [ApexSQL].[MonitorBaselineConfigs]
	CHECK CONSTRAINT [FK_MonitorBaselineConfigs_MonitorMeasurements]

GO
ALTER TABLE [ApexSQL].[MonitorBaselineConfigs] SET (LOCK_ESCALATION = TABLE)
GO

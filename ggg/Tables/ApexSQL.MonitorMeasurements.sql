SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [ApexSQL].[MonitorMeasurements] (
		[Id]                            [uniqueidentifier] NOT NULL,
		[Type]                          [int] NOT NULL,
		[Group]                         [int] NOT NULL,
		[Name]                          [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Caption]                       [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Description]                   [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Tag]                           [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Enabled]                       [bit] NOT NULL,
		[UnitOfMeasurement]             [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[IsSimple]                      [bit] NOT NULL,
		[TriggersAlert]                 [bit] NOT NULL,
		[AlertEnabled]                  [bit] NOT NULL,
		[AlertOperator]                 [nchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[AlertThresholdCounter]         [int] NOT NULL,
		[AlertThresholdValueLow]        [float] NULL,
		[AlertThresholdValueMedium]     [float] NULL,
		[AlertThresholdValueHigh]       [float] NULL,
		[DefaultPeriod]                 [bigint] NOT NULL,
		[ReturnType]                    [int] NOT NULL,
		[Settings]                      [int] NOT NULL,
		[IsCustom]                      [bit] NOT NULL,
		[AlertUsingBaselines]           [bit] NOT NULL,
		[UsePercentScale]               [bit] NOT NULL,
		CONSTRAINT [PK_SettingsId]
		PRIMARY KEY
		CLUSTERED
		([Id])
	ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [ApexSQL].[MonitorMeasurements]
	ADD
	CONSTRAINT [CK_MonitorMeasurements_AlertThresholdCounter]
	CHECK
	([AlertThresholdCounter]>=(0))
GO
ALTER TABLE [ApexSQL].[MonitorMeasurements]
CHECK CONSTRAINT [CK_MonitorMeasurements_AlertThresholdCounter]
GO
ALTER TABLE [ApexSQL].[MonitorMeasurements]
	ADD
	CONSTRAINT [DF_MonitorMeasurements_Enabled]
	DEFAULT ((1)) FOR [Enabled]
GO
ALTER TABLE [ApexSQL].[MonitorMeasurements]
	ADD
	CONSTRAINT [DF_MonitorMeasurements_IsSimple]
	DEFAULT ((1)) FOR [IsSimple]
GO
ALTER TABLE [ApexSQL].[MonitorMeasurements]
	ADD
	CONSTRAINT [DF_MonitorMeasurements_TriggersAlert]
	DEFAULT ((0)) FOR [TriggersAlert]
GO
ALTER TABLE [ApexSQL].[MonitorMeasurements]
	ADD
	CONSTRAINT [DF_MonitorMeasurements_AlertEnabled]
	DEFAULT ((0)) FOR [AlertEnabled]
GO
ALTER TABLE [ApexSQL].[MonitorMeasurements]
	ADD
	CONSTRAINT [DF_MonitorMeasurements_AlertThresholdCounter]
	DEFAULT ((0)) FOR [AlertThresholdCounter]
GO
ALTER TABLE [ApexSQL].[MonitorMeasurements]
	WITH CHECK
	ADD CONSTRAINT [FK_MonitorMeasurements_GroupId_PK_MonitorMeasurementTypes_Id]
	FOREIGN KEY ([Type]) REFERENCES [ApexSQL].[MonitorMeasurementTypes] ([Id])
ALTER TABLE [ApexSQL].[MonitorMeasurements]
	CHECK CONSTRAINT [FK_MonitorMeasurements_GroupId_PK_MonitorMeasurementTypes_Id]

GO
ALTER TABLE [ApexSQL].[MonitorMeasurements]
	WITH CHECK
	ADD CONSTRAINT [FK_MonitorMeasurementGroups_Id]
	FOREIGN KEY ([Group]) REFERENCES [ApexSQL].[MonitorMeasurementGroups] ([Id])
ALTER TABLE [ApexSQL].[MonitorMeasurements]
	CHECK CONSTRAINT [FK_MonitorMeasurementGroups_Id]

GO
ALTER TABLE [ApexSQL].[MonitorMeasurements] SET (LOCK_ESCALATION = TABLE)
GO

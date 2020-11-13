SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [ApexSQL].[MonitorMeasurementGroups] (
		[Id]       [int] NOT NULL,
		[Name]     [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Type]     [int] NOT NULL,
		CONSTRAINT [PK_MonitorMeasurementGroups_Id]
		PRIMARY KEY
		CLUSTERED
		([Id])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [ApexSQL].[MonitorMeasurementGroups]
	WITH CHECK
	ADD CONSTRAINT [FK_MonitorMeasurementGroupsTypes_Id]
	FOREIGN KEY ([Type]) REFERENCES [ApexSQL].[MonitorMeasurementTypes] ([Id])
ALTER TABLE [ApexSQL].[MonitorMeasurementGroups]
	CHECK CONSTRAINT [FK_MonitorMeasurementGroupsTypes_Id]

GO
ALTER TABLE [ApexSQL].[MonitorMeasurementGroups] SET (LOCK_ESCALATION = TABLE)
GO

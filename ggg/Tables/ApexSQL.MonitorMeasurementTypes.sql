SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [ApexSQL].[MonitorMeasurementTypes] (
		[Id]       [int] NOT NULL,
		[Name]     [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		CONSTRAINT [PK_MonitorMeasurementTypes_Id]
		PRIMARY KEY
		CLUSTERED
		([Id])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [ApexSQL].[MonitorMeasurementTypes] SET (LOCK_ESCALATION = TABLE)
GO

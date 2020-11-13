SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [ApexSQL].[MonitorAlerts] (
		[Id]                  [uniqueidentifier] NOT NULL,
		[SourceId]            [uniqueidentifier] NOT NULL,
		[MeasurementId]       [uniqueidentifier] NOT NULL,
		[Name]                [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Severity]            [int] NOT NULL,
		[Checked]             [bit] NOT NULL,
		[State]               [int] NOT NULL,
		[Comment]             [nvarchar](2500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TimeRaised]          [datetimeoffset](7) NOT NULL,
		[Description]         [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[MeasuredValueId]     [uniqueidentifier] NOT NULL,
		[TimeResolved]        [datetimeoffset](7) NULL,
		[UserResolved]        [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		CONSTRAINT [PK_MonitorAlerts]
		PRIMARY KEY
		CLUSTERED
		([Id])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [ApexSQL].[MonitorAlerts]
	ADD
	CONSTRAINT [DF__MonitorAl__UserR__108B795B]
	DEFAULT ('') FOR [UserResolved]
GO
ALTER TABLE [ApexSQL].[MonitorAlerts]
	WITH NOCHECK
	ADD CONSTRAINT [FK_MonitorAlerts_MonitorMeasurements]
	FOREIGN KEY ([MeasurementId]) REFERENCES [ApexSQL].[MonitorMeasurements] ([Id])
ALTER TABLE [ApexSQL].[MonitorAlerts]
	CHECK CONSTRAINT [FK_MonitorAlerts_MonitorMeasurements]

GO
ALTER TABLE [ApexSQL].[MonitorAlerts] SET (LOCK_ESCALATION = TABLE)
GO

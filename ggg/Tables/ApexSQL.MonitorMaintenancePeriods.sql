SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [ApexSQL].[MonitorMaintenancePeriods] (
		[Id]                        [uniqueidentifier] NOT NULL,
		[MaintenancePeriodName]     [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[IsMonitoringDisabled]      [bit] NOT NULL,
		[IsAlertingDisabled]        [bit] NOT NULL,
		[ScheduleType]              [int] NOT NULL,
		[StartDateTime]             [datetimeoffset](7) NULL,
		[EndDateTime]               [datetimeoffset](7) NULL,
		[FrequencyType]             [int] NULL,
		[FrequencyInterval]         [int] NULL,
		[WeekDays]                  [int] NULL,
		[DayOfMonth]                [int] NULL,
		[StartTime]                 [datetimeoffset](7) NULL,
		[EndTime]                   [datetimeoffset](7) NULL,
		[Description]               [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SourceId]                  [uniqueidentifier] NOT NULL,
		[WeekOfMonth]               [int] NULL,
		[DayOfWeekOfMonth]          [int] NULL,
		[DisabledUntil]             [datetimeoffset](7) NOT NULL,
		CONSTRAINT [PK_MonitorMaintenancePeriods]
		PRIMARY KEY
		CLUSTERED
		([Id])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [ApexSQL].[MonitorMaintenancePeriods]
	ADD
	CONSTRAINT [DF__MonitorMa__Disab__2D27B809]
	DEFAULT ('0001-01-01 00:00:00.0000000 +00:00') FOR [DisabledUntil]
GO
ALTER TABLE [ApexSQL].[MonitorMaintenancePeriods]
	WITH CHECK
	ADD CONSTRAINT [FK_MonitorMaintenancePeriods_MonitorServers]
	FOREIGN KEY ([SourceId]) REFERENCES [ApexSQL].[MonitorServers] ([Id])
ALTER TABLE [ApexSQL].[MonitorMaintenancePeriods]
	CHECK CONSTRAINT [FK_MonitorMaintenancePeriods_MonitorServers]

GO
ALTER TABLE [ApexSQL].[MonitorMaintenancePeriods] SET (LOCK_ESCALATION = TABLE)
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [ApexSQL].[MonitorUsers] (
		[Id]                  [uniqueidentifier] NOT NULL,
		[Username]            [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Password]            [nvarchar](2048) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ParentUser]          [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Role]                [int] NOT NULL,
		[HashCode]            [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Options]             [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[UserPermissions]     [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK_MonitorUsers]
		PRIMARY KEY
		CLUSTERED
		([Id])
	ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [ApexSQL].[MonitorUsers] SET (LOCK_ESCALATION = TABLE)
GO

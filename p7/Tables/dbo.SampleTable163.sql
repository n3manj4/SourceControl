SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SampleTable163] (
		[PersonID]        [int] NULL,
		[LastName]        [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FirstName]       [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Address]         [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[City]            [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new1]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new2]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new3]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new4]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new8]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new9]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [dbo].[SampleTable163] SET (LOCK_ESCALATION = TABLE)
GO

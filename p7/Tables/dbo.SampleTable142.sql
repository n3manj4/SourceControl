SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SampleTable142] (
		[PersonID]         [int] NULL,
		[LastName]         [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FirstName]        [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Address]          [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[City]             [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[wwcolumn_new]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new1]      [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [dbo].[SampleTable142] SET (LOCK_ESCALATION = TABLE)
GO

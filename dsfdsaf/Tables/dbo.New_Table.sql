SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[New_Table] (
		[NameID]           [int] NOT NULL,
		[Address]          [nchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PhoneNumber]      [int] NULL,
		[Date]             [date] NULL,
		[ModifiedDate]     [date] NULL,
		[01]               [int] NULL,
		[test]             [nchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[cvczvf]           [nchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [dbo].[New_Table] SET (LOCK_ESCALATION = TABLE)
GO

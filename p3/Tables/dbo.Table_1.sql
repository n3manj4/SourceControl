SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Table_1] (
		[asdf]        [nchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[sdfsda]      [int] NULL,
		[zsdafaf]     [real] NULL
)
GO
ALTER TABLE [dbo].[Table_1] SET (LOCK_ESCALATION = TABLE)
GO
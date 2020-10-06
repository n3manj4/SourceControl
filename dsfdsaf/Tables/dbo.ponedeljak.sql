SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ponedeljak] (
		[test]      [int] NOT NULL,
		[test1]     [int] NULL,
		[test2]     [nchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK_ponedeljak]
		PRIMARY KEY
		CLUSTERED
		([test])
)
GO
ALTER TABLE [dbo].[ponedeljak] SET (LOCK_ESCALATION = TABLE)
GO

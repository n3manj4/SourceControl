SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Other_edit_checkout_lock] (
		[1]     [nchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [dbo].[Other_edit_checkout_lock] SET (LOCK_ESCALATION = TABLE)
GO

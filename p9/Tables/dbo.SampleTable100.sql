SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SampleTable100] (
		[PersonID]         [int] NULL,
		[LastName]         [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FirstName]        [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Address]          [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[City]             [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new1new]      [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new2]      [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new3]      [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new5]      [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new6]      [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new7]      [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new8]      [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new9]      [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new10]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new11]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new12]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new13]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new14]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new15]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new16]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new17]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new18]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new19]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new20]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new21]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new]       [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new4]      [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new23]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new24]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new25]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new26]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new27]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new28]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new29]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new30]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new31]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new32]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new33]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new34]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new35]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new36]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new37]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new38]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new39]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new40]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new41]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new42]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new43]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new44]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new45]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new46]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new47]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new48]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new49]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new50]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new51]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new52]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new53]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new54]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new55]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new56]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new57]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new58]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new59]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new60]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new61]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new63]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new64]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new65]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new66]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new67]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new68]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new69]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new70]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new71]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new72]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new73]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new76]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new77]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new78]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new79]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new80]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new81]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[column_new82]     [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[name1]            [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[name2]            [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[name3]            [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[name4]            [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[name5]            [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[name6]            [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[name7]            [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[name8]            [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[name9]            [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[name10]           [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[name11]           [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[name12]           [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[name13]           [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[name14]           [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[name15]           [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[name16]           [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[name17]           [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[name18]           [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[name19]           [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[name20]           [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[name21]           [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[name22]           [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[name23]           [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[name25]           [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[name26]           [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[name27]           [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[name28]           [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[name29]           [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[a1]               [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[a2]               [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[c1]               [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[c2]               [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[c3]               [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [dbo].[SampleTable100] SET (LOCK_ESCALATION = TABLE)
GO

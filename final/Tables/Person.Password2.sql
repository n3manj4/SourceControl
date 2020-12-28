SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [Person].[Password2] (
		[BusinessEntityID]     [int] NOT NULL,
		[PasswordHash]         [varchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PasswordSalt]         [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[rowguid]              [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[ModifiedDate]         [datetime] NOT NULL,
		CONSTRAINT [PK_Password_BusinessEntityID]
		PRIMARY KEY
		CLUSTERED
		([BusinessEntityID])
	ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'Person', 'TABLE', N'Password2', 'INDEX', N'PK_Password_BusinessEntityID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'Person', 'TABLE', N'Password2', 'CONSTRAINT', N'PK_Password_BusinessEntityID'
GO
ALTER TABLE [Person].[Password2]
	ADD
	CONSTRAINT [DF_Password_rowguid]
	DEFAULT (newid()) FOR [rowguid]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Default constraint value of NEWID()', 'SCHEMA', N'Person', 'TABLE', N'Password2', 'CONSTRAINT', N'DF_Password_rowguid'
GO
ALTER TABLE [Person].[Password2]
	ADD
	CONSTRAINT [DF_Password_ModifiedDate]
	DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'Person', 'TABLE', N'Password2', 'CONSTRAINT', N'DF_Password_ModifiedDate'
GO
ALTER TABLE [Person].[Password2]
	WITH CHECK
	ADD CONSTRAINT [FK_Password_Person_BusinessEntityID]
	FOREIGN KEY ([BusinessEntityID]) REFERENCES [Person].[Person] ([BusinessEntityID])
ALTER TABLE [Person].[Password2]
	CHECK CONSTRAINT [FK_Password_Person_BusinessEntityID]

GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Person.BusinessEntityID.', 'SCHEMA', N'Person', 'TABLE', N'Password2', 'CONSTRAINT', N'FK_Password_Person_BusinessEntityID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'One way hashed authentication information', 'SCHEMA', N'Person', 'TABLE', N'Password2', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Password for the e-mail account.', 'SCHEMA', N'Person', 'TABLE', N'Password2', 'COLUMN', N'PasswordHash'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Random value concatenated with the password string before the password is hashed.', 'SCHEMA', N'Person', 'TABLE', N'Password2', 'COLUMN', N'PasswordSalt'
GO
EXEC sp_addextendedproperty N'MS_Description', N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.', 'SCHEMA', N'Person', 'TABLE', N'Password2', 'COLUMN', N'rowguid'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Date and time the record was last updated.', 'SCHEMA', N'Person', 'TABLE', N'Password2', 'COLUMN', N'ModifiedDate'
GO
ALTER TABLE [Person].[Password2] SET (LOCK_ESCALATION = TABLE)
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [HumanResources].[Employeeeeee] (
		[BusinessEntityID]      [int] NOT NULL,
		[NationalIDNumber]      [nvarchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[LoginID]               [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[OrganizationNode]      [hierarchyid] NULL,
		[OrganizationLevel]     AS ([OrganizationNode].[GetLevel]()),
		[JobTitle]              [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[BirthDate]             [date] NOT NULL,
		[MaritalStatus]         [nchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Gender]                [nchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[HireDate]              [date] NOT NULL,
		[SalariedFlag]          [dbo].[Flag] NOT NULL,
		[VacationHours]         [smallint] NOT NULL,
		[SickLeaveHours]        [smallint] NOT NULL,
		[CurrentFlag]           [dbo].[Flag] NOT NULL,
		[rowguid]               [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[ModifiedDate]          [datetime] NOT NULL,
		[fdsafad]               [nchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[adf]                   [nchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[dsfa]                  [nchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[aaaa]                  [nchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK_Employee_BusinessEntityID]
		PRIMARY KEY
		CLUSTERED
		([BusinessEntityID])
	ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'HumanResources', 'TABLE', N'Employeeeeee', 'INDEX', N'PK_Employee_BusinessEntityID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'HumanResources', 'TABLE', N'Employeeeeee', 'CONSTRAINT', N'PK_Employee_BusinessEntityID'
GO
ALTER TABLE [HumanResources].[Employeeeeee]
	ADD
	CONSTRAINT [CK_Employee_BirthDate]
	CHECK
	([BirthDate]>='1930-01-01' AND [BirthDate]<=dateadd(year,(-18),getdate()))
GO
EXEC sp_addextendedproperty N'MS_Description', N'Check constraint [BirthDate] >= ''1930-01-01'' AND [BirthDate] <= dateadd(year,(-18),GETDATE())', 'SCHEMA', N'HumanResources', 'TABLE', N'Employeeeeee', 'CONSTRAINT', N'CK_Employee_BirthDate'
GO
ALTER TABLE [HumanResources].[Employeeeeee]
CHECK CONSTRAINT [CK_Employee_BirthDate]
GO
ALTER TABLE [HumanResources].[Employeeeeee]
	ADD
	CONSTRAINT [CK_Employee_MaritalStatus]
	CHECK
	(upper([MaritalStatus])='S' OR upper([MaritalStatus])='M')
GO
EXEC sp_addextendedproperty N'MS_Description', N'Check constraint [MaritalStatus]=''s'' OR [MaritalStatus]=''m'' OR [MaritalStatus]=''S'' OR [MaritalStatus]=''M''', 'SCHEMA', N'HumanResources', 'TABLE', N'Employeeeeee', 'CONSTRAINT', N'CK_Employee_MaritalStatus'
GO
ALTER TABLE [HumanResources].[Employeeeeee]
CHECK CONSTRAINT [CK_Employee_MaritalStatus]
GO
ALTER TABLE [HumanResources].[Employeeeeee]
	ADD
	CONSTRAINT [CK_Employee_HireDate]
	CHECK
	([HireDate]>='1996-07-01' AND [HireDate]<=dateadd(day,(1),getdate()))
GO
EXEC sp_addextendedproperty N'MS_Description', N'Check constraint [HireDate] >= ''1996-07-01'' AND [HireDate] <= dateadd(day,(1),GETDATE())', 'SCHEMA', N'HumanResources', 'TABLE', N'Employeeeeee', 'CONSTRAINT', N'CK_Employee_HireDate'
GO
ALTER TABLE [HumanResources].[Employeeeeee]
CHECK CONSTRAINT [CK_Employee_HireDate]
GO
ALTER TABLE [HumanResources].[Employeeeeee]
	ADD
	CONSTRAINT [CK_Employee_Gender]
	CHECK
	(upper([Gender])='F' OR upper([Gender])='M')
GO
EXEC sp_addextendedproperty N'MS_Description', N'Check constraint [Gender]=''f'' OR [Gender]=''m'' OR [Gender]=''F'' OR [Gender]=''M''', 'SCHEMA', N'HumanResources', 'TABLE', N'Employeeeeee', 'CONSTRAINT', N'CK_Employee_Gender'
GO
ALTER TABLE [HumanResources].[Employeeeeee]
CHECK CONSTRAINT [CK_Employee_Gender]
GO
ALTER TABLE [HumanResources].[Employeeeeee]
	ADD
	CONSTRAINT [CK_Employee_VacationHours]
	CHECK
	([VacationHours]>=(-40) AND [VacationHours]<=(240))
GO
EXEC sp_addextendedproperty N'MS_Description', N'Check constraint [VacationHours] >= (-40) AND [VacationHours] <= (240)', 'SCHEMA', N'HumanResources', 'TABLE', N'Employeeeeee', 'CONSTRAINT', N'CK_Employee_VacationHours'
GO
ALTER TABLE [HumanResources].[Employeeeeee]
CHECK CONSTRAINT [CK_Employee_VacationHours]
GO
ALTER TABLE [HumanResources].[Employeeeeee]
	ADD
	CONSTRAINT [CK_Employee_SickLeaveHours]
	CHECK
	([SickLeaveHours]>=(0) AND [SickLeaveHours]<=(120))
GO
EXEC sp_addextendedproperty N'MS_Description', N'Check constraint [SickLeaveHours] >= (0) AND [SickLeaveHours] <= (120)', 'SCHEMA', N'HumanResources', 'TABLE', N'Employeeeeee', 'CONSTRAINT', N'CK_Employee_SickLeaveHours'
GO
ALTER TABLE [HumanResources].[Employeeeeee]
CHECK CONSTRAINT [CK_Employee_SickLeaveHours]
GO
ALTER TABLE [HumanResources].[Employeeeeee]
	ADD
	CONSTRAINT [DF_Employee_SalariedFlag]
	DEFAULT ((1)) FOR [SalariedFlag]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Default constraint value of 1 (TRUE)', 'SCHEMA', N'HumanResources', 'TABLE', N'Employeeeeee', 'CONSTRAINT', N'DF_Employee_SalariedFlag'
GO
ALTER TABLE [HumanResources].[Employeeeeee]
	ADD
	CONSTRAINT [DF_Employee_VacationHours]
	DEFAULT ((0)) FOR [VacationHours]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Default constraint value of 0', 'SCHEMA', N'HumanResources', 'TABLE', N'Employeeeeee', 'CONSTRAINT', N'DF_Employee_VacationHours'
GO
ALTER TABLE [HumanResources].[Employeeeeee]
	ADD
	CONSTRAINT [DF_Employee_SickLeaveHours]
	DEFAULT ((0)) FOR [SickLeaveHours]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Default constraint value of 0', 'SCHEMA', N'HumanResources', 'TABLE', N'Employeeeeee', 'CONSTRAINT', N'DF_Employee_SickLeaveHours'
GO
ALTER TABLE [HumanResources].[Employeeeeee]
	ADD
	CONSTRAINT [DF_Employee_CurrentFlag]
	DEFAULT ((1)) FOR [CurrentFlag]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Default constraint value of 1', 'SCHEMA', N'HumanResources', 'TABLE', N'Employeeeeee', 'CONSTRAINT', N'DF_Employee_CurrentFlag'
GO
ALTER TABLE [HumanResources].[Employeeeeee]
	ADD
	CONSTRAINT [DF_Employee_rowguid]
	DEFAULT (newid()) FOR [rowguid]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Default constraint value of NEWID()', 'SCHEMA', N'HumanResources', 'TABLE', N'Employeeeeee', 'CONSTRAINT', N'DF_Employee_rowguid'
GO
ALTER TABLE [HumanResources].[Employeeeeee]
	ADD
	CONSTRAINT [DF_Employee_ModifiedDate]
	DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'HumanResources', 'TABLE', N'Employeeeeee', 'CONSTRAINT', N'DF_Employee_ModifiedDate'
GO
ALTER TABLE [HumanResources].[Employeeeeee]
	WITH CHECK
	ADD CONSTRAINT [FK_Employee_Person_BusinessEntityID]
	FOREIGN KEY ([BusinessEntityID]) REFERENCES [Person].[Person] ([BusinessEntityID])
ALTER TABLE [HumanResources].[Employeeeeee]
	CHECK CONSTRAINT [FK_Employee_Person_BusinessEntityID]

GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Person.BusinessEntityID.', 'SCHEMA', N'HumanResources', 'TABLE', N'Employeeeeee', 'CONSTRAINT', N'FK_Employee_Person_BusinessEntityID'
GO
CREATE NONCLUSTERED INDEX [IX_Employee_OrganizationNode]
	ON [HumanResources].[Employeeeeee] ([OrganizationNode])
	ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Unique nonclustered index.', 'SCHEMA', N'HumanResources', 'TABLE', N'Employeeeeee', 'INDEX', N'IX_Employee_OrganizationNode'
GO
CREATE NONCLUSTERED INDEX [IX_Employee_OrganizationLevel_OrganizationNode]
	ON [HumanResources].[Employeeeeee] ([OrganizationLevel], [OrganizationNode])
	ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Unique nonclustered index.', 'SCHEMA', N'HumanResources', 'TABLE', N'Employeeeeee', 'INDEX', N'IX_Employee_OrganizationLevel_OrganizationNode'
GO
CREATE UNIQUE NONCLUSTERED INDEX [AK_Employee_LoginID]
	ON [HumanResources].[Employeeeeee] ([LoginID])
	ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Unique nonclustered index.', 'SCHEMA', N'HumanResources', 'TABLE', N'Employeeeeee', 'INDEX', N'AK_Employee_LoginID'
GO
CREATE UNIQUE NONCLUSTERED INDEX [AK_Employee_NationalIDNumber]
	ON [HumanResources].[Employeeeeee] ([NationalIDNumber])
	ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Unique nonclustered index.', 'SCHEMA', N'HumanResources', 'TABLE', N'Employeeeeee', 'INDEX', N'AK_Employee_NationalIDNumber'
GO
CREATE UNIQUE NONCLUSTERED INDEX [AK_Employee_rowguid]
	ON [HumanResources].[Employeeeeee] ([rowguid])
	ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Unique nonclustered index. Used to support replication samples.', 'SCHEMA', N'HumanResources', 'TABLE', N'Employeeeeee', 'INDEX', N'AK_Employee_rowguid'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Employee information such as salary, department, and title.', 'SCHEMA', N'HumanResources', 'TABLE', N'Employeeeeee', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key for Employee records.  Foreign key to BusinessEntity.BusinessEntityID.', 'SCHEMA', N'HumanResources', 'TABLE', N'Employeeeeee', 'COLUMN', N'BusinessEntityID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Unique national identification number such as a social security number.', 'SCHEMA', N'HumanResources', 'TABLE', N'Employeeeeee', 'COLUMN', N'NationalIDNumber'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Network login.', 'SCHEMA', N'HumanResources', 'TABLE', N'Employeeeeee', 'COLUMN', N'LoginID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Where the employee is located in corporate hierarchy.', 'SCHEMA', N'HumanResources', 'TABLE', N'Employeeeeee', 'COLUMN', N'OrganizationNode'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The depth of the employee in the corporate hierarchy.', 'SCHEMA', N'HumanResources', 'TABLE', N'Employeeeeee', 'COLUMN', N'OrganizationLevel'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Work title such as Buyer or Sales Representative.', 'SCHEMA', N'HumanResources', 'TABLE', N'Employeeeeee', 'COLUMN', N'JobTitle'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Date of birth.', 'SCHEMA', N'HumanResources', 'TABLE', N'Employeeeeee', 'COLUMN', N'BirthDate'
GO
EXEC sp_addextendedproperty N'MS_Description', N'M = Married, S = Single', 'SCHEMA', N'HumanResources', 'TABLE', N'Employeeeeee', 'COLUMN', N'MaritalStatus'
GO
EXEC sp_addextendedproperty N'MS_Description', N'M = Male, F = Female', 'SCHEMA', N'HumanResources', 'TABLE', N'Employeeeeee', 'COLUMN', N'Gender'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Employee hired on this date.', 'SCHEMA', N'HumanResources', 'TABLE', N'Employeeeeee', 'COLUMN', N'HireDate'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Job classification. 0 = Hourly, not exempt from collective bargaining. 1 = Salaried, exempt from collective bargaining.', 'SCHEMA', N'HumanResources', 'TABLE', N'Employeeeeee', 'COLUMN', N'SalariedFlag'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Number of available vacation hours.', 'SCHEMA', N'HumanResources', 'TABLE', N'Employeeeeee', 'COLUMN', N'VacationHours'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Number of available sick leave hours.', 'SCHEMA', N'HumanResources', 'TABLE', N'Employeeeeee', 'COLUMN', N'SickLeaveHours'
GO
EXEC sp_addextendedproperty N'MS_Description', N'0 = Inactive, 1 = Active', 'SCHEMA', N'HumanResources', 'TABLE', N'Employeeeeee', 'COLUMN', N'CurrentFlag'
GO
EXEC sp_addextendedproperty N'MS_Description', N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.', 'SCHEMA', N'HumanResources', 'TABLE', N'Employeeeeee', 'COLUMN', N'rowguid'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Date and time the record was last updated.', 'SCHEMA', N'HumanResources', 'TABLE', N'Employeeeeee', 'COLUMN', N'ModifiedDate'
GO
ALTER TABLE [HumanResources].[Employeeeeee] SET (LOCK_ESCALATION = TABLE)
GO

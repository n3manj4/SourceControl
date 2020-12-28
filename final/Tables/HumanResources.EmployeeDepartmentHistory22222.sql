SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [HumanResources].[EmployeeDepartmentHistory22222] (
		[BusinessEntityID]     [int] NOT NULL,
		[DepartmentID]         [smallint] NOT NULL,
		[ShiftID]              [tinyint] NOT NULL,
		[StartDate]            [date] NOT NULL,
		[EndDate]              [date] NULL,
		[ModifiedDate]         [datetime] NOT NULL,
		[sdfg]                 [nchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK_EmployeeDepartmentHistory_BusinessEntityID_StartDate_DepartmentID]
		PRIMARY KEY
		CLUSTERED
		([BusinessEntityID], [StartDate], [DepartmentID], [ShiftID])
	ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeeDepartmentHistory22222', 'INDEX', N'PK_EmployeeDepartmentHistory_BusinessEntityID_StartDate_DepartmentID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeeDepartmentHistory22222', 'CONSTRAINT', N'PK_EmployeeDepartmentHistory_BusinessEntityID_StartDate_DepartmentID'
GO
ALTER TABLE [HumanResources].[EmployeeDepartmentHistory22222]
	ADD
	CONSTRAINT [CK_EmployeeDepartmentHistory_EndDate]
	CHECK
	([EndDate]>=[StartDate] OR [EndDate] IS NULL)
GO
EXEC sp_addextendedproperty N'MS_Description', N'Check constraint [EndDate] >= [StartDate] OR [EndDate] IS NUL', 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeeDepartmentHistory22222', 'CONSTRAINT', N'CK_EmployeeDepartmentHistory_EndDate'
GO
ALTER TABLE [HumanResources].[EmployeeDepartmentHistory22222]
CHECK CONSTRAINT [CK_EmployeeDepartmentHistory_EndDate]
GO
ALTER TABLE [HumanResources].[EmployeeDepartmentHistory22222]
	ADD
	CONSTRAINT [DF_EmployeeDepartmentHistory_ModifiedDate]
	DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeeDepartmentHistory22222', 'CONSTRAINT', N'DF_EmployeeDepartmentHistory_ModifiedDate'
GO
ALTER TABLE [HumanResources].[EmployeeDepartmentHistory22222]
	WITH CHECK
	ADD CONSTRAINT [FK_EmployeeDepartmentHistory_Department_DepartmentID]
	FOREIGN KEY ([DepartmentID]) REFERENCES [HumanResources].[Department] ([DepartmentID])
ALTER TABLE [HumanResources].[EmployeeDepartmentHistory22222]
	CHECK CONSTRAINT [FK_EmployeeDepartmentHistory_Department_DepartmentID]

GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Department.DepartmentID.', 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeeDepartmentHistory22222', 'CONSTRAINT', N'FK_EmployeeDepartmentHistory_Department_DepartmentID'
GO
ALTER TABLE [HumanResources].[EmployeeDepartmentHistory22222]
	WITH CHECK
	ADD CONSTRAINT [FK_EmployeeDepartmentHistory_Employee_BusinessEntityID]
	FOREIGN KEY ([BusinessEntityID]) REFERENCES [HumanResources].[Employeeeeee] ([BusinessEntityID])
ALTER TABLE [HumanResources].[EmployeeDepartmentHistory22222]
	CHECK CONSTRAINT [FK_EmployeeDepartmentHistory_Employee_BusinessEntityID]

GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Employee.EmployeeID.', 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeeDepartmentHistory22222', 'CONSTRAINT', N'FK_EmployeeDepartmentHistory_Employee_BusinessEntityID'
GO
ALTER TABLE [HumanResources].[EmployeeDepartmentHistory22222]
	WITH CHECK
	ADD CONSTRAINT [FK_EmployeeDepartmentHistory_Shift_ShiftID]
	FOREIGN KEY ([ShiftID]) REFERENCES [HumanResources].[Shift] ([ShiftID])
ALTER TABLE [HumanResources].[EmployeeDepartmentHistory22222]
	CHECK CONSTRAINT [FK_EmployeeDepartmentHistory_Shift_ShiftID]

GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing Shift.ShiftID', 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeeDepartmentHistory22222', 'CONSTRAINT', N'FK_EmployeeDepartmentHistory_Shift_ShiftID'
GO
CREATE NONCLUSTERED INDEX [IX_EmployeeDepartmentHistory_DepartmentID]
	ON [HumanResources].[EmployeeDepartmentHistory22222] ([DepartmentID])
	ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Nonclustered index.', 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeeDepartmentHistory22222', 'INDEX', N'IX_EmployeeDepartmentHistory_DepartmentID'
GO
CREATE NONCLUSTERED INDEX [IX_EmployeeDepartmentHistory_ShiftID]
	ON [HumanResources].[EmployeeDepartmentHistory22222] ([ShiftID])
	ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Nonclustered index.', 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeeDepartmentHistory22222', 'INDEX', N'IX_EmployeeDepartmentHistory_ShiftID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Employee department transfers.', 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeeDepartmentHistory22222', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Employee identification number. Foreign key to Employee.BusinessEntityID.', 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeeDepartmentHistory22222', 'COLUMN', N'BusinessEntityID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Department in which the employee worked including currently. Foreign key to Department.DepartmentID.', 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeeDepartmentHistory22222', 'COLUMN', N'DepartmentID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Identifies which 8-hour shift the employee works. Foreign key to Shift.Shift.ID.', 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeeDepartmentHistory22222', 'COLUMN', N'ShiftID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Date the employee started work in the department.', 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeeDepartmentHistory22222', 'COLUMN', N'StartDate'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Date the employee left the department. NULL = Current department.', 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeeDepartmentHistory22222', 'COLUMN', N'EndDate'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Date and time the record was last updated.', 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeeDepartmentHistory22222', 'COLUMN', N'ModifiedDate'
GO
ALTER TABLE [HumanResources].[EmployeeDepartmentHistory22222] SET (LOCK_ESCALATION = TABLE)
GO

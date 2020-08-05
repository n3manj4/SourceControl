SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [SalesLT].[SalesOrderDetail] (
		[SalesOrderID]           [int] NOT NULL,
		[SalesOrderDetailID]     [int] IDENTITY(1, 1) NOT NULL,
		[OrderQty]               [smallint] NOT NULL,
		[ProductID]              [int] NOT NULL,
		[UnitPrice]              [money] NOT NULL,
		[UnitPriceDiscount]      [money] NOT NULL,
		[LineTotal]              AS (isnull(([UnitPrice]*((1.0)-[UnitPriceDiscount]))*[OrderQty],(0.0))),
		[rowguid]                [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[ModifiedDate]           [datetime] NOT NULL,
		CONSTRAINT [AK_SalesOrderDetail_rowguid]
		UNIQUE
		NONCLUSTERED
		([rowguid])
		ON [PRIMARY],
		CONSTRAINT [PK_SalesOrderDetail_SalesOrderID_SalesOrderDetailID]
		PRIMARY KEY
		CLUSTERED
		([SalesOrderID], [SalesOrderDetailID])
	ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Clustered index created by a primary key constraint.', 'SCHEMA', N'SalesLT', 'TABLE', N'SalesOrderDetail', 'INDEX', N'PK_SalesOrderDetail_SalesOrderID_SalesOrderDetailID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key (clustered) constraint', 'SCHEMA', N'SalesLT', 'TABLE', N'SalesOrderDetail', 'CONSTRAINT', N'PK_SalesOrderDetail_SalesOrderID_SalesOrderDetailID'
GO
ALTER TABLE [SalesLT].[SalesOrderDetail]
	WITH NOCHECK
	ADD
	CONSTRAINT [CK_SalesOrderDetail_OrderQty]
	CHECK
	([OrderQty]>(0))
GO
EXEC sp_addextendedproperty N'MS_Description', N'Check constraint [OrderQty] > (0)', 'SCHEMA', N'SalesLT', 'TABLE', N'SalesOrderDetail', 'CONSTRAINT', N'CK_SalesOrderDetail_OrderQty'
GO
ALTER TABLE [SalesLT].[SalesOrderDetail]
CHECK CONSTRAINT [CK_SalesOrderDetail_OrderQty]
GO
ALTER TABLE [SalesLT].[SalesOrderDetail]
	WITH NOCHECK
	ADD
	CONSTRAINT [CK_SalesOrderDetail_UnitPrice]
	CHECK
	([UnitPrice]>=(0.00))
GO
EXEC sp_addextendedproperty N'MS_Description', N'Check constraint [UnitPrice] >= (0.00)', 'SCHEMA', N'SalesLT', 'TABLE', N'SalesOrderDetail', 'CONSTRAINT', N'CK_SalesOrderDetail_UnitPrice'
GO
ALTER TABLE [SalesLT].[SalesOrderDetail]
CHECK CONSTRAINT [CK_SalesOrderDetail_UnitPrice]
GO
ALTER TABLE [SalesLT].[SalesOrderDetail]
	WITH NOCHECK
	ADD
	CONSTRAINT [CK_SalesOrderDetail_UnitPriceDiscount]
	CHECK
	([UnitPriceDiscount]>=(0.00))
GO
EXEC sp_addextendedproperty N'MS_Description', N'Check constraint [UnitPriceDiscount] >= (0.00)', 'SCHEMA', N'SalesLT', 'TABLE', N'SalesOrderDetail', 'CONSTRAINT', N'CK_SalesOrderDetail_UnitPriceDiscount'
GO
ALTER TABLE [SalesLT].[SalesOrderDetail]
CHECK CONSTRAINT [CK_SalesOrderDetail_UnitPriceDiscount]
GO
ALTER TABLE [SalesLT].[SalesOrderDetail]
	ADD
	CONSTRAINT [DF_SalesOrderDetail_UnitPriceDiscount]
	DEFAULT ((0.0)) FOR [UnitPriceDiscount]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Default constraint value of 0.0', 'SCHEMA', N'SalesLT', 'TABLE', N'SalesOrderDetail', 'CONSTRAINT', N'DF_SalesOrderDetail_UnitPriceDiscount'
GO
ALTER TABLE [SalesLT].[SalesOrderDetail]
	ADD
	CONSTRAINT [DF_SalesOrderDetail_rowguid]
	DEFAULT (newid()) FOR [rowguid]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Default constraint value of NEWID()', 'SCHEMA', N'SalesLT', 'TABLE', N'SalesOrderDetail', 'CONSTRAINT', N'DF_SalesOrderDetail_rowguid'
GO
ALTER TABLE [SalesLT].[SalesOrderDetail]
	ADD
	CONSTRAINT [DF_SalesOrderDetail_ModifiedDate]
	DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Default constraint value of GETDATE()', 'SCHEMA', N'SalesLT', 'TABLE', N'SalesOrderDetail', 'CONSTRAINT', N'DF_SalesOrderDetail_ModifiedDate'
GO
ALTER TABLE [SalesLT].[SalesOrderDetail]
	WITH CHECK
	ADD CONSTRAINT [FK_SalesOrderDetail_SalesOrderHeader_SalesOrderID]
	FOREIGN KEY ([SalesOrderID]) REFERENCES [SalesLT].[SalesOrderHeader] ([SalesOrderID])
	ON DELETE CASCADE
ALTER TABLE [SalesLT].[SalesOrderDetail]
	CHECK CONSTRAINT [FK_SalesOrderDetail_SalesOrderHeader_SalesOrderID]

GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key constraint referencing SalesOrderHeader.SalesOrderID.', 'SCHEMA', N'SalesLT', 'TABLE', N'SalesOrderDetail', 'CONSTRAINT', N'FK_SalesOrderDetail_SalesOrderHeader_SalesOrderID'
GO
ALTER TABLE [SalesLT].[SalesOrderDetail]
	WITH CHECK
	ADD CONSTRAINT [FK_SalesOrderDetail_Product_ProductID]
	FOREIGN KEY ([ProductID]) REFERENCES [SalesLT].[Product] ([ProductID])
ALTER TABLE [SalesLT].[SalesOrderDetail]
	CHECK CONSTRAINT [FK_SalesOrderDetail_Product_ProductID]

GO
CREATE NONCLUSTERED INDEX [IX_SalesOrderDetail_ProductID]
	ON [SalesLT].[SalesOrderDetail] ([ProductID])
	ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Nonclustered index.', 'SCHEMA', N'SalesLT', 'TABLE', N'SalesOrderDetail', 'INDEX', N'IX_SalesOrderDetail_ProductID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Individual products associated with a specific sales order. See SalesOrderHeader.', 'SCHEMA', N'SalesLT', 'TABLE', N'SalesOrderDetail', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key. Foreign key to SalesOrderHeader.SalesOrderID.', 'SCHEMA', N'SalesLT', 'TABLE', N'SalesOrderDetail', 'COLUMN', N'SalesOrderID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key. One incremental unique number per product sold.', 'SCHEMA', N'SalesLT', 'TABLE', N'SalesOrderDetail', 'COLUMN', N'SalesOrderDetailID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Quantity ordered per product.', 'SCHEMA', N'SalesLT', 'TABLE', N'SalesOrderDetail', 'COLUMN', N'OrderQty'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Product sold to customer. Foreign key to Product.ProductID.', 'SCHEMA', N'SalesLT', 'TABLE', N'SalesOrderDetail', 'COLUMN', N'ProductID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Selling price of a single product.', 'SCHEMA', N'SalesLT', 'TABLE', N'SalesOrderDetail', 'COLUMN', N'UnitPrice'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Discount amount.', 'SCHEMA', N'SalesLT', 'TABLE', N'SalesOrderDetail', 'COLUMN', N'UnitPriceDiscount'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Per product subtotal. Computed as UnitPrice * (1 - UnitPriceDiscount) * OrderQty.', 'SCHEMA', N'SalesLT', 'TABLE', N'SalesOrderDetail', 'COLUMN', N'LineTotal'
GO
EXEC sp_addextendedproperty N'MS_Description', N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.', 'SCHEMA', N'SalesLT', 'TABLE', N'SalesOrderDetail', 'COLUMN', N'rowguid'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Date and time the record was last updated.', 'SCHEMA', N'SalesLT', 'TABLE', N'SalesOrderDetail', 'COLUMN', N'ModifiedDate'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Unique nonclustered constraint. Used to support replication samples.', 'SCHEMA', N'SalesLT', 'TABLE', N'SalesOrderDetail', 'CONSTRAINT', N'AK_SalesOrderDetail_rowguid'
GO
ALTER TABLE [SalesLT].[SalesOrderDetail] SET (LOCK_ESCALATION = TABLE)
GO

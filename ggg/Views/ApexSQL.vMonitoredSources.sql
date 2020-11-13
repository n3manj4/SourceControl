SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: November, 2015
-- Description:	Returns all posible sources for measurments
-- =============================================
CREATE VIEW [ApexSQL].[vMonitoredSources]
AS
SELECT m.Id as Id, null as ParentId, m.MachineName as Name, m.IP as IP, m.Enabled as Enabled, m.Username as Username, m.Password as Password, null as AuthType, 1 as Type
FROM [ApexSQL].[MonitorMachines] m WITH (NOLOCK)
UNION
SELECT dev.Id as Id, dev.ParentId as ParentId, dev.DeviceName as Name, null as IP, dev.Enabled as Enabled, null as Username, null as Password, null as AuthType, 4 as Type
FROM [ApexSQL].[MonitorDevices] dev WITH (NOLOCK)
UNION
SELECT s.Id as Id, s.ParentId, s.ServerName as Name, null as IP, s.Enabled as Enabled, s.Username as Username, s.Password as Password, s.AuthenticationType as AuthType, 2 as Type
FROM [ApexSQL].[MonitorServers] s WITH (NOLOCK)
UNION
SELECT d.Id as Id, d.ParentId as ParentId, d.DatabaseName as Name, null as IP, d.Enabled as Enabled, null as Username, null as Password, null as AuthType, 3 as Type
FROM [ApexSQL].[MonitorDatabases] d WITH (NOLOCK)
UNION
SELECT i.Id as Id, i.ParentId as ParentId, i.IndexName as Name, null as IP, i.Enabled as Enabled, null as Username, null as Password, null as AuthType, 5 as Type
FROM [ApexSQL].[MonitorIndexes] i WITH (NOLOCK)
UNION
SELECT ar.Id as Id, ar.ParentId as ParentId, ar.Instance as Name, null as IP, 1 as Enabled, null as Username, null as Password, null as AuthType, 6 as Type
FROM [ApexSQL].[MonitorAvailabilityReplicas] ar WITH (NOLOCK)
UNION
SELECT ad.Id as Id, ad.ParentId as ParentId, ad.DatabaseName as Name, null as IP, 1 as Enabled, null as Username, null as Password, null as AuthType, 7 as Type
FROM [ApexSQL].[MonitorAvailabilityDatabases] ad WITH (NOLOCK)
GO

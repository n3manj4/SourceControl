SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: November, 2015
-- Description:	Returns all posible sources for measurment
-- =============================================
CREATE VIEW [ApexSQL].[vMonitoredObjects]
AS
SELECT 
Id as Id, null as ParentId, null as MachineId, null as ServerId, null as DatabaseId, null as DeviceId, null as IndexId, null as ReplicaId, null as AgName,
GroupName as Name, GroupName, null as MachineName, null as ServerName, null as DatabaseName, null as DeviceName, null as TableName, null as IndexName, 0 as Type
FROM [ApexSQL].[MonitorGroups] WITH (NOLOCK)
UNION
SELECT m.Id as Id, m.ParentId, m.Id as MachineId, null as ServerId, null as DatabaseId, null as DeviceId, null as IndexId, null as ReplicaId, null as AgName,
m.MachineName as Name, g.GroupName as GroupName, m.MachineName as MachineName, null as ServerName, null as DatabaseName, null as DeviceName, null as TableName, null as IndexName, 1 as Type
FROM [ApexSQL].[MonitorMachines] m WITH (NOLOCK)
LEFT JOIN [ApexSQL].[MonitorGroups] g ON m.ParentId = g.Id
UNION
SELECT dev.Id as Id, dev.ParentId, m.Id as MachineId, null as ServerId, null as DatabaseId, dev.Id as DeviceId, null as IndexId, null as ReplicaId, null as AgName,
dev.DeviceName as Name, g.GroupName as GroupName, m.MachineName as MachineName, null as ServerName, null as DatabaseName, dev.DeviceName as DeviceName, null as TableName, null as IndexName, 4 as Type
FROM [ApexSQL].[MonitorDevices] dev WITH (NOLOCK)
LEFT JOIN  [ApexSQL].[MonitorMachines] m ON   dev.ParentId = m.Id
LEFT JOIN  [ApexSQL].[MonitorGroups]   g ON   m.ParentId = g.Id
UNION
SELECT s.Id as Id, s.ParentId, m.Id as MachineId, s.Id as ServerId, null as DatabaseId, null as DeviceId, null as IndexId, null as ReplicaId, null as AgName,
 s.ServerName as Name, g.GroupName as GroupName, m.MachineName as MachineName, s.ServerName as ServerName, null as DatabaseName, null as DeviceName, null as TableName, null as IndexName, 2 as Type
FROM [ApexSQL].[MonitorServers] s WITH (NOLOCK)
LEFT JOIN  [ApexSQL].[MonitorMachines] m ON m.Id = s.ParentId
LEFT JOIN  [ApexSQL].[MonitorGroups] g ON m.ParentId = g.Id
UNION
SELECT d.Id as Id, d.ParentId, m.Id as MachineId, s.Id as ServerId, d.Id as DatabaseId, null as DeviceId, null as IndexId, null as ReplicaId, null as AgName,
d.DatabaseName as Name, g.GroupName as GroupName, m.MachineName as MachineName, s.ServerName as ServerName, d.DatabaseName as DatabaseName, null as DeviceName, null as TableName, null as IndexName, 3 as Type
FROM [ApexSQL].[MonitorDatabases] d WITH (NOLOCK)
LEFT JOIN  [ApexSQL].[MonitorServers]  s ON   d.ParentId = s.Id
LEFT JOIN  [ApexSQL].[MonitorMachines] m ON   s.ParentId = m.Id
LEFT JOIN  [ApexSQL].[MonitorGroups]   g ON   m.ParentId = g.Id
UNION
SELECT i.Id as Id, i.ParentId, m.Id as MachineId, s.Id as ServerId, d.Id as DatabaseId, null as DeviceId, i.Id as IndexId, null as ReplicaId, null as AgName,
i.IndexName as Name, g.GroupName as GroupName, m.MachineName as MachineName, s.ServerName as ServerName, d.DatabaseName as DatabaseName, null as DeviceName, i.TableName as TableName, i.IndexName as IndexName, 5 as Type
FROM [ApexSQL].[MonitorIndexes] i WITH (NOLOCK)
LEFT JOIN  [ApexSQL].[MonitorDatabases]  d ON   i.ParentId = d.Id
LEFT JOIN  [ApexSQL].[MonitorServers] s ON   d.ParentId = s.Id
LEFT JOIN  [ApexSQL].[MonitorMachines]   m ON   s.ParentId = m.Id
LEFT JOIN  [ApexSQL].[MonitorGroups]   g ON   m.ParentId = g.Id
UNION
SELECT ar.Id as Id, ar.ParentId, m.Id as MachineId, s.Id as ServerId, null as DatabaseId, null as DeviceId, null as IndexId, ar.Id as ReplicaId, ag.Name as AgName,
ar.Instance as Name, g.GroupName as GroupName, m.MachineName as MachineName, s.ServerName as ServerName, null as DatabaseName, null as DeviceName, null as TableName, null as IndexName, 6 as Type
FROM [ApexSQL].[MonitorAvailabilityReplicas] ar WITH (NOLOCK)
LEFT JOIN  [ApexSQL].[MonitorServers]  s ON   ar.ParentId = s.Id
LEFT JOIN  [ApexSQL].[MonitorMachines] m ON   s.ParentId = m.Id
LEFT JOIN  [ApexSQL].[MonitorGroups]   g ON   m.ParentId = g.Id
LEFT JOIN  [ApexSQL].[MonitorAvailabilityGroups] ag ON ar.AvailabilityGroupId = ag.GroupId
UNION
SELECT ad.Id as Id, ad.ParentId, m.Id as MachineId, s.Id as ServerId, ad.Id as DatabaseId, null as DeviceId, null as IndexId, null as ReplicaId, ag.Name as AgName,
ad.DatabaseName as Name, g.GroupName as GroupName, m.MachineName as MachineName, s.ServerName as ServerName, ad.DatabaseName as DatabaseName, null as DeviceName, null as TableName, null as IndexName, 7 as Type
FROM [ApexSQL].[MonitorAvailabilityDatabases] ad WITH (NOLOCK)
LEFT JOIN  [ApexSQL].[MonitorServers]  s ON   ad.ParentId = s.Id
LEFT JOIN  [ApexSQL].[MonitorMachines] m ON   s.ParentId = m.Id
LEFT JOIN  [ApexSQL].[MonitorGroups]   g ON   m.ParentId = g.Id
LEFT JOIN  [ApexSQL].[MonitorAvailabilityGroups] ag ON ad.AvailabilityGroupId = ag.GroupId
GO

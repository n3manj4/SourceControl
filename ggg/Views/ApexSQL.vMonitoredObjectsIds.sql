SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: January, 2017
-- Description:	Attaches the sources original SQL Server and Machine Id.
-- =============================================
CREATE VIEW [ApexSQL].[vMonitoredObjectsIds]
AS
SELECT 
Id as Id, null as ParentId, Id as GroupId, null as MachineId, null as ServerId, 0 as Type
FROM [ApexSQL].[MonitorGroups] WITH (NOLOCK)
UNION
SELECT m.Id as Id, m.ParentId, s.GroupId as GroupId , m.Id as MachineId, s.Id as ServerId, 1 as Type
FROM [ApexSQL].[MonitorMachines] m WITH (NOLOCK)
LEFT JOIN [ApexSQL].[MonitorGroups] g WITH (NOLOCK) ON m.ParentId = g.Id
LEFT JOIN [ApexSQL].[MonitorServers] s WITH (NOLOCK) ON m.ID = s.ParentId OR m.ID IN 
(SELECT MachineId FROM [ApexSQL].[MonitorServerClusterNodes] WHERE ServerId = s.Id)
UNION
SELECT dev.Id as Id, dev.ParentId, s.GroupId as GroupId, m.Id as MachineId, s.Id as ServerId, 4 as Type
FROM [ApexSQL].[MonitorDevices] dev WITH (NOLOCK)
LEFT JOIN  [ApexSQL].[MonitorMachines] m WITH (NOLOCK) ON   dev.ParentId = m.Id
LEFT JOIN  [ApexSQL].[MonitorGroups]   g WITH (NOLOCK) ON   m.ParentId = g.Id
LEFT JOIN [ApexSQL].[MonitorServers] s WITH (NOLOCK) ON m.ID = s.ParentId OR m.ID IN 
(SELECT MachineId FROM [ApexSQL].[MonitorServerClusterNodes] WHERE ServerId = s.Id)
UNION
SELECT s.Id as Id, s.ParentId, g.Id as GroupId, m.Id as MachineId, s.Id as ServerId, 2 as Type
FROM [ApexSQL].[MonitorServers] s WITH (NOLOCK)
LEFT JOIN  [ApexSQL].[MonitorMachines] m WITH (NOLOCK) ON m.Id = s.ParentId
LEFT JOIN  [ApexSQL].[MonitorGroups] g WITH (NOLOCK) ON s.GroupId = g.Id
WHERE IsClustered <> 1 OR (s.IsClustered = 1 AND s.Id NOT IN (SELECT ParentId FROM [ApexSQL].[MonitorAvailabilityReplicas]))
UNION
SELECT d.Id as Id, d.ParentId,s.GroupId as GroupId, m.Id as MachineId, s.Id as ServerId, 3 as Type
FROM [ApexSQL].[MonitorDatabases] d WITH (NOLOCK)
LEFT JOIN  [ApexSQL].[MonitorServers]  s WITH (NOLOCK) ON   d.ParentId = s.Id
LEFT JOIN  [ApexSQL].[MonitorMachines] m WITH (NOLOCK) ON   s.ParentId = m.Id
UNION
SELECT i.Id as Id, i.ParentId,s.GroupId as GroupId, m.Id as MachineId, s.Id as ServerId, 5 as Type
FROM [ApexSQL].[MonitorIndexes] i WITH (NOLOCK)
LEFT JOIN  [ApexSQL].[MonitorDatabases]  d WITH (NOLOCK) ON   i.ParentId = d.Id
LEFT JOIN  [ApexSQL].[MonitorServers] s WITH (NOLOCK)ON   d.ParentId = s.Id
LEFT JOIN  [ApexSQL].[MonitorMachines]   m WITH (NOLOCK) ON   s.ParentId = m.Id
UNION
SELECT ar.Id as Id, ar.ParentId, g.Id as GroupId, m.Id as MachineId, s.Id as ServerId, 6 as Type
FROM [ApexSQL].[MonitorAvailabilityReplicas] ar WITH (NOLOCK)
LEFT JOIN  [ApexSQL].[MonitorServers]  s WITH (NOLOCK) ON   ar.ParentId = s.Id
LEFT JOIN  [ApexSQL].[MonitorMachines] m WITH (NOLOCK) ON   s.ParentId = m.Id
LEFT JOIN  [ApexSQL].[MonitorGroups]   g WITH (NOLOCK) ON   ar.AvailabilityGroupId = g.AvailabilityGroupId
LEFT JOIN  [ApexSQL].[MonitorAvailabilityGroups] ag WITH (NOLOCK) ON ar.AvailabilityGroupId = ag.GroupId
UNION ALL
SELECT s.Id as Id, m.Id as ParentId, g.Id as GroupId, m.Id as MachineId, s.Id as ServerId, 2 as Type
FROM [ApexSQL].[MonitorAvailabilityReplicas] ar WITH (NOLOCK)
LEFT JOIN  [ApexSQL].[MonitorServers]  s WITH (NOLOCK) ON   ar.ParentId = s.Id
LEFT JOIN  [ApexSQL].[MonitorMachines] m WITH (NOLOCK) ON   s.ParentId = m.Id
LEFT JOIN  [ApexSQL].[MonitorGroups]   g WITH (NOLOCK) ON   ar.AvailabilityGroupId = g.AvailabilityGroupId
LEFT JOIN  [ApexSQL].[MonitorAvailabilityGroups] ag WITH (NOLOCK) ON ar.AvailabilityGroupId = ag.GroupId
WHERE g.AvailabilityGroupId IS NOT NULL
UNION
SELECT ad.Id as Id, ad.ParentId, g.Id as GroupId, m.Id as MachineId, s.Id as ServerId, 7 as Type
FROM [ApexSQL].[MonitorAvailabilityDatabases] ad WITH (NOLOCK)
LEFT JOIN  [ApexSQL].[MonitorServers]  s WITH (NOLOCK) ON   ad.ParentId = s.Id
LEFT JOIN  [ApexSQL].[MonitorMachines] m WITH (NOLOCK) ON   s.ParentId = m.Id
LEFT JOIN  [ApexSQL].[MonitorGroups]   g WITH (NOLOCK) ON   ad.AvailabilityGroupId = g.AvailabilityGroupId
LEFT JOIN  [ApexSQL].[MonitorAvailabilityGroups] ag WITH (NOLOCK) ON ad.AvailabilityGroupId = ag.GroupId
GO

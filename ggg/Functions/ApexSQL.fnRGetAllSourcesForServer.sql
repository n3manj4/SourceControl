SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: January, 2018
-- Description:	Gets all the source for the server
-- =============================================
CREATE FUNCTION [ApexSQL].[fnRGetAllSourcesForServer]
(
	@serverId uniqueidentifier
)
RETURNS TABLE
AS
RETURN
(	
	-- Servers
	SELECT s.[Id] as [SourceId],
		   CASE
		       WHEN s.[ServerName] = '.' THEN s.[MachineName]
		       ELSE s.[MachineName] + '\' + s.[ServerName]
		   END AS [SourceName]
	FROM [ApexSQL].[MonitorServers] AS s WITH (NOLOCK) 
	WHERE s.[Id] = @serverId
	UNION 
	-- Machines
	SELECT m.[Id] AS [SourceId], 
           m.[MachineName] AS [SourceName]
	FROM [ApexSQL].[MonitorServers] AS s WITH (NOLOCK) 
	LEFT JOIN [ApexSQL].[MonitorMachines] AS m ON 
        s.ParentId = m.Id
	WHERE s.Id = @serverId 
	UNION
	-- Devices
	SELECT d.Id AS SourceId, 
           d.DeviceName AS SourceName
	FROM [ApexSQL].[MonitorServers] AS s
	LEFT JOIN [ApexSQL].[MonitorMachines] AS m WITH (NOLOCK) ON 
        s.ParentId = m.Id
	LEFT JOIN [ApexSQL].[MonitorDevices] AS d ON 
        d.ParentId = m.Id
	WHERE s.Id = @serverId
	UNION 
	-- Databases
	SELECT db.Id AS SourceId, 
           db.DatabaseName AS SourceName
	FROM [ApexSQL].[MonitorServers] AS s
	LEFT JOIN [ApexSQL].[MonitorDatabases] AS db WITH (NOLOCK) ON 
        db.ParentId = s.Id
	WHERE s.Id = @serverId
	UNION 
	-- Indexes
	SELECT i.Id AS SourceId, 
           i.IndexName AS SourceName
	FROM [ApexSQL].[MonitorServers] AS s
	LEFT JOIN [ApexSQL].[MonitorDatabases] AS db WITH (NOLOCK) on 
        db.ParentId = s.Id
	INNER JOIN [ApexSQL].[MonitorIndexes] AS i ON 
        i.ParentId = db.Id
	WHERE s.Id = @serverId
)
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: January, 2018
-- Description:	Gets all the source for the server
-- =============================================
CREATE FUNCTION [ApexSQL].[fnRGetAllSourcesInsideServer]
(
	@serverId uniqueidentifier
)
RETURNS TABLE 
AS
RETURN
(
	-- Servers
	SELECT s.Id AS SourceId, 
           s.ServerName AS SourceName
	FROM [ApexSQL].[MonitorServers] AS s WITH (NOLOCK) 
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
	LEFT JOIN [ApexSQL].[MonitorDatabases] AS db WITH (NOLOCK) ON 
        db.ParentId = s.Id
	INNER JOIN [ApexSQL].[MonitorIndexes] AS i ON 
        i.ParentId = db.Id
	WHERE s.Id = @serverId
)
GO

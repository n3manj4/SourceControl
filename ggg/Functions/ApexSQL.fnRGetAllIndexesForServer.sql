SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: January, 2018
-- Description:	Gets all the indexes for the server
-- =============================================
CREATE FUNCTION [ApexSQL].[fnRGetAllIndexesForServer]
(
	@serverId uniqueidentifier
)
RETURNS TABLE
AS
RETURN
(
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

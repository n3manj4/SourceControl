SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: February, 2018
-- Description:	Gets all the databases from servers
-- =============================================
CREATE FUNCTION [ApexSQL].[fnRGetAllDatabasesFromServers]
(
	@sources nvarchar(max)
)
RETURNS TABLE
AS
RETURN
(
	SELECT db.[Id] AS [SourceId], 
           db.[DatabaseName] AS [SourceName]
	FROM [ApexSQL].[MonitorServers] AS s
	LEFT JOIN [ApexSQL].[MonitorDatabases] db WITH (NOLOCK) ON 
        db.[ParentId] = s.[Id]
	WHERE s.[Id] IN (SELECT * FROM [ApexSQL].[fnParseListGuid](@sources, ' '))
)
GO

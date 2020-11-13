SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: January, 2018
-- Description:	Gets all the indexes for the database
-- =============================================
CREATE FUNCTION [ApexSQL].[fnRGetAllIndexesForDatabase]
(
	@databaseId uniqueidentifier
)
RETURNS TABLE
AS
RETURN
(
	SELECT i.Id AS SourceId, 
           i.IndexName AS SourceName
	FROM [ApexSQL].[MonitorDatabases] AS db WITH (NOLOCK) 
	INNER JOIN [ApexSQL].[MonitorIndexes] AS i ON 
        i.ParentId = db.Id
	WHERE db.Id = @databaseId
)
GO

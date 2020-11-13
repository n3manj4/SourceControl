SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: January, 2017
-- Description:	Return all source ids for server
-- =============================================
CREATE FUNCTION [ApexSQL].[fnGetAllSourceIdsForServer]
(
   @serverId uniqueidentifier
) 
RETURNS TABLE 
AS
RETURN
(
	SELECT S.Id as [SourceId]
	FROM [ApexSQL].[vMonitoredObjectsIds] S
	WHERE S.ServerId = @serverId
)
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: January, 2017
-- Description:	Return all source ids for all servers in group
-- =============================================
CREATE FUNCTION [ApexSQL].[fnGetAllSourceIdsForGroup]
(
   @groupId uniqueidentifier
) 
RETURNS TABLE 
AS
RETURN
(
	SELECT DISTINCT S.Id as [SourceId]
	FROM [ApexSQL].[vMonitoredObjectsIds] S
	WHERE S.ServerId IN (SELECT [ServerId] FROM [ApexSQL].[fnGetAllServerIdsForGroup](@groupId)) 
	AND S.MachineId IN (SELECT [ParentId] FROM [ApexSQL].[MonitorServers] 
						WHERE [Id] IN (SELECT [ServerId] FROM [ApexSQL].[fnGetAllServerIdsForGroup](@groupId)))
)
GO

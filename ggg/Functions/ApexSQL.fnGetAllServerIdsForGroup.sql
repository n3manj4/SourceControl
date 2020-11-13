SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: January, 2017
-- Description:	Return all server ids for group
-- =============================================
CREATE FUNCTION [ApexSQL].[fnGetAllServerIdsForGroup]
(
   @groupId uniqueidentifier
) 
RETURNS TABLE 
AS
RETURN
(
	SELECT S.[Id] as [ServerId]
	FROM [ApexSQL].[MonitorServers] S
	WHERE S.[GroupId] IN (SELECT [GroupId] FROM [ApexSQL].[fnGetAllGroupIdsForGroup](@groupId))
	OR S.[Id] IN (SELECT ParentId FROM [ApexSQL].[MonitorAvailabilityReplicas] A 
					WHERE A.AvailabilityGroupId IN (SELECT AvailabilityGroupId FROM [ApexSQL].[MonitorGroups] G 
													WHERE G.Id IN (SELECT [GroupId] FROM [ApexSQL].[fnGetAllGroupIdsForGroup](@groupId))))
)
GO

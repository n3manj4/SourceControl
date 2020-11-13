SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: September, 2017
-- Description:	Return all servers in specific group and its childrens 
-- =============================================
CREATE FUNCTION [ApexSQL].[fnGetAllServersNoClusterByGroup]
(
	@GroupId uniqueidentifier
) 
RETURNS TABLE 
AS
RETURN 
(
SELECT ms.Id, ms.ServerName, gv.FullPath
  FROM [ApexSQL].[MonitorServers] ms 
  LEFT JOIN [ApexSQL].[vMonitorGroupPathsNoCluster] gv ON ms.GroupId = gv.Id
  WHERE IsClustered = 0 AND ( gv.FullPath LIKE  
  (SELECT TOP 1 scv.FullPath + '%'  FROM [ApexSQL].[vMonitorGroupPathsNoCluster] scv WHERE scv.Id = @GroupId) OR 
  ms.Id = @GroupId)
)
GO

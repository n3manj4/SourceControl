SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: September, 2017
-- Description:	Group hiararchy
-- =============================================
CREATE VIEW [ApexSQL].[vMonitorGroupPathsNoCluster]
AS
WITH grouppaths (Id, FullPath) AS
(
    SELECT Id, CAST(GroupName AS nvarchar(max))
    FROM ApexSQL.MonitorGroups
    WHERE GroupId = '00000000-0000-0000-0000-000000000000'
    UNION ALL
    SELECT gp.id, CAST(gps.FullPath + N'/' + gp.GroupName AS nvarchar(max))
    FROM ApexSQL.MonitorGroups gp
    JOIN grouppaths gps ON gps.Id = gp.GroupId
	WHERE gp.AvailabilityGroupId IS NULL
)
SELECT Id, FullPath FROM grouppaths
GO

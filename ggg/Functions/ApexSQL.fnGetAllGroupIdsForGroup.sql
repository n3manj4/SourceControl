SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: January, 2017
-- Description:	Return all group ids for group
-- =============================================
CREATE FUNCTION [ApexSQL].[fnGetAllGroupIdsForGroup]
(
   @groupId uniqueidentifier
) 
RETURNS TABLE 
AS
RETURN
(
	with cte as
	(  
		select G.*
		from [ApexSQL].[MonitorGroups] as G
		where G.Id = @groupId
		union all
		select G.*
		from [ApexSQL].[MonitorGroups] as G
			inner join cte as C
			on G.GroupId = C.Id
	)
	select [Id] as [GroupId]
	from cte    
)
GO

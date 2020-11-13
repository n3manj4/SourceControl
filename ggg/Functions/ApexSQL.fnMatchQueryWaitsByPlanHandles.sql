SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================            
-- Author:		ApexSQL LLC
-- Create date: September, 2018
-- Description:	Returs query waits IDs for matched plan handle
-- =============================================
CREATE FUNCTION [ApexSQL].[fnMatchQueryWaitsByPlanHandles]
(
	@PlanHandles nvarchar(max)
)
RETURNS TABLE
AS
RETURN
(
	SELECT qw.[Id]   AS [Id],
           ph.[Item] AS [PlanHandle]
    FROM [ApexSQL].[MonitorQueryWaits] AS qw
    INNER JOIN [ApexSQL].[fnSplitStrings](@PlanHandles, '|') AS ph ON
        CONVERT(binary(20), ph.[Item], 2) = qw.[PlanHandle]
)
GO

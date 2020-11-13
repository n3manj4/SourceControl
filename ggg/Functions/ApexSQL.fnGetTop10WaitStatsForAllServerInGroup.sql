SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: February, 2019
-- Description:	Return 10 queries for all servers in specific group and its childrens
-- =============================================
CREATE FUNCTION [ApexSQL].[fnGetTop10WaitStatsForAllServerInGroup]
(
	@GroupId uniqueidentifier,
	@StartDate datetimeoffset(7),
	@EndDate   datetimeoffset(7)
) 
RETURNS TABLE 
AS
RETURN 
(
    WITH sources AS
    (
        SELECT STUFF((SELECT ' ' + CAST([Id] AS nvarchar(MAX)) AS [text()]
                      FROM [ApexSQL].[fnGetAllServersNoClusterByGroup](@GroupId)
                      FOR XML PATH ('')), 1, 1, '') AS [SourceIds]
    ),
    s AS 
    (
        SELECT [SourceId], 
               [WaitTypeId], 
               [Total], 
               [rn] = ROW_NUMBER() OVER (PARTITION BY [SourceId] ORDER BY [Total] DESC)
        FROM 
        (
            SELECT [SourceId], 
                   [WaitTypeId], 
                   [Total] = SUM([Value])
            FROM [ApexSQL].[fnMeasuredValues](@StartDate, @EndDate, (SELECT [SourceIds] FROM sources), '9EF9CB90-766C-41F5-8A54-BF6FAC16AC9D')
            GROUP BY [SourceId], 
                     [WaitTypeId]
        ) AS s2
    )
    SELECT [SourceId], 
           wt.[WaitTypeName] AS [WaitTypeName], 
           [Total] AS [Value]
    FROM s 
    LEFT JOIN [ApexSQL].[MonitorWaitTypes] AS wt ON 
        s.[WaitTypeId] = wt.[Id]
    WHERE [rn] <= 10
)
GO

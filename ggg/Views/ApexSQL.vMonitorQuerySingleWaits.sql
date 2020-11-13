SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: January, 2017
-- Description:	Breaks the column Wait type into single rows
-- =============================================
CREATE VIEW [ApexSQL].[vMonitorQuerySingleWaits] 
AS
SELECT   A.[Id]
        ,A.[SqlHandle]
		,A.[PlanHandle]
		,A.[QueryTextId]
		,A.[QueryPlanId]
		,A.[StmOffsetStart]
		,A.[StmOffsetEnd] 
		,A.[MeasuredAt]
		,A.[SourceId]
		,A.[DatabaseNameId]
		,X.C.value('(@w)[1]', 'nvarchar(512)') AS WaitTypeName
        ,X.C.value('(@i)[1]', 'bigint') AS WaitTime
FROM (
SELECT [Id],
       [SqlHandle],
	   [PlanHandle],
	   [QueryTextId],
	   [QueryPlanId],
	   [StmOffsetStart],
	   [StmOffsetEnd], 
	   [MeasuredAt],
	   [SourceId],
	   [DatabaseNameId],
       CAST ('<root> <r w="' + REPLACE(REPLACE([SingleWaits] , ',' , '"/><r w="'), ';' , '" i="') + '"/></root>' as XML) AS xmlNodes 
FROM [ApexSQL].[MonitorQueryWaits]) AS A CROSS APPLY xmlNodes.nodes ('/root/r') AS X(C); 
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: January, 2018
-- Description:	Top 10 applications with highest wait time in a database
-- =============================================
CREATE FUNCTION [ApexSQL].[fnRTop5WaitTypesOfTotalWaitTime]
(
	@SourceId uniqueidentifier,
	@StartDate DateTimeOffset(7),
	@EndDate DateTimeOffset(7)
)
RETURNS TABLE
AS 
RETURN
(
	SELECT Top 5 
	WT.WaitTypeName as [Wait type name],
	(SUM([Value]) / 1000) as [Total server wait per wait type [s]]], 
	[ApexSQL].[fnRoundMeasuredValue](SUM([Value] * 100)  / 
	ISNULL((
		Select SUM([Value]) From [ApexSQL].[fnMeasuredValues](@StartDate, @EndDate, @SourceId, '9EF9CB90-766C-41F5-8A54-BF6FAC16AC9D'))
	, 0)) as [Percentage of total server wait [%]]]
	FROM   [ApexSQL].[fnMeasuredValues](@StartDate, @EndDate, @SourceId, '9EF9CB90-766C-41F5-8A54-BF6FAC16AC9D')
	  LEFT JOIN [ApexSQL].[MonitorWaitTypes] AS WT ON
        WT.Id = WaitTypeId	
	GROUP BY SourceID, WT.WaitTypeName
	ORDER BY [Total server wait per wait type [s]]] DESC
)

GO

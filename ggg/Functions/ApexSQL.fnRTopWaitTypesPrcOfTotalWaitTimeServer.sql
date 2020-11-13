SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: January, 2018
-- Description:	Top 10 wait types as percent of the total wait time on SQL Server
-- =============================================
CREATE FUNCTION [ApexSQL].[fnRTopWaitTypesPrcOfTotalWaitTimeServer]
(
	@SourceId uniqueidentifier,
	@StartTime DateTimeOffset(7),
	@EndTime DateTimeOffset(7)
)
RETURNS TABLE
AS 
RETURN
(
	WITH cte AS
	(
		SELECT WaitTypeId, 
			   ([Value] * 100) / SUM([Value]) OVER (PARTITION BY 1) AS PercentOfTotalWait 
		FROM [ApexSQL].[fnGetWaitstatsCumulative](@SourceId, @StartTime, @EndTime, 60*24*365)
	) 
	SELECT TOP 10 WT.WaitTypeName AS [Wait type|X],  
				  [ApexSQL].[fnRoundMeasuredValue]([PercentOfTotalWait]) AS [Percentage|Y]
	FROM cte 
    LEFT JOIN [ApexSQL].[MonitorWaitTypes] AS WT ON 
		WT.Id = WaitTypeId
	ORDER BY [PercentOfTotalWait] DESC
)
GO

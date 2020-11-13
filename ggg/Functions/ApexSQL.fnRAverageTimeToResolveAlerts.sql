SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: January, 2018
-- Description:	Report on the average time it takes to resolve alerts over period of time
-- =============================================
CREATE FUNCTION [ApexSQL].[fnRAverageTimeToResolveAlerts]
(
	@SourceId uniqueidentifier, 
	@StartDate DateTimeOffset(7), 
	@EndDate DateTimeOffset(7)
)
RETURNS TABLE
AS
RETURN
(
	SELECT 'High' AS [Severity|X],  
		   ISNULL((AVG(DATEDIFF(SECOND, TimeRaised, TimeResolved))), 0) / (60 * 60) AS [Hours|Y]
	FROM [ApexSQL].[MonitorAlerts]
	WHERE Severity = 3 
	  AND TimeResolved IS NOT NULL
	  AND TimeResolved >= @StartDate
	  AND TimeResolved <= @EndDate
	  AND SourceId = @SourceId
	UNION ALL
	SELECT 'Medium' AS [Severity|X],  
		   ISNULL((AVG(DATEDIFF(SECOND, TimeRaised, TimeResolved))), 0) / (60 * 60) AS [Hours|Y]
	FROM [ApexSQL].[MonitorAlerts]
	WHERE Severity = 2 
	  AND TimeResolved IS NOT NULL
	  AND TimeResolved >= @StartDate
	  AND TimeResolved <= @EndDate
	UNION ALL
	SELECT 'Low' AS [Severity|X],  
		   ISNULL((AVG(DATEDIFF(SECOND, TimeRaised, TimeResolved))), 0) / (60 * 60) AS [Hours|Y]
	FROM [ApexSQL].[MonitorAlerts] 
	WHERE Severity = 1 
	  AND TimeResolved IS NOT NULL
	  AND TimeResolved >= @StartDate
	  AND TimeResolved <= @EndDate
	UNION ALL
	SELECT 'All' AS [Severity|X],  
		   ISNULL((AVG(DATEDIFF(SECOND, TimeRaised, TimeResolved))), 0) / (60 * 60) AS [Hours|Y] 
	FROM [ApexSQL].[MonitorAlerts] 
	WHERE TimeResolved IS NOT NULL
	  AND TimeResolved >= @StartDate
	  AND TimeResolved <= @EndDate
)
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: January, 2018
-- Description:	Top 10 metrics (all types) with highest number of alerts
-- =============================================
CREATE FUNCTION [ApexSQL].[fnRTopMetricsAllTypesHighestAlerts]
(
	@SourceId uniqueidentifier,
	@AlertSeverityId int,
	@StartDate DateTimeOffset(7), 
	@EndDate DateTimeOffset(7)
)
RETURNS TABLE
AS
RETURN
(
	SELECT TOP 10 * 
	FROM
	(
		SELECT ApexSQL.fnMetricIdToName([MeasurementId]) AS [Measurement|X],
			   COUNT(*) AS [Alerts number|Y]
		FROM [ApexSQL].[MonitorAlerts]  
		WHERE SourceId IN (SELECT SourceId FROM [ApexSQL].[fnRGetAllSourcesForServer](@SourceId))
		  AND (Severity = @AlertSeverityId OR @AlertSeverityId = 4)
		  AND TimeRaised >= @StartDate
		  AND TimeRaised <= @EndDate
		GROUP BY [SourceId], 
                 [MeasurementId] 
	) AS R 
	ORDER BY R.[Alerts number|Y] DESC
)
GO

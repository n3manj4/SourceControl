SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: July, 2018
-- Description:	Top metrics with highest number of alerts per severity
-- =============================================
CREATE FUNCTION [ApexSQL].[fnRTopMetricsHighestAlerts]
(
	@SourceId uniqueidentifier,
	@ParentId uniqueidentifier,
	@StartDate DateTimeOffset(7), 
	@EndDate DateTimeOffset(7)
)
RETURNS TABLE 
AS
RETURN
(
	SELECT TOP 1000000 MM.Caption AS [Metric name],
                       SUM(CASE WHEN Severity = 3 AND State  = 0 THEN 1 ELSE 0 END) AS [High severity],
                       SUM(CASE WHEN Severity = 2 AND State  = 0 THEN 1 ELSE 0 END) AS [Medium severity],
                       SUM(CASE WHEN Severity = 1 AND State  = 0 THEN 1 ELSE 0 END) AS [Low severity],
                       SUM(CASE WHEN State  != 0 THEN 1 ELSE 0 END) AS [Resolved],
                       COUNT(*) AS [Total]
    FROM [ApexSQL].[MonitorAlerts] AS MA 
    INNER JOIN [ApexSQL].[vMonitoredObjects] AS OV ON 
        OV.Id = MA.SourceId
    INNER JOIN [ApexSQL].[MonitorMeasurements] AS MM ON 
        MM.Id = MA.MeasurementId
    WHERE MA.TimeRaised >= @StartDate
      AND MA.TimeRaised <= @EndDate 
      AND ((OV.MachineId IN (@ParentId) AND OV.Type IN (1,4)) OR (OV.ServerId IN (@SourceId) AND OV.Type IN (2,3)))
    GROUP BY MM.Caption
    ORDER BY Total DESC
)
GO

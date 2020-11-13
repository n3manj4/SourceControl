SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

------------------------------------------------------------------------------------------------
-- DEFAULT REPORTS -----------------------------------------------------------------------------
------------------------------------------------------------------------------------------------

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: January, 2018
-- Description:	Reporting on the alerts status for the monitored instance
-- =============================================
CREATE FUNCTION [ApexSQL].[fnRReportingOnAlertsStatus]
(
	@SourceId uniqueidentifier, 
	@AlertStateId int,
	@AlertSeverityId int,
	@StartDate DateTimeOffset(7), 
	@EndDate DateTimeOffset(7)
)
RETURNS TABLE
AS
RETURN
(
	SELECT TOP 1000000 (alls.SourceName) AS [Source],
		               [ApexSQL].[fnMetricIdToName](A.[MeasurementId]) AS [Metric],
		               [ApexSQL].[fnAlertSeverityIdToName](A.[Severity]) AS [Severity],
		               CASE
		                   WHEN A.[Checked] = 0 THEN 'No'
		                   WHEN A.[Checked] = 1 THEN 'Yes'
		               END AS [Reviewed],
		               [ApexSQL].[fnAlertStateIdToName](A.[State]) AS [State],
		               MM.[Value] AS [Value],
					   CONVERT(varchar, A.[TimeRaised], 22) AS [Raised],
					   CONVERT(varchar, A.[TimeResolved], 22) AS [Resolved],
		               A.[UserResolved] AS [Resolved by],
		               A.[Comment]
    FROM [ApexSQL].[MonitorAlerts] A
	LEFT JOIN (SELECT * FROM [ApexSQL].[fnRGetAllSourcesForServer](@SourceId)) AS alls ON 
		A.SourceId = alls.SourceId
    CROSS APPLY 
    (
        SELECT TOP 1 ISNULL([ValueConverted], CAST(mv.Value AS NVARCHAR(MAX))) as [Value]
		FROM ApexSQL.vMonitorStatusConverters AS msc
        RIGHT JOIN [ApexSQL].[fnMeasuredValues](DATEADD(DAY, -2, @StartDate), DATEADD(DAY, 1, @EndDate), A.[SourceId], A.[MeasurementId]) AS mv ON
			A.SourceId = mv.SourceId
		AND msc.MeasurementId = mv.MeasurementId
        WHERE [GroupId] = A.[MeasuredValueId]
          AND DATEADD(MILLISECOND, -DATEPART(MILLISECOND, [MeasuredAt]), [MeasuredAt]) <= A.[TimeRaised]
        ORDER BY [MeasuredAt] DESC
		UNION ALL 
		SELECT TOP 1 CAST(WaitTime AS NVARCHAR(MAX))
		FROM [ApexSQL].[MonitorQueryWaits] 
		WHERE Id = A.MeasuredValueId
    ) AS MM
	WHERE A.TimeRaised >= @StartDate 
	  AND A.TimeRaised <= @EndDate
	  AND (A.State = @AlertStateId OR @AlertStateId = 4)
	  AND (A.Severity = @AlertSeverityId OR @AlertSeverityId = 4) 
	  AND A.SourceId IN (SELECT SourceId FROM [ApexSQL].[fnRGetAllSourcesForServer](@SourceId))
    ORDER BY A.Severity DESC, 
             A.TimeRaised
)
GO

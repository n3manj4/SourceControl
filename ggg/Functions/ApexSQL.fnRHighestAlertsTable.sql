SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: July, 2018
-- Description:	Highest number of alerts per severity
-- =============================================
CREATE FUNCTION [ApexSQL].[fnRHighestAlertsTable]
(
	@SourceId uniqueidentifier,
	@StartDate DateTimeOffset(7), 
	@EndDate DateTimeOffset(7)
)
RETURNS TABLE
AS
RETURN
(
    SELECT TOP 1000000 ISNULL(SUM(CASE WHEN [Severity] = 3 THEN 1 ELSE 0 END), 0) AS [High severity],
                       ISNULL(SUM(CASE WHEN [Severity] = 2 THEN 1 ELSE 0 END), 0) AS [Medium severity],
		               ISNULL(SUM(CASE WHEN [Severity] = 1 THEN 1 ELSE 0 END), 0) AS [Low severity],
		               COUNT(*) AS [Total number of alerts]
    FROM [ApexSQL].[MonitorAlerts]
    WHERE TimeRaised >= @StartDate
      AND TimeRaised <= @EndDate
	  AND SourceId IN ( SELECT SourceId FROM ApexSQL.fnRGetAllSourcesForServer(@SourceId))
    ORDER BY [Total number of alerts] DESC
)
GO

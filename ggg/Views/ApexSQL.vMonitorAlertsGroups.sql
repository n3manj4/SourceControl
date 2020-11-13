SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

----------------------------------------------------------------------------------------------------------------
-- VIEWS -------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: November, 2015
-- Description:	Groups alerts by different sources
-- =============================================
CREATE VIEW [ApexSQL].[vMonitorAlertsGroups]
AS
SELECT SourceId, [MeasurementId], MIN(TimeRaised) as FromTime, MAX(TimeRaised) as ToTime, 
SUM(CASE WHEN Severity = 1 THEN 1 ELSE 0 END) AS LowAlerts, 
SUM(CASE WHEN Severity = 2 THEN 1 ELSE 0 END) AS MediumAlerts, 
SUM(CASE WHEN Severity = 3 THEN 1 ELSE 0 END) AS HighAlerts 
FROM  [ApexSQL].[MonitorAlerts] WITH (NOLOCK)
WHERE State = 0 AND
(SourceId IN (SELECT Id FROM ApexSQL.MonitorMachines) OR
SourceId IN (SELECT Id FROM ApexSQL.MonitorServers) OR
SourceId IN (SELECT Id FROM ApexSQL.MonitorDatabases WHERE [Enabled] = 1) OR
SourceId IN (SELECT Id FROM ApexSQL.MonitorDevices WHERE [Enabled] = 1) OR
SourceId IN (SELECT Id FROM ApexSQL.MonitorIndexes WHERE [Enabled] = 1) OR
SourceId IN (SELECT Id FROM ApexSQL.MonitorAvailabilityReplicas WHERE [Enabled] = 1) OR
SourceId IN (SELECT Id FROM ApexSQL.MonitorAvailabilityDatabases WHERE DatabaseId IN (SELECT DatabaseId FROM ApexSQL.MonitorDatabases WHERE [Enabled] = 1)))
GROUP BY [SourceId], [MeasurementId]
GO

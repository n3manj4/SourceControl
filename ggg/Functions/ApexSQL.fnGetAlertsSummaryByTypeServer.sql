SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: January, 2017
-- Description:	Return all active alerts by SQL Server by categories
-- =============================================
CREATE FUNCTION [ApexSQL].[fnGetAlertsSummaryByTypeServer]
(
	@ServerId uniqueidentifier
) 
RETURNS TABLE 
AS
RETURN 
(
SELECT OV.ServerId as [ServerId],
	   MM.[Type] as [Type],
	   SUM(CASE WHEN A.Severity = 1 THEN 1 ELSE 0 END) AS LowAlerts,
	   SUM(CASE WHEN A.Severity = 2 THEN 1 ELSE 0 END) AS MediumAlerts,
	   SUM(CASE WHEN A.Severity = 3 THEN 1 ELSE 0 END) AS HighAlerts
FROM  [ApexSQL].[MonitorAlerts] A WITH (NOLOCK) 
LEFT JOIN [ApexSQL].[vMonitoredObjectsIds] OV WITH (NOLOCK) ON A.SourceId = OV.Id
LEFT JOIN [ApexSQL].[MonitorMeasurements] MM WITH (NOLOCK) ON A.MeasurementId = MM.Id
WHERE A.State = 0 AND OV.ServerId = @ServerId
GROUP BY OV.ServerId, MM.[Type]
)
GO

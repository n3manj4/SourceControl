SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: January, 2017
-- Description:	Return all active avaiability (SQL Server, Machine) by SQL Server
-- =============================================
CREATE FUNCTION [ApexSQL].[fnGetAvailabilityAlertsSummaryAll]() 
RETURNS TABLE 
AS
RETURN 
(
SELECT OV.ServerId,
	   SUM(CASE WHEN A.Severity = 1 THEN 1 ELSE 0 END) AS LowAlerts,
	   SUM(CASE WHEN A.Severity = 2 THEN 1 ELSE 0 END) AS MediumAlerts,
	   SUM(CASE WHEN A.Severity = 3 THEN 1 ELSE 0 END) AS HighAlerts,
	   MAX(CASE WHEN A.MeasurementId = 'A5BFFAAE-CC3E-48C4-9EEC-80CB8F2354B6' THEN 2 ELSE 1 END) AS [Type]
FROM  [ApexSQL].[MonitorAlerts] A WITH (NOLOCK) 
LEFT JOIN [ApexSQL].[vMonitoredObjectsIds] OV WITH (NOLOCK) ON A.SourceId = OV.Id
WHERE A.State = 0 AND A.MeasurementId IN ('A5BFFAAE-CC3E-48C4-9EEC-80CB8F2354B6', '1D0A0513-8FD1-4254-A162-FC0EC930774B')
GROUP BY OV.ServerId, A.MeasurementId
)
GO

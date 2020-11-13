SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: January, 2017
-- Description:	Return grouped alerts based on params
-- =============================================
CREATE FUNCTION [ApexSQL].[fnGetGroupedAlerts]
(
	@Group uniqueidentifier,
	@Server uniqueidentifier,
	@Measurements nvarchar(MAX),
	@States nvarchar(MAX),
	@Checked nvarchar(max),
	@StartDate datetimeoffset,
	@EndDate datetimeoffset
) 
RETURNS TABLE 
AS
RETURN 
(
SELECT M.Caption AS Name, 
		M.Id AS MeasurementId, 
		M.Type AS MeasurementType, 
		M.[Group] AS MeasurementGroup, 
		A.SourceId, 
		(CASE WHEN O.[Type] = 3 THEN (CASE WHEN O.[ServerName] = '.' THEN O.[MachineName] ELSE (O.[MachineName] + '\' + O.[ServerName]) END + '.' + O.[Name]) 
			  WHEN O.[Type] = 4 THEN (O.[MachineName] + '.' + O.[Name]) 
			  WHEN O.[Type] IN (6, 7) THEN (O.[AgName] + '.' + O.[Name])
              WHEN O.[Type] = 1 THEN O.[Name] 
			  WHEN O.[Type] = 5 THEN (CASE WHEN O.[ServerName] = '.' THEN O.[MachineName] ELSE (O.[MachineName] + '\' + O.[ServerName]) END + '.' + O.[DatabaseName] + '.' + O.[Name])
			  ELSE (CASE WHEN O.[ServerName] = '.' THEN O.[MachineName] ELSE (O.[MachineName] + '\' + O.[ServerName]) END) END) AS SourceName, 
        SUM(CASE WHEN A.Severity = 1 THEN 1 ELSE 0 END) AS LowAlerts, 
		SUM(CASE WHEN A.Severity = 2 THEN 1 ELSE 0 END) AS MediumAlerts, 
		SUM(CASE WHEN A.Severity = 3 THEN 1 ELSE 0 END) AS HighAlerts, 
        CONVERT(date, A.TimeRaised) AS DateRaised, 
		CASE WHEN COUNT(A.Checked) > SUM(CONVERT(int, A.Checked)) THEN CONVERT(bit, 0) 
			 WHEN COUNT(A.Checked) = SUM(CONVERT(int, A.Checked)) THEN CONVERT(bit, 1) END AS Checked
FROM ApexSQL.MonitorAlerts AS A WITH (NOLOCK) 
INNER JOIN ApexSQL.vMonitoredObjects AS O ON A.SourceId = O.Id 
INNER JOIN ApexSQL.MonitorMeasurements AS M ON A.MeasurementId = M.Id
WHERE (@Group is null OR A.SourceId IN (SELECT [SourceId] FROM [ApexSQL].[fnGetAllSourceIdsForGroup](@Group)))
  AND (@Server is null OR A.SourceId IN (SELECT [SourceId] FROM [ApexSQL].[fnGetAllSourceIdsForServer](@Server)))
  AND (@Measurements is null OR A.MeasurementId IN (SELECT [SelectedId] FROM [ApexSQL].[fnParseListGuid](@Measurements, ' ')))
  AND (@States is null OR A.State IN (SELECT [SelectedInt] FROM [ApexSQL].[fnParseListInt](@States, ' ')))
  AND (@Checked is null OR A.Checked IN (SELECT Convert(bit, [SelectedInt]) FROM [ApexSQL].[fnParseListInt](@Checked, ' ')))
  AND (@StartDate is null OR A.TimeRaised >= @StartDate)
  AND (@EndDate is null OR A.TimeRaised <= @EndDate)
GROUP BY M.Caption, 
		 M.Id, A.SourceId, 
		 CONVERT(date, A.TimeRaised), 
		 (CASE WHEN O.[Type] = 3 THEN (CASE WHEN O.[ServerName] = '.' THEN O.[MachineName] ELSE (O.[MachineName] + '\' + O.[ServerName]) END + '.' + O.[Name])
			  WHEN O.[Type] = 4 THEN (O.[MachineName] + '.' + O.[Name]) 
			  WHEN O.[Type] IN (6, 7) THEN (O.[AgName] + '.' + O.[Name])
              WHEN O.[Type] = 1 THEN O.[Name] 
			  WHEN O.[Type] = 5 THEN (CASE WHEN O.[ServerName] = '.' THEN O.[MachineName] ELSE (O.[MachineName] + '\' + O.[ServerName]) END + '.' + O.[DatabaseName] + '.' + O.[Name])
			  ELSE (CASE WHEN O.[ServerName] = '.' THEN O.[MachineName] ELSE (O.[MachineName] + '\' + O.[ServerName]) END) END), 
		 M.Type, 
		 M.[Group]
)
GO

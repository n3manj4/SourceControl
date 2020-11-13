SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: February, 2019
-- Description:	Returns system availability for failover
-- =============================================
CREATE FUNCTION [ApexSQL].[fnGetSystemAvailabilityForFailoverServer]
(
	@SourceId uniqueidentifier, 
	@StartDate datetimeoffset(7), 
	@EndDate   datetimeoffset(7),
	@Interval int = 0
)
RETURNS TABLE 
AS
RETURN 
(
	  WITH sources AS
      (
          SELECT STUFF((SELECT ' ' + CAST([MachineId] AS nvarchar(MAX)) AS [text()]
                        FROM [ApexSQL].[MonitorServerClusterNodes]
                        WHERE [ServerId] = @SourceId
                        FOR XML PATH ('')), 1, 1, '') AS [SourceIds]
      )
      SELECT (SELECT [ParentId] FROM [ApexSQL].[MonitorServers] WHERE [Id] = @SourceId) AS [SourceId],
			 MAX([Value]) AS [Value], 
             [ApexSQL].[fnTruncateDateSeconds]([MeasuredAt], @Interval) AS [MeasuredAt]
	  FROM [ApexSQL].[fnMeasuredValues](@StartDate, @EndDate, (SELECT [SourceIds] FROM sources), '1D0A0513-8FD1-4254-A162-FC0EC930774B')
	  GROUP BY [ApexSQL].[fnTruncateDateSeconds]([MeasuredAt], @Interval)
)
GO

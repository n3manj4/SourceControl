SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: January, 2018
-- Description:	Top 10 applications with highest wait time in a database
-- =============================================
CREATE FUNCTION [ApexSQL].[fnRTopApplicationsHighestWaitTimeDatabase]
(
	@SourceId uniqueidentifier,
	@StartDate DateTimeOffset(7),
	@EndDate DateTimeOffset(7)
)
RETURNS TABLE
AS
RETURN
(
	SELECT TOP 10 LI.[Name] AS [Application|X],
				  [ApexSQL].[fnRRoundWaitTime](SUM(QW.WaitTime)) AS [Wait time [s]]|Y] 
	FROM [ApexSQL].[MonitorQueryWaits] AS QW 
	LEFT JOIN [ApexSQL].[MonitorQueryLookupInfo] AS LI ON 
		LI.[Id] = QW.[ApplicationNameId]
	WHERE Li.[Type] = 3 
	  AND QW.[DatabaseNameId] = @SourceId
	GROUP BY LI.[Name] 
	ORDER BY [Wait time [s]]|Y] DESC
)
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: January, 2018
-- Description:	Top 5 users with the highest wait times on SQL Server
-- =============================================
CREATE FUNCTION [ApexSQL].[fnRTop5UsersHighestWaitTime]
(
	@SourceId uniqueidentifier,
	@StartDate DateTimeOffset(7),
	@EndDate DateTimeOffset(7)
)
RETURNS TABLE
AS
RETURN
(
	SELECT TOP 5 LI.[Name] AS [User], 
		       [ApexSQL].[fnRRoundWaitTime](SUM(QW.[WaitTime])) AS [Wait time [s]]]
	FROM [ApexSQL].[MonitorQueryWaits] AS QW 
	LEFT JOIN [ApexSQL].[MonitorQueryLookupInfo] AS LI ON 
		LI.[Id] = QW.[LoginNameId]
	WHERE Li.[Type] = 2 
	  AND QW.[SourceId] = @SourceId
	  AND QW.[MeasuredAt] > @StartDate
	  AND QW.[MeasuredAt] < @EndDate 
	GROUP BY LI.[Name] 
	ORDER BY [Wait time [s]]] DESC
)
GO

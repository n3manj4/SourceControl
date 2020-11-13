SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: December, 2018
-- Description:	Top 5 users with the highest number of resolved alerts
-- =============================================
CREATE FUNCTION [ApexSQL].[fnRTop5UsersHighestNumberOfResolvedAlerts]
(
	@SourceId uniqueidentifier,
	@StartTime DateTimeOffset(7),
	@EndTime DateTimeOffset(7)
)
RETURNS TABLE 
AS
RETURN
(
	SELECT TOP 5 MAX(MU.Username) AS [User],
		        COUNT(*) AS [Number of resolved alerts]
	FROM [ApexSQL].[MonitorAlerts] AS MA 
	LEFT JOIN  [ApexSQL].[MonitorUsers] AS MU ON 
		MA.UserResolved = MU.Username
	WHERE MA.SourceId = @SourceId
	  AND MA.TimeResolved > @StartTime
	  AND MA.TimeResolved < @EndTime
	GROUP BY MA.Id
	ORDER BY [Number of resolved alerts] DESC
)
GO

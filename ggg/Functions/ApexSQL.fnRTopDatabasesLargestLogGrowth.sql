SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: January, 2018
-- Description:	Top 10 databases with largest log growth for a specified period of time
-- =============================================
CREATE FUNCTION [ApexSQL].[fnRTopDatabasesLargestLogGrowth]
(
	@SourceId uniqueidentifier,
	@StartDate DateTimeOffset(7),
	@EndDate DateTimeOffset(7)
)
RETURNS TABLE
AS
RETURN
(
	SELECT TOP 10 ss.SourceName AS [Database|X], 
		          R.Y AS [Log growth [MB]]|Y]
	FROM
	(
		SELECT SourceId, 
			   SUM(Value) AS Y
		FROM [ApexSQL].[fnMeasuredValues](@StartDate, @EndDate, NULL, '3D50B34B-0D2E-4D86-8891-593E1830954B') as mv
		WHERE SourceId IN (SELECT SourceId FROM [ApexSQL].[fnRGetAllDatabasesFromServers](@SourceId))
		GROUP BY SourceId
	) AS R
	LEFT JOIN (SELECT * FROM [ApexSQL].[fnRGetAllDatabasesFromServers](@SourceId)) AS ss ON 
		R.SourceId = ss.SourceId
	ORDER BY R.Y DESC
)
GO

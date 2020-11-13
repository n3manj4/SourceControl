SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: July, 2018
-- Description:	Compare total number of alerts with previous period
-- =============================================
CREATE FUNCTION [ApexSQL].[fnRCompareAlertsTable]
(
	@SourceId uniqueidentifier,
	@StartDate DateTimeOffset(7), 
	@EndDate DateTimeOffset(7)
)
RETURNS @result TABLE 
(
	[Total number of alerts] int,
	[Total number of alerts in previous period] int,
	[Difference in total number of alerts] int,
	[Difference in total number of alerts [%]]] int,
	[Status] nvarchar(MAX)
)
AS
BEGIN
	DECLARE @totalNumOfAlerts int
	SET @totalNumOfAlerts = (SELECT COUNT(*)			
		FROM [ApexSQL].[MonitorAlerts]  
		WHERE TimeRaised >= @StartDate
		AND TimeRaised <= @EndDate
		AND SourceId IN ( SELECT SourceId FROM ApexSQL.fnRGetAllSourcesForServer(@SourceId)));

    DECLARE @totalNumOfAlertsPrevious int
	SET @totalNumOfAlertsPrevious = (SELECT COUNT(*)			
		FROM [ApexSQL].[MonitorAlerts]
		WHERE TimeRaised >= DATEADD(DAY , -DATEDIFF(DAY ,  @StartDate, @EndDate), @StartDate)
		AND TimeRaised <= @StartDate
		AND SourceId IN ( SELECT SourceId FROM ApexSQL.fnRGetAllSourcesForServer(@SourceId)));

	DECLARE @difference int
	SET @difference = (@totalNumOfAlerts - @totalNumOfAlertsPrevious);
	
	INSERT INTO @result
		SELECT	@totalNumOfAlerts			AS [Total number of alerts],
				@totalNumOfAlertsPrevious	AS [Total number of alerts in previous period],
				@difference					AS [Difference in total number of alerts],
				CASE
					WHEN @difference = 0 THEN 0
					WHEN @totalNumOfAlertsPrevious = 0 THEN 100
					ELSE ABS(@difference * 100 / @totalNumOfAlertsPrevious)
				END AS [Difference in total number of alerts [%]]],
				CASE 
					WHEN @difference > 0 THEN 'increase'
					WHEN @difference < 0 THEN 'decrease'
					ELSE ''
				END AS [Status]
		RETURN
END
GO

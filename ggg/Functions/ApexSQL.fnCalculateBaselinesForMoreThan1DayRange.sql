SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: March, 2019
-- Description:	Return baselines calculated for each hour
-- =============================================
CREATE FUNCTION [ApexSQL].[fnCalculateBaselinesForMoreThan1DayRange]
(
	@StartDate datetimeoffset(7),
	@EndDate   datetimeoffset(7),
    @ServerId uniqueidentifier,
	@Measurements nvarchar(MAX)
)
RETURNS @Result TABLE 
(
    [Id]            uniqueidentifier,
    [SourceId]      uniqueidentifier,
    [MeasurementId] uniqueidentifier,
    [WaitTypeId]    uniqueidentifier,
    [Average]       float,
    [Min]           float,
    [Max]           float,
    [StdDeviation]  float,
    [HourOfDay]     int,
    [DayOfWeek]     int
)
BEGIN
    DECLARE @Sources varchar(MAX)
    SELECT  @Sources = COALESCE(@Sources + ' ', '') + CAST([Id] AS nvarchar(MAX)) FROM [ApexSQL].[vMonitoredObjectsIds] WHERE [ServerId] = @ServerId AND [Type] <> 5

    INSERT INTO @Result
    SELECT (SELECT [Id] FROM [ApexSQL].[vGenerateNewId]) AS [Id], 
           [SourceId], 
           [MeasurementId], 
           [WaitTypeId], 
		   AVG([Value]) AS [Average], 
           MIN([Value]) AS [Min], 
           MAX([Value]) AS [Max], 
           ISNULL(STDEV([Value]), 0) AS [StdDeviation], 
		   DATEPART(HOUR, [MeasuredAt]) AS [HourOfDay], 
           NULL AS [DayOfWeek]
    FROM [ApexSQL].[fnMeasuredValuesMultiParam](@StartDate, @EndDate, @Sources, @Measurements)
	GROUP BY [SourceId], 
             [MeasurementId], 
             [WaitTypeId], 
             DATEPART(HOUR, [MeasuredAt])
    RETURN
END
GO

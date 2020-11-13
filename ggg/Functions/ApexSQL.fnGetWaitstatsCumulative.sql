SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: January, 2017
-- Description:	Returns Wait stats cumulative over interval
-- =============================================
CREATE FUNCTION [ApexSQL].[fnGetWaitstatsCumulative]
(
	@SourceId uniqueidentifier, 
	@StartDate DateTimeOffset, 
	@EndDate DateTimeOffset,
	@Interval int = 0
)
RETURNS TABLE 
AS
RETURN 
(
	  SELECT WaitTypeId, SUM([Value]) as [Value], ApexSQL.fnTruncateDate(MeasuredAt, @Interval) as [MeasuredAt]
      FROM   [ApexSQL].[fnMeasuredValues](@StartDate, @EndDate, @SourceId, '9EF9CB90-766C-41F5-8A54-BF6FAC16AC9D')
      GROUP BY WaitTypeId, ApexSQL.fnTruncateDate(MeasuredAt, @Interval)
)
GO

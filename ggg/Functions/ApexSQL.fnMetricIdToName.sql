SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================            
-- Author:		ApexSQL LLC
-- Create date: November, 2016
-- Description:	Returns the name of Metric
-- =============================================
CREATE FUNCTION [ApexSQL].[fnMetricIdToName]
(
	@MeasurmentId  uniqueidentifier
)
RETURNS NVARCHAR(500)
AS
BEGIN
	
	DECLARE @MeasurmentName NVARCHAR(500);

	SELECT TOP 1 @MeasurmentName = [Caption]
		FROM ApexSQL.MonitorMeasurements 
		WHERE Id = @MeasurmentId

	RETURN @MeasurmentName
END
GO

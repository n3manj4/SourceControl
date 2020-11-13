SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: November, 2016
-- Description:	Rounds the measured value
-- =============================================
CREATE FUNCTION [ApexSQL].[fnRoundMeasuredValue]
(
	@measuredValue float
)
RETURNS float
AS
BEGIN
    IF @measuredValue > 100   RETURN CAST(CAST(@measuredValue AS numeric(24, 0)) AS float)
	IF @measuredValue > 0.01  RETURN CAST(CAST(@measuredValue AS numeric(24, 2)) AS float)
	IF @measuredValue > 0.001 RETURN CAST(CAST(@measuredValue AS numeric(24, 3)) AS float)
	                          RETURN CAST(CAST(@measuredValue AS numeric(24, 5)) AS float)	
END
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: January, 2019
-- Description:	Truncates date to beginning of the day
-- =============================================
CREATE FUNCTION [ApexSQL].[fnTruncateDay](@date datetimeoffset(7)) 
RETURNS datetimeoffset(7) 
AS
BEGIN
    RETURN TODATETIMEOFFSET(CAST(@date AS date), DATEPART(TZOFFSET, @date))
END
GO

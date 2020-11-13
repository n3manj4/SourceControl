SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================            
-- Author:		ApexSQL LLC
-- Create date: June, 2018
-- Description:	Rounds wait time to seconds up to -1 second mistake
-- =============================================
CREATE FUNCTION [ApexSQL].[fnRRoundWaitTime]
(
    @timeMiliseconds bigint
)
RETURNS bigint
AS
BEGIN
    DECLARE @timeSeconds decimal(38, 3);
    SET @timeSeconds = CAST(@timeMiliseconds AS decimal(38, 3)) / 1000;

	IF ABS(@timeMiliseconds / 1000 - @timeSeconds) < 0.1
        RETURN FLOOR(@timeSeconds);

    RETURN CEILING(@timeSeconds);
END
GO

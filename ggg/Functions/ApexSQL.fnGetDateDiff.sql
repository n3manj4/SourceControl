SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: November, 2016
-- Description:	Calculates date diff from fixed interval in past
-- =============================================
CREATE FUNCTION [ApexSQL].[fnGetDateDiff](@date datetimeoffset, @interval int) 
RETURNS int 
AS
BEGIN
	DECLARE @ret int;
	-- Add the SELECT statement with parameter references here
	set @ret = DATEDIFF(MINUTE, TODATETIMEOFFSET('1990-1-1', DATEPART(TZ,SYSDATETIMEOFFSET())), @date) / @interval
	RETURN @ret
END
GO

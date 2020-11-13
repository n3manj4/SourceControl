SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: November, 2016
-- Description:	Truncates date in specified seconds
-- =============================================
CREATE FUNCTION [ApexSQL].[fnTruncateDateSeconds](@date datetimeoffset, @interval int) 
RETURNS datetimeoffset 
AS
BEGIN
	-- If interval is zero or less we dont truncate
	If @interval <= 0 RETURN @date

	DECLARE @ret datetimeoffset;
	-- Add the SELECT statement with parameter references here
	set @ret = DATEADD(SECOND, (DATEDIFF(SECOND, TODATETIMEOFFSET('1990-1-1', DATEPART(TZ,SYSDATETIMEOFFSET())), @date) / @interval )*@interval, TODATETIMEOFFSET('1990-1-1', DATEPART(TZ,SYSDATETIMEOFFSET())))
	RETURN @ret
END
GO

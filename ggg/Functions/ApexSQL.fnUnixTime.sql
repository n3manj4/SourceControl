SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- -----------------------------------------------
-- © 2019 Quest Software Inc. ALL RIGHTS RESERVED.
-- -----------------------------------------------
CREATE FUNCTION [ApexSQL].[fnUnixTime](@date datetimeoffset) 
RETURNS bigint 
AS
BEGIN
	return DATEDIFF_BIG(MILLISECOND, '1970-01-01 00:00:00.0000000', @date)
END
GO

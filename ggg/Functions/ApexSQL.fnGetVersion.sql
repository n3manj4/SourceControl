SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [ApexSQL].[fnGetVersion] ()
RETURNS FLOAT 
AS
BEGIN 
	RETURN 26.26
END 
GO

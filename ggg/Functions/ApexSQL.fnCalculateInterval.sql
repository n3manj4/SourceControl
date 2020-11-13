SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO


----------------------------------------------------------------------------------------------------------------
-- SCALAR FUNCTIONS --------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: October, 2018
-- Description:	Calculates default interval
-- =============================================
CREATE FUNCTION [ApexSQL].[fnCalculateInterval]
(
	@From datetimeoffset(7),
	@To   datetimeoffset(7)
)
RETURNS int
AS
BEGIN

	DECLARE @truncatedDateFrom datetimeoffset(7);
	DECLARE @truncatedDateTo datetimeoffset(7);

	DECLARE @period bigint;
	-- Add the SELECT statement with parameter references here
	SELECT @truncatedDateFrom = TODATETIMEOFFSET(DATEADD(dd, DATEDIFF(dd,0, @From) + 1, 0), DATEPART(TZ,SYSDATETIMEOFFSET())),
		   @truncatedDateTo   = TODATETIMEOFFSET(DATEADD(dd, DATEDIFF(dd,0, @To), 0), DATEPART(TZ,SYSDATETIMEOFFSET()))
	
	SET @period =
		CAST(DATEDIFF(DAY,    @truncatedDateFrom, @truncatedDateTo) AS bigint) *	CAST(1440 AS bigint) +
		CAST(DATEDIFF(MINUTE, @From, @truncatedDateFrom) AS bigint) + 
		CAST(DATEDIFF(MINUTE, @truncatedDateTo, @To) AS bigint) 

	IF @period <= 1 *  30       RETURN 1;
	IF @period <= 1 *  65       RETURN 5;
	IF @period <= 12 * 65      RETURN 30;
	IF @period <= 24 * 65      RETURN 60;
	IF @period <= 7 * 24 * 60  RETURN 3 * 60;
	                           RETURN 24* 60;
END
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: January, 2019
-- Description:	Unpacks archived values and periods for measured value
-- =============================================
CREATE FUNCTION [ApexSQL].[fnSplitValuesPeriods]
(
    @values  nvarchar(MAX),
    @periods nvarchar(MAX)
)
RETURNS @Items TABLE
(
    [Value]  float,
    [Period] int
)
BEGIN
    DECLARE @startVal int
	DECLARE @endVal   int
	
	DECLARE @startPeriod int
	DECLARE @endPeriod   int
	
	DECLARE @periodSum int
	DECLARE @periodVal int

	SET @startVal = 1
	SET	@endVal = CHARINDEX(' ', @values)

	SET @startPeriod = 1
	SET	@endPeriod = CHARINDEX(' ', @periods)
	
	SET @periodSum =  0
	SET @periodVal = -1

	IF (@endPeriod = 0)
	BEGIN
		SET @periodVal = CAST(@periods AS int)
		SET @periodSum = -1 * @periodVal
	END

	WHILE (@startVal < LEN(@values) + 1)
	BEGIN 
        
		IF (@endVal = 0)
			SET @endVal = LEN(@values) + 1

		IF (@endPeriod = 0)
			SET @endPeriod = LEN(@periods) + 1

		IF (@periodVal = -1)
			SET @periodSum = @periodSum + CAST(SUBSTRING(@periods, @startPeriod, @endPeriod - @startPeriod) AS int)
		ELSE
			SET @periodSum = @periodSum + @periodVal

        INSERT INTO @Items ([Value], [Period])  
        VALUES
		(
			CAST(SUBSTRING(@values, @startVal, @endVal - @startVal) AS float), 
			@periodSum
		) 
        
		SET @startVal = @endVal + 1 
        SET @endVal = CHARINDEX(' ', @values, @startVal)

		SET @startPeriod = @endPeriod + 1 
        SET @endPeriod = CHARINDEX(' ', @periods, @startPeriod)

    END 
    RETURN 
END
GO

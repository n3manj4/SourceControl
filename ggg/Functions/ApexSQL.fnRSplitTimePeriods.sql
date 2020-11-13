SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: October, 2018
-- Description:	Splits multiple time periods
-- =============================================
CREATE FUNCTION [ApexSQL].[fnRSplitTimePeriods]
(
    @startDates nvarchar(MAX),
    @endDates   nvarchar(MAX)
)
RETURNS TABLE
AS
RETURN
(
        SELECT s.[StartDate] AS [StartDate],
               e.[EndDate]   AS [EndDate],
               (
                   SELECT TOP 1 [Item]
                   FROM [ApexSQL].[fnSplitStrings](@startDates, '|')
               ) AS [DefaultStartDate],
               (
                   SELECT TOP 1 [Item]
                   FROM [ApexSQL].[fnSplitStrings](@endDates, '|')
               ) AS [DefaultEndDate]
        FROM
	    (
		    SELECT [Item] AS [StartDate], 
			       ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS [R] 
		    FROM [ApexSQL].[fnSplitStrings](@startDates, '|')
	    ) AS s
	    JOIN
	    (
		    SELECT [Item] AS [EndDate], 
			       ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS [R] 
		    FROM [ApexSQL].[fnSplitStrings](@endDates, '|')
	    ) AS e
	    ON s.[R] = e.[R]
)
GO

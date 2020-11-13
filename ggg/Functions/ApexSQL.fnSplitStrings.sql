SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

----------------------------------------------------------------------------------------------------------------
-- TABLE FUNCTIONS ---------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------

-- =============================================
-- Author:  ApexSQL LLC
-- Create date: January, 2019
-- Description: Returns list from strings
-- =============================================
CREATE FUNCTION [ApexSQL].[fnSplitStrings]
(
    @list      nvarchar(MAX),
	@delimiter nvarchar(1)
)
RETURNS TABLE
AS
RETURN
(
    SELECT y.i.value('(./text())[1]', 'nvarchar(4000)') AS [Item]
    FROM 
    ( 
    	SELECT x = CONVERT(XML, '<i>' + REPLACE(@list, @delimiter, '</i><i>') + '</i>').query('.')
    ) AS a CROSS APPLY x.nodes('i') AS y(i)
)
GO

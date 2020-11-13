SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: January, 2017
-- Description:	Return parsed integer list
-- =============================================
CREATE FUNCTION [ApexSQL].[fnParseListInt]
(
   @List       NVARCHAR(MAX),
   @Delimiter  NVARCHAR(1)
) 
RETURNS TABLE 
AS
RETURN
(
	SELECT CONVERT(int, Item) as SelectedInt 
	FROM [ApexSQL].[fnSplitStrings](@List, @Delimiter)
)
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: February, 2018
-- Description:	Parse list of Guids
-- =============================================
CREATE FUNCTION [ApexSQL].[fnParseListGuid]
(
   @List      nvarchar(MAX),
   @Delimiter nvarchar(1)
) 
RETURNS TABLE 
AS
RETURN
(
    SELECT CAST([Item] AS uniqueidentifier) AS [SelectedId]
    FROM [ApexSQL].[fnSplitStrings](@List, @Delimiter)
)
GO

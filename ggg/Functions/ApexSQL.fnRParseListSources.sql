SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: February, 2018
-- Description:	Parse list of sources
-- =============================================
CREATE FUNCTION [ApexSQL].[fnRParseListSources]
(
    @list nvarchar(max), 
    @filterOptions int
) 
RETURNS TABLE 
AS
RETURN
(
	SELECT 
		CAST([Item] as uniqueidentifier) AS [SelectedId],
		CASE
			WHEN @filterOptions = 1  THEN mov.[MachineName]
			WHEN @filterOptions = 6  THEN [ApexSQL].[fnRGetFullServerName](mov.[ServerId]) + ' - ' + mov.[DatabaseName]
            WHEN @filterOptions = 33 THEN mov.[MachineName] + ' - ' + mov.[DeviceName]
			ELSE [ApexSQL].[fnRGetFullServerName](mov.[ServerId])
		END AS [Name]
	FROM [ApexSQL].[fnSplitStrings](@list, ' ') AS list 
	LEFT JOIN [ApexSQL].[vMonitoredObjects] mov ON 
		CAST([Item] AS uniqueidentifier) = mov.[Id]
)
GO

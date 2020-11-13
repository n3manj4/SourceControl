SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: February, 2018
-- Description:	Parse list of measurements
-- =============================================
CREATE FUNCTION [ApexSQL].[fnRParseListMeasurments]
(
    @list nvarchar(max)
) 
RETURNS TABLE 
AS
RETURN
(
    SELECT CAST([Item] AS uniqueidentifier) AS [SelectedId],
           mm.[Caption] AS [Name], 
           mm.[UnitOfMeasurement] AS [Unit]
    FROM      [ApexSQL].[fnSplitStrings](@list, ' ') AS list 
    LEFT JOIN [ApexSQL].[MonitorMeasurements] AS mm ON 
        CAST([Item] AS uniqueidentifier) = mm.[Id] 
)
GO

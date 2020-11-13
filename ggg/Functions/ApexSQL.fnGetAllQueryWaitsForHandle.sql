SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: July, 2018
-- Description:	Returns all query waits for specified SQL handle
-- =============================================
CREATE FUNCTION [ApexSQL].[fnGetAllQueryWaitsForHandle]
(
    @sqlHandle binary(20),
    @startDate datetimeoffset(7),
    @endDate datetimeoffset(7)
)
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM [ApexSQL].[MonitorQueryWaits]
    WHERE 
        [SqlHandle] = @sqlHandle
    AND [MeasuredAt] >= @startDate
    AND [MeasuredAt] <= @endDate
)
GO

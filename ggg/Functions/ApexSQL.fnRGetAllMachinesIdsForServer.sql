SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

------------------------------------------------------------------------------------------------
-- REPORTS TABLE FUNCTIONS ---------------------------------------------------------------------
------------------------------------------------------------------------------------------------

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: February, 2019
-- Description:	Returns all machine IDs for server
-- =============================================
CREATE FUNCTION [ApexSQL].[fnRGetAllMachinesIdsForServer]
(
	@ServerId uniqueidentifier
)
RETURNS @result TABLE 
(
	[MachineIds] nvarchar(MAX)
)
AS
BEGIN

DECLARE @val nvarchar(MAX);

WITH cte 
AS
(
	SELECT [MachineId] as [Id]
	FROM [ApexSQL].[MonitorServerClusterNodes]
	WHERE ServerId = @ServerId
	UNION ALL 
	SELECT [ParentId] as [Id]
	FROM [ApexSQL].[MonitorServers]
	WHERE [Id] = @ServerId
	AND [IsClustered] = 0
)	
SELECT @val = COALESCE(@val + ' ' + CAST([Id] AS nvarchar(MAX)),CAST([Id] AS nvarchar(MAX))) 
FROM cte

INSERT INTO @result
SELECT CAST(@val AS nvarchar(MAX))

RETURN 
END
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- -----------------------------------------------
-- © 2019 Quest Software Inc. ALL RIGHTS RESERVED.
-- -----------------------------------------------

 ------------------------------------------------------------------------------------------------
-- REPORTS SCALAR FUNCTIONS --------------------------------------------------------------------
------------------------------------------------------------------------------------------------

-- =============================================            
-- Author:		ApexSQL LLC
-- Create date: November, 2016
-- Description:	Returns full name of the SQL Server instance
-- =============================================
CREATE FUNCTION [ApexSQL].[fnRGetFullServerName]
(
	@serverId  uniqueidentifier
)
RETURNS NVARCHAR(500)
AS
BEGIN	
	DECLARE @serverName NVARCHAR(500);
	SELECT TOP 1 @serverName = 
		CASE 
			WHEN mov.[ServerName] = '.' THEN mov.[MachineName]
			ELSE mov.[MachineName] + '\' + mov.[ServerName]
		END
	FROM [ApexSQL].[vMonitoredObjects] AS mov
	WHERE mov.[ServerId] = @serverId 
	RETURN @serverName
END
GO

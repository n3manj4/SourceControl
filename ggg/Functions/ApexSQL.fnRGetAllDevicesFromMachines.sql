SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: February, 2018
-- Description:	Gets all the databases from servers
-- =============================================
CREATE FUNCTION [ApexSQL].[fnRGetAllDevicesFromMachines]
(
	@sources nvarchar(MAX),
	@deviceType int
)
RETURNS TABLE
AS
RETURN
(
	SELECT 
        d.[Id] AS [DeviceId], 
        d.[DeviceName] AS [DeviceName],
        m.[MachineName] AS [MachineName]
	FROM [ApexSQL].[MonitorMachines] AS m WITH (NOLOCK)
	LEFT JOIN [ApexSQL].[MonitorDevices] AS d ON 
        d.[ParentId] = m.[Id]
	WHERE 
        m.[Id] IN (SELECT * FROM [ApexSQL].[fnParseListGuid](@sources, ' '))
	AND d.[DeviceType] = @deviceType
	GROUP BY 
        d.[Id], 
        d.[DeviceName], 
        m.[MachineName]
)
GO

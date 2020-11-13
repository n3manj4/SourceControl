SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: April, 2018
-- Description:	Resolves system sources to system or devices
-- =============================================
CREATE FUNCTION [ApexSQL].[fnRResolveSystemSourcesByMeasurement]
(
	@sources nvarchar(MAX),
	@measurementId uniqueidentifier
)
RETURNS @result TABLE
(
	[SourceId] uniqueidentifier,
	[MachineName] nvarchar(MAX),
    [DeviceName] nvarchar(MAX)
) 
AS
BEGIN
	DECLARE @deviceType int;
	SET @deviceType = 
	(
		SELECT TOP 1 [DeviceType] 
		FROM [ApexSQL].[vMonitorSystemMetrics] 
		WHERE [Id] = @measurementId
	)

	IF @deviceType = 0
		INSERT INTO @result
		SELECT 
            [SelectedId],
            [Name],
            ''
        FROM [ApexSQL].[fnRParseListSources](@sources, 1)		
	ELSE
		INSERT INTO @result
		SELECT 
            [DeviceId],
            [MachineName],
            [DeviceName]
        FROM [ApexSQL].[fnRGetAllDevicesFromMachines](@sources, @deviceType)
	RETURN
END
GO

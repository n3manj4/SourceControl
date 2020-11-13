SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

------------------------------------------------------------------------------------------------
-- REPORTS VIEWS -------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: April, 2018
-- Description:	Creates view for system metrics and their source type
-- =============================================
CREATE VIEW [ApexSQL].[vMonitorSystemMetrics]
AS
	
	SELECT
		'CA296671-94A2-4350-B89E-0EB3576D59E8' AS [Id],
		0 AS [DeviceType]
	UNION ALL
	SELECT
		'DB6C5C64-E390-4C18-95B9-4E1162D9F594' AS [Id],
		1 AS [DeviceType]
	UNION ALL
	SELECT
		'99CAE97A-5ABE-4C18-972E-6463114FC4F9' AS [Id],
		0 AS [DeviceType]
	UNION ALL
	SELECT
		'7F8B8AF5-BF00-4D2D-A696-43E0B3D2DDC3' AS [Id],
		0 AS [DeviceType]
	UNION ALL
	SELECT
		'111BB4B5-1EAD-477A-8EA9-B1C16AEFCBE4' AS [Id],
		0 AS [DeviceType]
	UNION ALL
	SELECT
		'7EA0A8F3-EBF8-471E-A0DA-EF4DB311E0BE' AS [Id],
		0 AS [DeviceType]
	UNION ALL
	SELECT
		'65827201-8CC5-4093-8F6B-CF4A825E4C8E' AS [Id],
		2 AS [DeviceType]
	UNION ALL
	SELECT
		'F3633DAE-06D8-47D0-8E66-996A35D18D11' AS [Id],
		2 AS [DeviceType]
	UNION ALL
	SELECT
		'341C89AF-9732-4B6D-9F52-9CC6F0089504' AS [Id],
		2 AS [DeviceType]
	UNION ALL
	SELECT
		'D5E8D9A4-4E75-4423-B1CF-6A3B4C89A118' AS [Id],
		3 AS [DeviceType]
	UNION ALL
	SELECT
		'9576E129-FA68-4902-A20C-94FE3C6CBE32' AS [Id],
		2 AS [DeviceType]
	UNION ALL
	SELECT
		'B68CDF3E-0525-4B17-8EAE-616D245BEC7E' AS [Id],
		2 AS [DeviceType]
	UNION ALL
	SELECT
		'FD986819-8027-4F70-A6CA-30E6C39BFBA8' AS [Id],
		2 AS [DeviceType]
	UNION ALL
	SELECT
		'18BB1CCD-22D5-4200-9054-391786E192EE' AS [Id],
		2 AS [DeviceType]
	UNION ALL
	SELECT
		'C559D85E-DF5D-4705-9ACA-3A02136B3C6D' AS [Id],
		2 AS [DeviceType]
	UNION ALL
	SELECT
		'5417C149-4A6D-4A8C-AD26-7EC139A1CDA8' AS [Id],
		2 AS [DeviceType]
GO

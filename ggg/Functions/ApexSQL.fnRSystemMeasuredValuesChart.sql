SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: February, 2018
-- Description:	System report datasources
-- =============================================
CREATE FUNCTION [ApexSQL].[fnRSystemMeasuredValuesChart]
(
	@machines nvarchar(MAX),
	@measurements nvarchar(MAX), 
	@startDate datetimeoffset, 
	@endDate datetimeoffset
)
RETURNS @result TABLE
(
	[X] bigint,
	[Y] float,
	[NonTemplateSerie] nvarchar(MAX),
    [TemplateSerie] nvarchar(MAX)
)
AS
BEGIN

	DECLARE @measurementId uniqueidentifier;
	DECLARE @measurementName nvarchar(MAX);
	DECLARE @measurementUnit nvarchar(MAX);

	DECLARE Measurements CURSOR
	FOR
		SELECT * 
		FROM [ApexSQL].[fnRParseListMeasurments](@measurements)

	OPEN Measurements
	FETCH NEXT FROM Measurements INTO @measurementId, @measurementName, @measurementUnit
	WHILE @@FETCH_STATUS = 0
	BEGIN

		INSERT INTO @result
		SELECT 
			[ApexSQL].[fnUnixTime](MAX([ApexSQL].[fnTruncateDate](mv.[MeasuredAt], [ApexSQL].[fnCalculateInterval](@startDate, @endDate)))) AS [X], 
			ROUND(AVG(mv.[Value]), 2) AS [Y],
			CASE
				WHEN @measurementUnit = '' THEN (@measurementName + ' [-]' + ' - ' + d.[MachineName] + CASE WHEN d.[DeviceName] = '' THEN '' ELSE ' - ' + d.[DeviceName] END)
				ELSE (@measurementName + ' [' + @measurementUnit + ']'     + ' - ' + d.[MachineName] + CASE WHEN d.[DeviceName] = '' THEN '' ELSE ' - ' + d.[DeviceName] END)
			END AS [NonTemplateSerie],
            CASE
				WHEN @measurementUnit = '' THEN (@measurementName + ' [-]' + CASE WHEN d.[DeviceName] = '' THEN '' ELSE ' - ' + d.[DeviceName] END)
				ELSE (@measurementName + ' [' + @measurementUnit + ']' + CASE WHEN d.[DeviceName] = '' THEN '' ELSE ' - ' + d.[DeviceName] END) 
			END AS [TemplateSerie]
		FROM [ApexSQL].[fnMeasuredValues](@startDate, @endDate, NULL, @measurementId) AS mv
		LEFT JOIN (SELECT * FROM [ApexSQL].[fnRResolveSystemSourcesByMeasurement](@machines, @measurementId)) AS d ON 
			d.[SourceId] = mv.[SourceId]
		WHERE mv.[SourceId] IN (SELECT [SourceId] FROM [ApexSQL].[fnRResolveSystemSourcesByMeasurement](@machines, @measurementId))
		GROUP BY 
			d.[DeviceName],
			d.[MachineName],
			ApexSQL.fnGetDateDiff(mv.[MeasuredAt], [ApexSQL].[fnCalculateInterval](@startDate, @endDate))

	FETCH NEXT FROM Measurements INTO @measurementId, @measurementName, @measurementUnit
	END
	CLOSE Measurements
	DEALLOCATE Measurements

	RETURN
END
GO

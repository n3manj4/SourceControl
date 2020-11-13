SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: January, 2017
-- Description:	Return single alerts for grouped alerts based on params
-- =============================================
CREATE FUNCTION [ApexSQL].[fnGetSingleAlertsForGroupedAlert]
(
	@MeasurementId uniqueidentifier,
	@SourceId uniqueidentifier,
	@DateRaised datetimeoffset(7),
	@States nvarchar(MAX),
	@Checked nvarchar(MAX),
	@Severities nvarchar(max),
	@DateFrom datetimeoffset(7),
	@DateTo datetimeoffset(7)
) 
RETURNS TABLE 
AS
RETURN 
(
SELECT *
FROM ApexSQL.MonitorAlerts AS A WITH (NOLOCK) 
WHERE A.MeasurementId = @MeasurementId 
  AND A.SourceId = @SourceId 
  AND (@DateRaised is null OR CONVERT(date, A.TimeRaised) = Convert(date, @DateRaised))
  AND (@States is null OR A.State IN (SELECT [SelectedInt] FROM [ApexSQL].[fnParseListInt](@States, ' ')))
  AND (@Checked is null OR A.Checked IN (SELECT Convert(bit, [SelectedInt]) FROM [ApexSQL].[fnParseListInt](@Checked, ' ')))
  AND (@Severities is null OR A.Severity IN (SELECT [SelectedInt] FROM [ApexSQL].[fnParseListInt](@Severities, ' ')))
  AND (@DateFrom is null OR A.TimeRaised >= @DateFrom)
  AND (@DateTo is null OR A.TimeRaised <= @DateTo)
)
GO

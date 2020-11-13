SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================            
-- Author:		ApexSQL LLC
-- Create date: January, 2018
-- Description:	Returns the name of Severity
-- =============================================
CREATE FUNCTION [ApexSQL].[fnAlertSeverityIdToName]
(
	@severityId int
)
RETURNS NVARCHAR(500)
AS
BEGIN
	DECLARE @severityName NVARCHAR(500);
	SELECT TOP 1 @severityName = Name
	FROM ApexSQL.MonitorAlertSeverities 
	WHERE Id = @severityId
	RETURN @severityName
END
GO

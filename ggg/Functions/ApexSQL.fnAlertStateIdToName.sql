SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================            
-- Author:		ApexSQL LLC
-- Create date: January, 2018
-- Description:	Returns the name of Alert State
-- =============================================
CREATE FUNCTION [ApexSQL].[fnAlertStateIdToName]
(
	@stateId int
)
RETURNS NVARCHAR(500)
AS
BEGIN
	DECLARE @stateName NVARCHAR(500);
	SELECT TOP 1 @stateName = Name
	FROM ApexSQL.MonitorAlertStates
	WHERE Id = @stateId
	RETURN @stateName
END
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: May, 2018
-- Description:	Creates measurement availability options
-- =============================================
CREATE VIEW [ApexSQL].[vMonitorAlertSeverityStatusConverters]
AS
    SELECT
        1 AS [Severity],
        'Low' AS [SeverityConverted]
    UNION ALL
    SELECT 
        2 AS [Severity],
        'Medium' AS [SeverityConverted]
    UNION ALL
    SELECT 
        3 AS [Severity],
        'High' AS [SeverityConverted]
GO

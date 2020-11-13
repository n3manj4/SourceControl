SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: May, 2018
-- Description:	Creates measurement availability options
-- =============================================
CREATE VIEW [ApexSQL].[vMonitorStatusConverters]
AS
    SELECT 
        '1D0A0513-8FD1-4254-A162-FC0EC930774B' AS [MeasurementId],
        0 AS [Value],
        'Not accessible' AS [ValueConverted]
    UNION ALL
    SELECT 
        '1D0A0513-8FD1-4254-A162-FC0EC930774B' AS [MeasurementId],
        1 AS [Value],
        'Accessible' AS [ValueConverted]
    UNION ALL
    SELECT 
        'A5BFFAAE-CC3E-48C4-9EEC-80CB8F2354B6' AS [MeasurementId],
        0 AS [Value],
        'Offline' AS [ValueConverted]
    UNION ALL
    SELECT 
        'A5BFFAAE-CC3E-48C4-9EEC-80CB8F2354B6' AS [MeasurementId],
        1 AS [Value],
        'Online' AS [ValueConverted]
    UNION ALL
    SELECT
        '6F91E6A6-0D14-4454-8F78-7A265FCEB102' AS [MeasurementId],
        1 AS [Value],
        'Stopped' AS [ValueConverted]
    UNION ALL
    SELECT
        '6F91E6A6-0D14-4454-8F78-7A265FCEB102' AS [MeasurementId],
        2 AS [Value],
        'Other start pending' AS [ValueConverted]
    UNION ALL
    SELECT
        '6F91E6A6-0D14-4454-8F78-7A265FCEB102' AS [MeasurementId],
        3 AS [Value],
        'Other stop pending' AS [ValueConverted]
    UNION ALL
    SELECT
        '6F91E6A6-0D14-4454-8F78-7A265FCEB102' AS [MeasurementId],
        4 AS [Value],
        'Running' AS [ValueConverted]
    UNION ALL
    SELECT
        '6F91E6A6-0D14-4454-8F78-7A265FCEB102' AS [MeasurementId],
        5 AS [Value],
        'Other continue pending' AS [ValueConverted]
    UNION ALL
    SELECT
        '6F91E6A6-0D14-4454-8F78-7A265FCEB102' AS [MeasurementId],
        6 AS [Value],
        'Other pause pending' AS [ValueConverted]
    UNION ALL
    SELECT
        '6F91E6A6-0D14-4454-8F78-7A265FCEB102' AS [MeasurementId],
        7 AS [Value],
        'Paused' AS [ValueConverted]
    UNION ALL
    SELECT
        '5DCB3AA1-2FF1-45F2-9096-15F14A6E773D' AS [MeasurementId],
        0 AS [Value],
        'Online' AS [ValueConverted]
    UNION ALL
    SELECT
        '5DCB3AA1-2FF1-45F2-9096-15F14A6E773D' AS [MeasurementId],
        1 AS [Value],
        'Restoring' AS [ValueConverted]
    UNION ALL
    SELECT
        '5DCB3AA1-2FF1-45F2-9096-15F14A6E773D' AS [MeasurementId],
        2 AS [Value],
        'Recovering' AS [ValueConverted]
    UNION ALL
    SELECT
        '5DCB3AA1-2FF1-45F2-9096-15F14A6E773D' AS [MeasurementId],
        3 AS [Value],
        'Recovery pending' AS [ValueConverted]
    UNION ALL
    SELECT
        '5DCB3AA1-2FF1-45F2-9096-15F14A6E773D' AS [MeasurementId],
        4 AS [Value],
        'Suspect' AS [ValueConverted]
    UNION ALL
    SELECT
        '5DCB3AA1-2FF1-45F2-9096-15F14A6E773D' AS [MeasurementId],
        5 AS [Value],
        'Emergency' AS [ValueConverted]
    UNION ALL
    SELECT
        '5DCB3AA1-2FF1-45F2-9096-15F14A6E773D' AS [MeasurementId],
        6 AS [Value],
        'Offline' AS [ValueConverted]
GO

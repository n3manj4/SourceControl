SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: January, 2017
-- Description:	Creates view for custom reports
-- =============================================
CREATE VIEW [ApexSQL].[vMonitorCustomReports]
AS
    SELECT 
	    MM.[Id],
	    [Caption] AS [Name],
	    CASE 
	    	WHEN MM.[Id] IN 
	    	(
	    		'1D0A0513-8FD1-4254-A162-FC0EC930774B', 
	    		'A5BFFAAE-CC3E-48C4-9EEC-80CB8F2354B6', 
	    		'5DCB3AA1-2FF1-45F2-9096-15F14A6E773D',
	    		'6F91E6A6-0D14-4454-8F78-7A265FCEB102'
	    	) THEN 'Pie Line'
	    	ELSE 'Line Bar'
	    END AS [ShowAsType],
	    CASE 
	    	WHEN MM.[Id] IN 
	    	(
	    		'1D0A0513-8FD1-4254-A162-FC0EC930774B', 
	    		'A5BFFAAE-CC3E-48C4-9EEC-80CB8F2354B6', 
	    		'5DCB3AA1-2FF1-45F2-9096-15F14A6E773D',
	    		'6F91E6A6-0D14-4454-8F78-7A265FCEB102'
	    	) THEN 'SELECT * FROM [ApexSQL].[fnRMeasuredValuesPieChart]( Sources , FilterOptions , Resources , {SelectedStartTime} , {SelectedEndTime} )'
	    	WHEN MM.[Id] IN 
	    	(
	    		'CA296671-94A2-4350-B89E-0EB3576D59E8',
	    		'99CAE97A-5ABE-4C18-972E-6463114FC4F9',
	    		'7F8B8AF5-BF00-4D2D-A696-43E0B3D2DDC3',
	    		'111BB4B5-1EAD-477A-8EA9-B1C16AEFCBE4',
	    		'7EA0A8F3-EBF8-471E-A0DA-EF4DB311E0BE',
	    		'FD986819-8027-4F70-A6CA-30E6C39BFBA8', 
				'5417C149-4A6D-4A8C-AD26-7EC139A1CDA8',
	    		'18BB1CCD-22D5-4200-9054-391786E192EE', 
	    		'C559D85E-DF5D-4705-9ACA-3A02136B3C6D',
	    		'B68CDF3E-0525-4B17-8EAE-616D245BEC7E',
	    		'9576E129-FA68-4902-A20C-94FE3C6CBE32',
	    		'F3633DAE-06D8-47D0-8E66-996A35D18D11',
	    		'341C89AF-9732-4B6D-9F52-9CC6F0089504',
	    		'65827201-8CC5-4093-8F6B-CF4A825E4C8E',
	    		'D5E8D9A4-4E75-4423-B1CF-6A3B4C89A118',
	    		'DB6C5C64-E390-4C18-95B9-4E1162D9F594'
	    	) THEN 'SELECT * FROM [ApexSQL].[fnRSystemMeasuredValuesChart]( Sources , Resources , {SelectedStartTime} , {SelectedEndTime} ) ORDER BY [X]'
	    	ELSE 'SELECT * FROM [ApexSQL].[fnRMeasuredValuesChart]( Sources , FilterOptions , Resources , {SelectedStartTime} , {SelectedEndTime} ) ORDER BY [X]'
	    END AS [Datasource],
	    CASE 
	    	WHEN [Type] = 3 THEN 6
	    	ELSE [Type]
	    END AS [ReportType],
	    CASE
	    	WHEN MM.[Id] IN
	    	(
	    		'1D0A0513-8FD1-4254-A162-FC0EC930774B', 
	    		'A5BFFAAE-CC3E-48C4-9EEC-80CB8F2354B6', 
	    		'5DCB3AA1-2FF1-45F2-9096-15F14A6E773D',
	    		'6F91E6A6-0D14-4454-8F78-7A265FCEB102'
	    	) THEN 20
	    	ELSE [Group]
	    END AS [CategoryId],
	    CASE
	    	WHEN MM.[Id] IN
	    	(
	    		'A6C7BDB5-3C32-4665-9195-4E5C6E9AE654',
	    		'1D0A0513-8FD1-4254-A162-FC0EC930774B', 
	    		'A5BFFAAE-CC3E-48C4-9EEC-80CB8F2354B6', 
	    		'5DCB3AA1-2FF1-45F2-9096-15F14A6E773D',
	    		'6F91E6A6-0D14-4454-8F78-7A265FCEB102',
                '1DBC69A9-026F-4817-827A-3307DDDF31AF'
	    	) THEN 2
	    	ELSE 1
	    END AS [LineType],
	    CASE
	    	WHEN MM.[Id] IN
	    	( 
	    		'7B4671AD-8F41-4578-8C28-D21B865A3C3E',
	    		'ED41F583-FAEE-4861-97F3-D161A07162A6'
	    	) THEN 4
	    	WHEN MM.[Id] IN
	    	(
	    		'99CAE97A-5ABE-4C18-972E-6463114FC4F9',
	    		'D5E8D9A4-4E75-4423-B1CF-6A3B4C89A118'
	    	) THEN 2
	    	ELSE 1
	    END AS [YAxisType],
	    0 AS [Categorical],
	    0 AS [HasWaitType],
	    0 AS [HasAlertSeverity],
	    0 AS [HasAlertState],
	    0 AS [HasFragmentation],
        0 AS [HasMetrics]
	FROM [ApexSQL].[MonitorMeasurements] AS MM
	WHERE 
	    [Type] IN (1, 2, 3)
	AND [Id] != 'F88B1654-41BD-4DC4-93DA-191EC6142677'
	UNION ALL
    SELECT 
        '12B4F3E4-1938-4776-A6CE-04592AF99E3B' AS [Id],
        'System metric time comparison' AS [Name],
        'Line' AS [ShowAsType],
        'SELECT * FROM [ApexSQL].[fnRSystemMetricTimeComparison]( SelectedServer , SelectedDevice , Resources , {SelectedStartTime} , {SelectedEndTime} ) ORDER BY [X]' AS [Datasource],
        33 AS [ReportType],
        26 AS [CategoryId],
        0 AS [LineType],
	    0 AS [YAxisType],
	    0 AS [Categorical],
	    0 AS [HasWaitType],
	    0 AS [HasAlertSeverity],
	    0 AS [HasAlertState],
	    0 AS [HasFragmentation],
        1 AS [HasMetrics]
    UNION ALL
    SELECT 
        '13A4213F-6025-4F0A-B22F-34411EF4A3D4' AS [Id],
        'SQL Server metric time comparison' AS [Name],
        'Line' AS [ShowAsType],
        'SELECT * FROM [ApexSQL].[fnRMetricTimeComparison]( Sources , FilterOptions , Resources , {SelectedStartTime} , {SelectedEndTime} ) ORDER BY [X]' AS [Datasource],
        2 AS [ReportType],
        26 AS [CategoryId],
        0 AS [LineType],
	    0 AS [YAxisType],
	    0 AS [Categorical],
	    0 AS [HasWaitType],
	    0 AS [HasAlertSeverity],
	    0 AS [HasAlertState],
	    0 AS [HasFragmentation],
        1 AS [HasMetrics]
    UNION ALL
    SELECT 
        'E5188483-3E03-454D-BA4A-44A2A1FFC3A4' AS [Id],
        'Database metric time comparison' AS [Name],
        'Line' AS [ShowAsType],
        'SELECT * FROM [ApexSQL].[fnRMetricTimeComparison]( Sources , 6 , Resources , {SelectedStartTime} , {SelectedEndTime} ) ORDER BY [X]' AS [Datasource],
        6 AS [ReportType],
        26 AS [CategoryId],
        0 AS [LineType],
	    0 AS [YAxisType],
	    0 AS [Categorical],
	    0 AS [HasWaitType],
	    0 AS [HasAlertSeverity],
	    0 AS [HasAlertState],
	    0 AS [HasFragmentation],
        1 AS [HasMetrics]
    UNION ALL
	SELECT 
	    'B16F6A86-D3BE-4711-A503-F4475B0C5C92' AS [Id],
	    'Alerts status' AS [Name],
	    'Table' AS [ShowAsType],
	    'SELECT * FROM [ApexSQL].[fnRReportingOnAlertsStatus]( Sources , SelectedAlertState , SelectedAlertSeverity , {SelectedStartTime} , {SelectedEndTime} )' AS [Datasource],
	    2 AS [ReportType],
	    23 AS [CategoryId],
	    0 AS [LineType],
	    0 AS [YAxisType],
	    0 AS [Categorical],
	    0 AS [HasWaitType],
	    1 AS [HasAlertSeverity],
	    1 AS [HasAlertState],
	    0 AS [HasFragmentation],
        0 AS [HasMetrics]
	UNION ALL
	SELECT 
	    'CCF0C75E-22FE-43F1-9E96-BF74CE674836' AS [Id],
	    'Average alert resolution time' AS [Name],
	    'Bar Table' AS [ShowAsType],
	    'SELECT * FROM [ApexSQL].[fnRAverageTimeToResolveAlerts]( Sources , {SelectedStartTime} , {SelectedEndTime} )' AS [Datasource],
	    2 AS [ReportType],
	    23 AS [CategoryId],
	    0 AS [LineType],
	    0 AS [YAxisType],
	    1 AS [Categorical],
	    0 AS [HasWaitType],
	    0 AS [HasAlertSeverity],
	    0 AS [HasAlertState],
	    0 AS [HasFragmentation],
        0 AS [HasMetrics]
	UNION ALL
	SELECT 
	    '340F4011-6143-4106-8777-367BDCE261C4' AS [Id],
	    'Metrics (all types) with the highest number of alerts' AS [Name],
	    'Bar Table' AS [ShowAsType],
	    'SELECT * FROM [ApexSQL].[fnRTopMetricsAllTypesHighestAlerts]( Sources , SelectedAlertSeverity , {SelectedStartTime} , {SelectedEndTime} )' AS [Datasource],
	    2 AS [ReportType],
	    23 AS [CategoryId],
	    0 AS [LineType],
	    0 AS [YAxisType],
	    1 AS [Categorical],
	    0 AS [HasWaitType],
	    1 AS [HasAlertSeverity],
	    0 AS [HasAlertState],
	    0 AS [HasFragmentation],
        0 AS [HasMetrics]
	UNION ALL
	SELECT 
	    'B3FB2B3C-DDD6-49D8-9ABC-9F7483E75C1B' AS [Id],
	    'SQL Server metrics with the highest number of alerts' AS [Name],
	    'Bar Table' AS [ShowAsType],
	    'SELECT * FROM [ApexSQL].[fnRTopServerMetricsHighestAlerts]( Sources , SelectedAlertSeverity , {SelectedStartTime} , {SelectedEndTime} )' AS [Datasource],
	    2 AS [ReportType],
	    23 AS [CategoryId],
	    0 AS [LineType],
	    0 AS [YAxisType],
	    1 AS [Categorical],
	    0 AS [HasWaitType],
	    1 AS [HasAlertSeverity],
	    0 AS [HasAlertState],
	    0 AS [HasFragmentation],
        0 AS [HasMetrics]
	UNION ALL
	SELECT 
	    'DAAA1A6F-6877-4EA9-B047-EC179361A10D' AS [Id],
	    'Alert severity statistics' AS [Name],
	    'Pie' AS [ShowAsType],
	    'SELECT * FROM [ApexSQL].[fnRAlertsSeverityDistribution]( Sources , {SelectedStartTime} , {SelectedEndTime} )' AS [Datasource],
	    2 AS [ReportType],
	    23 AS [CategoryId],
	    0 AS [LineType],
	    0 AS [YAxisType],
	    0 AS [Categorical],
	    0 AS [HasWaitType],
	    0 AS [HasAlertSeverity],
	    0 AS [HasAlertState],
	    0 AS [HasFragmentation],
        0 AS [HasMetrics]
	UNION ALL
	SELECT 
	    'FBA3F70A-D03C-4153-A23D-411953B3CAE7' AS [Id],
	    'High fragmentation above x% in SQL Server' AS [Name],
	    'Table' AS [ShowAsType],
	    'SELECT * FROM [ApexSQL].[fnRIndexesWithSpecifiedFragmentationServer]( Sources , SelectedFragmentation , {SelectedStartTime} , {SelectedEndTime} )' AS [Datasource],
	    2 AS [ReportType],
	    24 AS [CategoryId],
	    0 AS [LineType],
	    0 AS [YAxisType],
	    0 AS [Categorical],
	    0 AS [HasWaitType],
	    0 AS [HasAlertSeverity],
	    0 AS [HasAlertState],
	    1 AS [HasFragmentation],
        0 AS [HasMetrics]
	UNION ALL
	SELECT 
	    'C60CFE78-11AA-499F-8AB4-8B17E35A96CB' AS [Id],
	    'High fragmentation above x% in database' AS [Name],
	    'Table' AS [ShowAsType],
	    'SELECT * FROM [ApexSQL].[fnRIndexesWithSpecifiedFragmentationDatabase]( Sources , SelectedFragmentation , {SelectedStartTime} , {SelectedEndTime} )' AS [Datasource],
	    6 AS [ReportType],
	    24 AS [CategoryId],
	    0 AS [LineType],
	    0 AS [YAxisType],
	    0 AS [Categorical],
	    0 AS [HasWaitType],
	    0 AS [HasAlertSeverity],
	    0 AS [HasAlertState],
	    1 AS [HasFragmentation],
        0 AS [HasMetrics]
	UNION ALL
	SELECT 
	    '8D8350C9-ECFF-4046-B22F-7896B6D7C741' AS [Id],
	    'Largest log growth' AS [Name],
	    'Bar Table' AS [ShowAsType],
	    'SELECT * FROM [ApexSQL].[fnRTopDatabasesLargestLogGrowth]( Sources , {SelectedStartTime} , {SelectedEndTime} )' AS [Datasource],
	    2 AS [ReportType],
	    25 AS [CategoryId],
	    0 AS [LineType],
	    0 AS [YAxisType],
	    1 AS [Categorical],
	    0 AS [HasWaitType],
	    0 AS [HasAlertSeverity],
	    0 AS [HasAlertState],
	    0 AS [HasFragmentation],
        0 AS [HasMetrics]
	UNION ALL
	SELECT 
	    '8D94308F-4B87-45AC-B031-5037C637DD84' AS [Id],
	    'Highest wait time in SQL Server' AS [Name],
	    'Table' AS [ShowAsType],
	    'SELECT * FROM [ApexSQL].[fnRTopQueriesHighestWaitTimeServer]( Sources , {SelectedStartTime} , {SelectedEndTime} )' AS [Datasource],
	    2 AS [ReportType],
	    21 AS [CategoryId],
	    0 AS [LineType],
	    0 AS [YAxisType],
	    0 AS [Categorical],
	    0 AS [HasWaitType],
	    0 AS [HasAlertSeverity],
	    0 AS [HasAlertState],
	    0 AS [HasFragmentation],
        0 AS [HasMetrics]
	UNION ALL
	SELECT 
	    'C1DAC3D4-9FD2-4D17-9B46-6CE5C8C5126E' AS [Id],
	    'Highest wait time in database' AS [Name],
	    'Table' AS [ShowAsType],
	    'SELECT * FROM [ApexSQL].[fnRTopQueriesHighestWaitTimeDatabase]( Sources , {SelectedStartTime} , {SelectedEndTime} )' AS [Datasource],
	    6 AS [ReportType],
	    21 AS [CategoryId],
	    0 AS [LineType],
	    0 AS [YAxisType],
	    0 AS [Categorical],
	    0 AS [HasWaitType],
	    0 AS [HasAlertSeverity],
	    0 AS [HasAlertState],
	    0 AS [HasFragmentation],
        0 AS [HasMetrics]
	UNION ALL
	SELECT 
	    '653A41BB-B286-4C27-A78E-466F79857C2F' AS [Id],
	    'Highest wait time for a specific wait type in SQL Server' AS [Name],
	    'Table' AS [ShowAsType],
	    'SELECT * FROM [ApexSQL].[fnRTopQueriesHighestWaitTimeWaitTypeServer]( Sources , SelectedWaitType , {SelectedStartTime} , {SelectedEndTime} )' AS [Datasource],
	    2 AS [ReportType],
	    21 AS [CategoryId],
	    0 AS [LineType],
	    0 AS [YAxisType],
	    0 AS [Categorical],
	    1 AS [HasWaitType],
	    0 AS [HasAlertSeverity],
	    0 AS [HasAlertState],
	    0 AS [HasFragmentation],
        0 AS [HasMetrics]
	UNION ALL
	SELECT 
	    '182E06BA-B69C-4B33-92CE-0B0F5D365F82' AS [Id],
	    'Highest wait time for a specific wait type in database' AS [Name],
	    'Table' AS [ShowAsType],
	    'SELECT * FROM [ApexSQL].[fnRTopQueriesHighestWaitTimeWaitTypeDatabase]( Sources , SelectedWaitType , {SelectedStartTime} , {SelectedEndTime} )' AS [Datasource],
	    6 AS [ReportType],
	    21 AS [CategoryId],
	    0 AS [LineType],
	    0 AS [YAxisType],
	    0 AS [Categorical],
	    1 AS [HasWaitType],
	    0 AS [HasAlertSeverity],
	    0 AS [HasAlertState],
	    0 AS [HasFragmentation],
        0 AS [HasMetrics]
	UNION ALL
	SELECT 
	    '1A9E37EC-B7B7-49AC-A448-53FEA4E4CF27' AS [Id],
	    'Databases with the highest wait time' AS [Name],
	    'Bar Table' AS [ShowAsType],
	    'SELECT * FROM [ApexSQL].[fnRTopDatabasesHighestWaitTime]( Sources , {SelectedStartTime} , {SelectedEndTime} )' AS [Datasource],
	    2 AS [ReportType],
	    22 AS [CategoryId],
	    0 AS [LineType],
	    0 AS [YAxisType],
	    1 AS [Categorical],
	    0 AS [HasWaitType],
	    0 AS [HasAlertSeverity],
	    0 AS [HasAlertState],
	    0 AS [HasFragmentation],
        0 AS [HasMetrics]
	UNION ALL
	SELECT 
	    'DB7E04A6-9758-43BF-8C2B-C72E5B571FCC' AS [Id],
	    'Apps with the highest wait time in SQL Server' AS [Name],
	    'Bar Table' AS [ShowAsType],
	    'SELECT * FROM [ApexSQL].[fnRTopApplicationsHighestWaitTimeServer]( Sources , {SelectedStartTime} , {SelectedEndTime} )' AS [Datasource],
	    2 AS [ReportType],
	    22 AS [CategoryId],
	    0 AS [LineType],
	    0 AS [YAxisType],
	    1 AS [Categorical],
	    0 AS [HasWaitType],
	    0 AS [HasAlertSeverity],
	    0 AS [HasAlertState],
	    0 AS [HasFragmentation],
        0 AS [HasMetrics]
	UNION ALL
	SELECT 
	    'C5CFACC2-F1EB-4740-9203-A8082C8B9BBB' AS [Id],
	    'Apps with the highest wait time in database' AS [Name],
	    'Bar Table' AS [ShowAsType],
	    'SELECT * FROM [ApexSQL].[fnRTopApplicationsHighestWaitTimeDatabase]( Sources , {SelectedStartTime} , {SelectedEndTime} )' AS [Datasource],
	    6 AS [ReportType],
	    22 AS [CategoryId],
	    0 AS [LineType],
	    0 AS [YAxisType],
	    1 AS [Categorical],
	    0 AS [HasWaitType],
	    0 AS [HasAlertSeverity],
	    0 AS [HasAlertState],
	    0 AS [HasFragmentation],
        0 AS [HasMetrics]
	UNION ALL
	SELECT 
	    'DCBD8C4A-1971-4BBF-BB19-0533C6C6D4E4' AS [Id],
	    'Total wait time in SQL Server' AS [Name],
	    'Bar Table' AS [ShowAsType],
	    'SELECT * FROM [ApexSQL].[fnRTopWaitTypesPrcOfTotalWaitTimeServer]( Sources , {SelectedStartTime} , {SelectedEndTime} )' AS [Datasource],
	    2 AS [ReportType],
	    22 AS [CategoryId],
	    0 AS [LineType],
	    0 AS [YAxisType],
	    1 AS [Categorical],
	    0 AS [HasWaitType],
	    0 AS [HasAlertSeverity],
	    0 AS [HasAlertState],
	    0 AS [HasFragmentation],
        0 AS [HasMetrics]
GO

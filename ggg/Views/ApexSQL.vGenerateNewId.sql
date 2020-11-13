SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		ApexSQL LLC
-- Create date: January, 2018
-- Description:	Creates view for generating ids
-- =============================================
CREATE VIEW [ApexSQL].[vGenerateNewId]
AS
    SELECT NEWID() AS [Id]
GO

USE [EPAS]
GO

DECLARE @RC int
-- TODO: Set parameter values here.

EXECUTE @RC = [dbo].[usp_PostExcelImport] 
   '2019-12-01'
  ,'2019-12-01'
GO



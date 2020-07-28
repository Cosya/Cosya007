USE [EPAS_DEV3]
GO

DECLARE @RC int
-- TODO: Set parameter values here.

EXECUTE [dbo].[usp_val_ExcelImport] '467CA11F-AF76-490A-B2F8-6770AE217EEE';


	

EXECUTE @RC = [dbo].[usp_PostExcelImport] 
   '2019-12-01'
  ,'2019-12-01'
GO



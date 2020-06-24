
USE [EPAS]
GO

DECLARE @RC int
DECLARE @result uniqueidentifier
-- TODO: Set parameter values here.

EXECUTE  @RC=[dbo].[usp_Get_New_dataset_id]  N'Blythe', @NewdatasetID = @result Output ;

GO

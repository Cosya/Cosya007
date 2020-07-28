<<<<<<< HEAD
USE [EPAS]
GO

/****** Object:  StoredProcedure [dbo].[usp_Get_New_dataset_id]    Script Date: 07.07.2020 12:22:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_Get_New_dataset_id] (@FileName varchar(256))
AS
 BEGIN
 DECLARE @RC int;
 DECLARE @NewdatasetID uniqueidentifier;
=======

use [EPAS];
go
Create PROCEDURE [dbo].[usp_Get_New_dataset_id] (@FileName varchar(256), @NewdatasetID uniqueidentifier output )
AS
 BEGIN
 DECLARE @RC int;
>>>>>>> f018c7e1dd3cdd2a50b44d1aa7468d0ec4c21ace
 SET NOCOUNT ON;
 --loging start
 
	 EXECUTE @RC = [dbo].[usp_log]
  		'DATASET',																--@Source NVARCHAR(128), 
		@FileName ,																--@Params NVARCHAR(512),
		'usp_Get_New_dataset_id',												--@Sp_name NVARCHAR(256),
		't_dataset',															--@Target_table NVARCHAR(256),
		'',																		--@Record_count nvarchar (128),t,
		'Start'																	--@Comment NVARCHAR(4000)

 SELECT
  @NewdatasetID = NewID();
  INSERT INTO [dbo].[t_dataset]
  (
	dataset_id, 
	FileName
  )
  SELECT 
	@NewdatasetID, 
	@FileName;
--loging end
	EXECUTE @RC = [dbo].[usp_log]
  		'DATASET',																--@Source NVARCHAR(128), 
		@FileName ,																--@Params NVARCHAR(512),
		'usp_Get_New_dataset_id',												--@Sp_name NVARCHAR(256),
		't_dataset',															--@Target_table NVARCHAR(256),
		'1',																		--@Record_count nvarchar (128),t,
		'End'																	--@Comment NVARCHAR(4000)

<<<<<<< HEAD
 select @NewdatasetID AS NewdatasetID;

end;

GO


=======
 select @NewdatasetID;
 RETURN

end;

>>>>>>> f018c7e1dd3cdd2a50b44d1aa7468d0ec4c21ace

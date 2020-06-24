
use [EPAS];
go
Create PROCEDURE [dbo].[usp_Get_New_dataset_id] (@FileName varchar(256), @NewdatasetID uniqueidentifier output )
AS
 BEGIN
 DECLARE @RC int;
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

 select @NewdatasetID;
 RETURN

end;


USE [EPAS]
GO
/****** Object:  StoredProcedure [dbo].[usp_val_rateImport]    Script Date: 07.09.2020 16:17:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

ALTER PROCEDURE [dbo].[usp_val_rateImport]


	@dataset_ID uniqueidentifier
AS
BEGIN
	DECLARE @RC int;
	Declare @Input nvarchar(256) =  cast(@dataset_ID as Nvarchar(256)) ;
	Declare @StartDateErrorCount integer;
	Declare @EndDateErrorCount integer;
	Declare @PKErrorCount integer; 
	Declare @RoleErrorCount integer;
	Declare @Hr_RateErrorCount integer;
	Declare @Count nvarchar(128);
	
	SET NOCOUNT ON;
	--SET DATEFORMAT dmy;

	--Loging start
	EXECUTE @RC = [dbo].[usp_log]
  		'EXCEL',																--@Source NVARCHAR(128), 
		@Input ,																--@Params NVARCHAR(512),
		'usp_val_rateImport',													--@Sp_name NVARCHAR(256),
		't_rates',																--@Target_table NVARCHAR(256),
		'',																		--@Record_count nvarchar (128),t,
		'Start'																	--@Comment NVARCHAR(4000)

	
	
	select 
		* Into #checkdataset  
	from 
		[dbo].[stg_t_rates]
	where 
		DatasetID = @dataset_ID
		and Status_id = 0;
	
	

	--validation  PK

	Select	
		@PKErrorCount =count(*) 
	from 
		#checkdataset
	group by [Short_Role],[Start_date] 
	having count(*) > 1



	--validation Start date

	Select	
		@StartDateErrorCount =count(*) 
	from 
		#checkdataset
	where 
		ISDATE(Start_Date) = 0;
	
	Select	
		@EndDateErrorCount =count(*) 
	from 
		#checkdataset
	where 
		ISDATE(Start_Date) = 0;


	--validation Short_Role

	Select	
		@RoleErrorCount =count(*) 
	from 
		#checkdataset
	where 
		isnull(Short_Role,'') = '';
	
	
		Select	
		@Hr_RateErrorCount =count(*) 
	from 
		#checkdataset
	where 
		ISNUMERIC(Hr_Rate) = 0
		OR Hr_Rate <= cast(0 as money)


	If (@StartDateErrorCount > 0 ) or (@RoleErrorCount>0) or (@Hr_RateErrorCount>0)
		begin

			
		Insert INTO [dbo].t_rates_load_errors --error table
				(
				[Role],
				[Short_Role],
				[Hr_Rate],
				[Start_date],
				[End_date],
				DatasetID
				)
			Select 
				[Role],
				[Short_Role],
				[Hr_Rate],
				[Start_date],
				[End_date],
				DatasetID
				
			from
				#checkdataset  
			where
				ISDATE(Start_Date) = 0
				or isnull(Short_Role,'') = '' 
				or  [Short_Role] in 
									(
									Select	
										Short_Role
									from 
										#checkdataset
									group by [Short_Role],[Start_date] 
									having count(*) > 1
									)
				or ISNUMERIC(Hr_Rate) = 0
				or Hr_Rate <= cast(0 as money);
				

			Update [dbo].[stg_t_rates]
				SET Status_id = 2 --error
			where	
				DatasetID = @dataset_ID
				AND Status_id = 0; --not checked
		end
	else 

	-- if all ok - data will be updated to 1
		
		begin
				Update [dbo].[stg_t_rates]
					SET Status_id = 1 --validated
				where	
					DatasetID = @dataset_ID
					AND Status_id = 0; --not checked

			
			--remove previous data if exists
			Delete from [dbo].[t_rates]
				;

		
			Insert into [dbo].[t_rates]
				(
				[Role],
				[Short_Role],
				[Hr_Rate],
				[Start_date],
				[End_date]
				)
			Select	
				isnull(Role,''), 				
				isnull(Short_Role,'') , 					
				cast(Hr_Rate as money), 						
				cast(Start_Date as date), 
				cast (End_date as date)   --the record is active till the next rate comes
			from 
				[dbo].[stg_t_rates]
			WHERE 
				DatasetID = @dataset_ID
				AND Status_id = 1;--just loaded
		end




	--Loging end
	Select @Count = cast(count(*) as nvarchar) from [dbo].[t_s_report_excel] where EffectiveMonthDate is null ; 
	EXECUTE @RC = [dbo].[usp_log]
  		'EXCEL',																--@Source NVARCHAR(128), 
		@Input ,																--@Params NVARCHAR(512),
		'usp_val_rateImport',													--@Sp_name NVARCHAR(256),
		't_rates',														--@Target_table NVARCHAR(256),
		@Count,																	--@Record_count nvarchar (128),
		'End'																	--@Comment NVARCHAR(4000)

	If(OBJECT_ID('tempdb..#checkdataset') Is Not Null)
	Begin
		Drop Table #checkdataset
	End;
	-- show error names list as Output for reject file 
	
	/*
	Select 
		Short_Role 
	from 
		[dbo].[t_rates_load_errors ]
	where 
		DatasetID = @dataset_ID;
	*/


	select @StartDateErrorCount+@EndDateErrorCount+@Hr_RateErrorCount as ValErrorCount1;

END


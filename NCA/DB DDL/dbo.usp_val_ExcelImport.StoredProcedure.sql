USE [EPAS]
GO
/****** Object:  StoredProcedure [dbo].[usp_val_ExcelImport]    Script Date: 15.09.2020 9:15:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_val_ExcelImport]


	@dataset_ID uniqueidentifier
AS
BEGIN
	DECLARE @RC int;
	Declare @Input nvarchar(256) =  cast(@dataset_ID as Nvarchar(256)) ;
	Declare @DateErrorCount integer;
	Declare @BaseErrorCount integer;
	Declare @VarAddonErrorCount integer;
	Declare @Count nvarchar(128);
	
	SET NOCOUNT ON;
	--SET DATEFORMAT dmy;

	--Loging start
	EXECUTE @RC = [dbo].[usp_log]
  		'EXCEL',																--@Source NVARCHAR(128), 
		@Input ,																--@Params NVARCHAR(512),
		'usp_val_ExcelImport',													--@Sp_name NVARCHAR(256),
		't_s_report_excel',														--@Target_table NVARCHAR(256),
		'',																		--@Record_count nvarchar (128),t,
		'Start'																	--@Comment NVARCHAR(4000)

	
	Create table #Checkdataset 
	
	(
	[Full_Name_UA] [nvarchar](255) NULL,
	[Full_Name] [nvarchar](255) NULL,
	[Relationship_IP] [nvarchar](255) NULL,
	[Relationship_Partner] [nvarchar](255) NULL,
	[Partner_Company] [nvarchar](255) NULL,
	[Department] [nvarchar](255) NULL,
	[Group_Leader] [nvarchar](255) NULL,
	[Project] [nvarchar](255) NULL,
	[Direct_Manager] [nvarchar](255) NULL,
	[Hourly_Pay_Type] [nvarchar](255) NULL,
	[Grade] [nvarchar](255) NULL,
	[Maternity_Leave] [nvarchar](255) NULL,
	[Compensation_Package_Group] [nvarchar](255) NULL,
	[Location] [nvarchar](255) NULL,
	[Staff_Type] [nvarchar](255) NULL,
	[Start_Date] [nvarchar](255) NULL,
	[Base] [nvarchar](255) NULL,
	[Currency] [nvarchar](255) NOT NULL,
	[Addon] [nvarchar](255) NULL,
	[Type_addon] [nvarchar](255) NULL,
	[Variable] [nvarchar](255) NULL,
	[DatasetID] [uniqueidentifier] NOT NULL
	);

	--remove previous data for this month if exists
	Insert Into #Checkdataset  
		(
		DatasetID,
		Full_Name_UA, 				
		Full_Name, 					
		Relationship_IP, 			
		Relationship_Partner, 		
		Partner_Company, 			
		Department, 				
		Group_Leader, 				
		Project, 					
		Direct_Manager, 			
		Hourly_Pay_Type, 			
		Grade, 						
		Maternity_Leave,			
		Compensation_Package_Group, 
		Location, 					
		Staff_Type, 				
		Start_Date, 				
		Base, 						
		Currency, 					
		Addon, 						
		Type_addon, 				
		Variable
		)

	Select 
		DatasetID,
		Full_Name_UA, 				
		Full_Name, 					
		Relationship_IP, 			
		Relationship_Partner, 		
		Partner_Company, 			
		Department, 				
		Group_Leader, 				
		Project, 					
		Direct_Manager, 			
		Hourly_Pay_Type, 			
		Grade, 						
		Maternity_Leave,			
		Compensation_Package_Group, 
		Location, 					
		Staff_Type, 				
		Start_Date, 				
		Base, 						
		Currency, 					
		Addon, 						
		Type_addon, 				
		Variable
	from 
		[dbo].[stg_t_s_report_excel]
	where 
		DatasetID = @dataset_ID
		and Status_id = 0;
	
	
	--validation Start date

	Select	
		@DateErrorCount =count(*) 
	from 
		#Checkdataset
	where 
		ISDATE(Start_Date) = 0;

	--validation Base

	Select	
		@BaseErrorCount =count(*) 
	from 
		#Checkdataset
	where 
		ISNUMERIC(Base) = 0
		OR Base <= cast(0 as money)
		
	
	--validation Addon /variable

	Select	
		@VarAddonErrorCount =count(*) 
	from 
		#Checkdataset
	where 
		ISNUMERIC(Addon) = 0 
		or  ISNUMERIC(Variable) = 0
		or Addon < cast(0 as money) 
		or Variable < cast(0 as money) 
		;
	
	

	If (@DateErrorCount > 0 ) or (@BaseErrorCount > 0 ) or (@VarAddonErrorCount>0)
		
		begin

			Insert into [dbo].[t_Excell_load_errors] --error table
					(
					DatasetID,
					Full_Name_UA, 				
					Full_Name, 					
					Relationship_IP, 			
					Relationship_Partner, 		
					Partner_Company, 			
					Department, 				
					Group_Leader, 				
					Project, 					
					Direct_Manager, 			
					Hourly_Pay_Type, 			
					Grade, 						
					Maternity_Leave,			
					Compensation_Package_Group, 
					Location, 					
					Staff_Type, 				
					Start_Date, 				
					Base, 						
					Currency, 					
					Addon, 						
					Type_addon, 				
					Variable
					)
				Select 
					DatasetID,
					Full_Name_UA, 				
					Full_Name, 					
					Relationship_IP, 			
					Relationship_Partner, 		
					Partner_Company, 			
					Department, 				
					Group_Leader, 				
					Project, 					
					Direct_Manager, 			
					Hourly_Pay_Type, 			
					Grade, 						
					Maternity_Leave,			
					Compensation_Package_Group, 
					Location, 					
					Staff_Type, 				
					Start_Date, 				
					Base, 						
					Currency, 					
					Addon, 						
					Type_addon, 				
					Variable
				from
					#Checkdataset  
				where
					ISDATE(Start_Date) = 0
					or ISNUMERIC(Base) = 0
					or ISNUMERIC(Addon) = 0
					or ISNUMERIC(Variable) = 0
					or Addon < cast(0 as money) 
					or Variable < cast(0 as money) 
					or Base <= cast(0 as money) 
					;

				Update [dbo].[stg_t_s_report_excel]
					SET Status_id = 2 --error
				where	
					DatasetID = @dataset_ID
					AND Status_id = 0; --not checked
		end
	else 

	-- if all ok - data will be updated to 1
		
		begin
			
		Update [dbo].[stg_t_s_report_excel]
			SET Status_id = 1 --validated
		where	
			DatasetID = @dataset_ID
			AND Status_id = 0; --not checked

			Insert into [dbo].[t_s_report_excel]
				(
				Full_Name_UA, 				
				Full_Name, 					
				Relationship_IP, 			
				Relationship_Partner, 		
				Partner_Company, 			
				Department, 				
				Group_Leader, 				
				Project, 					
				Direct_Manager, 			
				Hourly_Pay_Type, 			
				Grade, 						
				Maternity_Leave,			
				Compensation_Package_Group, 
				Location, 					
				Staff_Type, 				
				Start_Date, 				
				Base, 						
				Currency, 					
				Addon, 						
				Type_addon, 				
				Variable 					
		
				)
			Select	
				isnull(Full_Name_UA,''), 				
				isnull(Full_Name,'') , 					
				isnull(Relationship_IP,''), 			
				isnull(Relationship_Partner,''), 		
				isnull(Partner_Company,''), 			
				isnull(Department,''), 				
				isnull(Group_Leader,''), 				
				isnull(Project,''), 					
				isnull(Direct_Manager,''), 			
				isnull(Hourly_Pay_Type,''), 			
				isnull(Grade,''), 						
				isnull(Maternity_Leave,''),			
				isnull(Compensation_Package_Group,''), 
				isnull(Location,''), 					
				isnull(Staff_Type,''), 				
				cast(Start_Date as date), 				
				cast(Base as money), 						
				isnull(Currency,''), 					
				cast(isnull(Addon,0) as money),						
				isnull(Type_addon,''), 				
				cast(isnull(Variable,0) as money)
			from 
				[dbo].[stg_t_s_report_excel]
			WHERE 
				DatasetID = @dataset_ID
				AND Status_id = 1;--just loaded
		end
	
	
	
	--Loging end
	Select @Count = cast(count(*) as nvarchar) from [dbo].[t_s_report_excel] where EffectiveMonthDate is null ; 
	EXECUTE @RC = [dbo].[usp_log]
  		'EXCEL',																--@Source NVARCHAR(128), 
		@Input ,																--@Params NVARCHAR(512),
		'usp_PostExcelImport',													--@Sp_name NVARCHAR(256),
		't_s_report_excel',														--@Target_table NVARCHAR(256),
		@Count,																	--@Record_count nvarchar (128),
		'End'																	--@Comment NVARCHAR(4000)

	If(OBJECT_ID('tempdb..#Checkdataset') Is Not Null)
	Begin
		Drop Table #Checkdataset
	End;
	
	-- show error names list as Output for reject file 
	/*
	Select 
		Full_name 
	from 
		t_Excell_load_errors
	where 
		DatasetID = @dataset_ID;
	*/
    select @DateErrorCount+@BaseErrorCount+@VarAddonErrorCount as ValErrorCount;
END

GO

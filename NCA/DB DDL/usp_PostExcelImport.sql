USE [EPAS]
GO
/****** Object:  StoredProcedure [dbo].[usp_PostExcelImport]    Script Date: 11.06.2020 16:38:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_PostExcelImport]
	-- Add the parameters for the stored procedure here

	@LoadMonth date, --
	@PriorLoadMonth date
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	update [EPAS].[dbo].[t_s_report_excel] 
		set [EffectiveMonthDate]= @LoadMonth --'2020-02-01' 
	where 
		[EffectiveMonthDate] is null

	update [EPAS].[dbo].[t_subgrade_excel] 
		set [EffectiveMonthDate]= @LoadMonth --'2020-02-01' 
	where [EffectiveMonthDate] is null
	--
	delete  
	from 
		[EPAS].[dbo].[t_s_report_excel] 
	where 
		grade like '%manager%' 
		or grade like '%administrator%' 
		or grade like '%executive%'
	--
	delete  
	from 
		[EPAS].[dbo].[t_s_report_excel] 
	where 
		currency = 'UAH'
	--
	delete 
	from 
		[EPAS].[dbo].[t_subgrade_excel] 
	where SubGrade is null

	delete 
	from 
		[EPAS].[dbo].[t_s_report_excel] 
	where 
		TotalMoney < 100
	--
	update [EPAS].[dbo].[t_s_report_excel] 
		set Project = REPLACE(Project, 'Deloitte-Administrative;','') 
	where 
		Project <> 'Deloitte-Administrative'
	--
	update [EPAS].[dbo].[t_s_report_excel] 
		set Project = REPLACE(Project, ';Deloitte-Administrative','') 
	where Project <> 'Deloitte-Administrative'
	--
	update [EPAS].[dbo].[t_s_report_excel] 
		set Project = REPLACE(Project, 'Deloitte-NCA;','') 
	where 
		Project <> 'Deloitte-NCA'
	--
	update [EPAS].[dbo].[t_s_report_excel] 
		set Project = REPLACE(Project, ';Deloitte-NCA','') 
	where 
		Project <> 'Deloitte-NCA'
	
	update [EPAS].[dbo].[t_s_report_excel] 
		set Project = REPLACE(Project, 'Corporate Development-Administrative;','') 
	where 
		Project <> 'Corporate Development-Administrative'
	--
	update [EPAS].[dbo].[t_s_report_excel] 
		set Project = REPLACE(Project, ';Corporate Development-Administrative','') 
	where 
		Project <> 'Corporate Development-Administrative'

	-- project and manager normalize

	--project 
	delete from [dbo].[t_project_map]
	where EffectiveMonthDate = @LoadMonth;

	insert into [t_project_map]
	(
	[EffectiveMonthDate],
	[Full_Name],
	[Project]
	)
	select distinct
		[EffectiveMonthDate],
		[Full_Name],
		[Project]
	from 
		[dbo].[t_s_report_excel]
	where EffectiveMonthDate =  @LoadMonth;

	--manager 
	delete from [dbo].[t_manager_map]
	where EffectiveMonthDate = @LoadMonth;

	insert into [t_manager_map]
	(
		[EffectiveMonthDate],
		[Full_Name],
		[Direct_Manager]
	)
	select distinct
		[EffectiveMonthDate],
		[Full_Name],
		[Direct_Manager]
	from 
		[dbo].[t_s_report_excel]
	where
		EffectiveMonthDate =  @LoadMonth;
  -- moder excell report 
   delete from [dbo].[t_manager_map]
   where 
		EffectiveMonthDate = @LoadMonth;
/* //no model table yet


   insert into [dbo].[t_report_excel]
   (
   	   [EffectiveMonthDate]
	  ,[Full_Name_UA]
      ,[Full_Name]
      ,[Relationship_IP]
      ,[Relationship_Partner]
      ,[Partner_Company]
      ,[Department]
      ,[Group_Leader]
      --,[Project]
	  ,[Project_id]
      --,[Direct_Manager]
	  ,[Direct_Manager_id]
      ,[Hourly_Pay_Type]
      ,[Grade]
      ,[Maternity_Leave]
      ,[Compensation_Package_Group]
      ,[Location]
      ,[Staff_Type]
      ,[Start_Date]
      ,[Base]
      ,[Currency]
      ,[Addon]
      ,[Type_addon]
      ,[Variable]
      ,[TotalMoney]
      ,[ImportedDt]
      ,[Location_Short]
      ,[EffectiveYear]
      ,[MonthName]		
   )
   select
	   [EffectiveMonthDate]
	  ,[Full_Name_UA]
      ,[Full_Name]
      ,[Relationship_IP]
      ,[Relationship_Partner]
      ,[Partner_Company]
      ,[Department]
      ,[Group_Leader]
      --,[Project]
	  ,[Project_id]
      --,[Direct_Manager]
	  ,[Direct_Manager_id]
      ,[Hourly_Pay_Type]
      ,[Grade]
      ,[Maternity_Leave]
      ,[Compensation_Package_Group]
      ,[Location]
      ,[Staff_Type]
      ,[Start_Date]
      ,[Base]
      ,[Currency]
      ,[Addon]
      ,[Type_addon]
      ,[Variable]
      ,[TotalMoney]
      ,[ImportedDt]
      ,[Location_Short]
      ,[EffectiveYear]
      ,[MonthName]
   from 
		[dbo].[vw_lookup_excell_report]
   where 
		EffectiveMonthDate = @LoadMonth;

*/
	-- select changed grade persons
	select 
		* 
	from 
		[EPAS].[dbo].[t_s_report_excel] t1
		left join [EPAS].[dbo].[t_s_report_excel] t2 
			on t1.EffectiveMonthDate = @LoadMonth --'2019-07-01' 
			and t2.EffectiveMonthDate = @PriorLoadMonth --'2019-06-01' 
			and t1.Full_Name = t2.Full_Name
	where 
		t1.Grade <> t2.Grade or t1.Grade is null
		and t1.EffectiveMonthDate =  @LoadMonth --'2019-07-01'
		and t2.EffectiveMonthDate = @PriorLoadMonth --'2019-06-01'


END


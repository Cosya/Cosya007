USE [EPAS]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


Alter PROCEDURE [dbo].[usp_s_excell_report_to_model]
	@LoadMonth date
	
AS
BEGIN

	SET NOCOUNT ON;
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
END


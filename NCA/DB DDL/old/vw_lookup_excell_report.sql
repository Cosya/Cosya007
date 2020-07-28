alter view [dbo].[vw_lookup_excell_report]
	(
		[EffectiveMonthDate]
	  ,[Full_Name_UA]
      ,[Full_Name]
      ,[Relationship_IP]
      ,[Relationship_Partner]
      ,[Partner_Company]
      ,[Department]
      ,[Group_Leader]
      ,[Project]
	  ,[Project_id]
      ,[Direct_Manager]
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
as  select 
	   stg.[EffectiveMonthDate]
	  ,[Full_Name_UA]
      ,stg.[Full_Name]
      ,[Relationship_IP]
      ,[Relationship_Partner]
      ,[Partner_Company]
      ,[Department]
      ,[Group_Leader]
      ,stg.[Project]
	  ,project_map.id as Project_id
      ,stg.[Direct_Manager]
	  ,manager_map.[id] as Direct_Manager_id
      ,[Hourly_Pay_Type]
      ,stg.[Grade]
	  --, short_grades.Grade_id -- add md?
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
		[EPAS].[dbo].[t_s_report_excel] stg
		left join [dbo].[t_project_map] as project_map
			on project_map.EffectiveMonthDate = stg.EffectiveMonthDate
			and project_map.Full_Name = stg.Full_Name
			and project_map.Project = stg.Project
		left join [dbo].[t_manager_map] as manager_map
			on manager_map.EffectiveMonthDate = stg.EffectiveMonthDate
			and manager_map.Full_Name = stg.Full_Name
			and manager_map.Direct_Manager = stg.Direct_Manager
		left join [dbo].[t_short_grades] short_grades
			on short_grades.Long_Grade = stg.[Grade]

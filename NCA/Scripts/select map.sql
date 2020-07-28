/****** Script for SelectTopNRows command from SSMS  ******/
SELECT *
  FROM [EPAS].[dbo].[t_s_report_excel]
  where EffectiveMonthDate = '2020-01-01' and Full_Name = 'Kara Barnes'
  order by 3;


  Select * from [dbo].[t_project_map]
  where EffectiveMonthDate = '2020-01-01'and Full_Name = 'Kara Barnes' ;


  
  Select * from [dbo].[t_manager_map]
  where EffectiveMonthDate = '2020-01-01' and Full_Name = 'Kara Barnes';

  select * from [dbo].[t_s_report_excel]
  where EffectiveMonthDate is null 




USE [EPAS]
GO

DECLARE @RC int
-- TODO: Set parameter values here.

EXECUTE  @RC= [dbo].[usp_s_excell_report_normalization]
  '2020-01-01',
'2020-01-01'
GO



SELECT *
  FROM [EPAS].[dbo].[t_manager_map]
    where full_name = 'Zoey Bennett'
--where EffectiveMonthDate = '2019-01-01'
order by 2;


SELECT EffectiveMonthDate, Full_Name,value as  Direct_Manager  
FROM [EPAS].[dbo].[t_manager_map] m
    CROSS APPLY STRING_SPLIT(m.Direct_Manager, ';')
where full_name = 'Zoey Bennett'
--where EffectiveMonthDate = '2019-01-01'
order by 1;	
	;


Select distinct EffectiveMonthDate,full_name,project, Direct_Manager from t_s_report_excel
where  
--EffectiveMonthDate = '2019-01-01'
 full_name = 'Zoey Bennett'
order by 1


  
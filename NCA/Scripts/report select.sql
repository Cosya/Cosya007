go 
declare @DM nvarchar(255) = 'Wren Morris';
select
re.EffectiveMonthDate,
re.Full_Name,
sg.Short_Grade,
sg.Grade,
sg.Specialization,
sg.Grade_Type,
re.Group_Leader,
re.Location_Short as [Location],
re.Project,
re.Direct_Manager,
re.TotalMoney as TotalMoney,
re.Base,
re.Addon,
re.Variable,
su.SubGrade,
manager_map.ID
  FROM [EPAS].[dbo].[t_s_report_excel] re
  left join [EPAS].[dbo].[t_short_grades] sg on re.Grade = sg.Long_Grade
  left join [EPAS].[dbo].[t_subgrade_excel] su on su.Full_Name = re.Full_Name and su.EffectiveMonthDate = re.EffectiveMonthDate
  left Join [EPAS].[dbo].[t_manager_map] manager_map
	on re.EffectiveMonthDate = manager_map.EffectiveMonthDate
	and re.Full_Name =  manager_map.Full_Name
	and manager_map.Direct_Manager in (@DM )
  left Join [EPAS].[dbo].[t_Project_map] Project_map
	on re.EffectiveMonthDate = manager_map.EffectiveMonthDate
	and re.Full_Name =  manager_map.Full_Name
	and manager_map.Direct_Manager in (@DM )
where 
re.EffectiveMonthDate = '2020-01-01'
and manager_map.ID is not null
--and re.Full_Name = 'Kara Barnes'
order by Full_Name
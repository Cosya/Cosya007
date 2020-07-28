
SELECT
	precalc.Grade_Type,
	precalc.Grade,
	precalc.SubGrade,
	precalc.Specialization,
	count(precalc.Full_Name) as [Count],
	Min(precalc.TotalMoney) as [Min],
	Round(Avg(precalc.TotalMoney),0) as Average,
	Max(precalc.TotalMoney) as [Max]

FROM
	(
		SELECT 
			distinct
				sg.Grade_Type,
				sg.Grade,
				su.SubGrade,
				sg.Specialization,
				re.Full_Name,
				TotalMoney 
		  FROM [EPAS].[dbo].[t_s_report_excel] re
		  left join [EPAS].[dbo].[t_short_grades] sg on re.Grade = sg.Long_Grade
		  left join [EPAS].[dbo].[t_subgrade_excel] su on su.Full_Name = re.Full_Name and 
		su.EffectiveMonthDate = re.EffectiveMonthDate
		  left Join [EPAS].[dbo].[t_manager_map] manager_map
			on re.EffectiveMonthDate = manager_map.EffectiveMonthDate
			and re.Full_Name =  manager_map.Full_Name
			and manager_map.Direct_Manager in (@Direct_Manager )
		left Join [EPAS].[dbo].[t_Project_map] project_map
			on re.EffectiveMonthDate = project_map.EffectiveMonthDate
			and re.Full_Name =  project_map.Full_Name
			and project_map.Project in (@Project)
		where 
			re.Location_Short in (@Location)
			and re.Group_Leader in (@Group_Leader)
			and re.EffectiveMonthDate=@Month
						  and project_map.ID is not null
						  and manager_map.ID is not null
		) precalc

group by   
	precalc.Grade_Type,
	precalc.Grade,
	precalc.SubGrade,
	precalc.Specialization
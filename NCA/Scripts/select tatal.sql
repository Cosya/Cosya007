Select 
		precalc.Short_Grade,
		precalc.[MonthName] as [Month],
		precalc.EffectiveMonthDate as MonthDate,
		precalc.MonthNum,
		Min(precalc.TotalMoney) as [Min],
		Round(Avg(precalc.TotalMoney),0) as Average,
		Max(precalc.TotalMoney) as [Max],
		count(precalc.TotalMoney)
		FROm(

select  distinct  
			sg.Short_Grade,
			re.Full_Name,
			MonthName,
			re.EffectiveMonthDate,
			DATEPART(MONTH, 
			re.EffectiveMonthDate) as MonthNum,
			TotalMoney
		from 
			[EPAS].[dbo].[t_s_report_excel] re
			left join [EPAS].[dbo].[t_short_grades] sg on re.Grade = sg.Long_Grade
			left join [EPAS].[dbo].[t_subgrade_excel] su on su.Full_Name = re.Full_Name and su.EffectiveMonthDate = re.EffectiveMonthDate
			left Join [EPAS].[dbo].[t_manager_map] manager_map
			on re.EffectiveMonthDate = manager_map.EffectiveMonthDate
			and re.Full_Name =  manager_map.Full_Name
			--and manager_map.Direct_Manager in (@Direct_Manager )
			left Join [EPAS].[dbo].[t_Project_map] project_map
			on re.EffectiveMonthDate = project_map.EffectiveMonthDate
			and re.Full_Name =  project_map.Full_Name
		where 
			--re.Location_Short in (@Location)
            --and re.Group_Leader in (@GL) 
			 re.EffectiveYear=2020
            and project_map.ID is not null
            and manager_map.ID is not null
			and sg.Short_Grade = '.NET Jr Dev'
			and re.EffectiveMonthDate = '2020-04-01'
		) precalc

	group by precalc.Short_Grade, 
	precalc.[MonthName],
	precalc.EffectiveMonthDate ,
	precalc.MonthNum
		
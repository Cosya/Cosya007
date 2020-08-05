select distinct
		ep_id ,
		m.Full_Name,
		m.EffectiveMonthDate, 
		fn_res.LastEvalReriod,
		DATEADD(month, p.[EvaluationFrequency], fn_res.LastEvalReriod) AS [EP_date],
	--	s.ID,
		g.Grade,
		m.Base,
		m.Currency,
		m.Addon,
		m.Type_addon,
		m.Variable
	from 
		[dbo].[t_s_report_excel] m
		left join [dbo].[t_short_grades] g
			on g.Long_Grade = m.Grade
		Left join [SP].[Person] p
			on p.Name = m.Full_Name
	--	left join [dbo].[t_scenario] s
	--		on s.ScenarioName = @ScenarioName
		cross apply [dbo].[get_ep_score](m.Full_Name) as fn_res
	where
		 EffectiveMonthDate = '2019-12-01';
	

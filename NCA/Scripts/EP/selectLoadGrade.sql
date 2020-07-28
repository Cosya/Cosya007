DECLARE @LoadMonth date = '2019-12-01'

	select distinct
		m.EffectiveMonthDate, 
		m.Full_Name,
		fn_res.OverallScore,
		fn_res.AvgProductivityScore, 
		case 
			when  g.Grade ='Trainee' and fn_res.OverallScore =100   then 'Low_performer' --?
			when  g.Grade ='Trainee' and fn_res.OverallScore >= 100 and fn_res.OverallScore < 150   then 'Middle_performer' --?
			when  g.Grade ='Trainee' and fn_res.OverallScore > 150   then 'High_performer' --?

			when  g.Grade ='Junior' and fn_res.OverallScore = 100 and fn_res.AvgProductivityScore <= 2  then 'Low_performer'
			when  g.Grade ='Junior' and fn_res.OverallScore >= 100 and fn_res.OverallScore < 150 and  fn_res.AvgProductivityScore > 2  and fn_res.AvgProductivityScore < 4  then 'Middle_performer'
			when  g.Grade ='Junior' and fn_res.OverallScore > 150 and fn_res.AvgProductivityScore  >= 3  then 'High_performer'
			
			when  g.Grade ='Middle' and fn_res.OverallScore = 100 and fn_res.AvgProductivityScore <= 4  then 'Low_performer'
			when  g.Grade ='Middle' and fn_res.OverallScore >= 100 and fn_res.OverallScore < 150 and fn_res.AvgProductivityScore > 4 and fn_res.AvgProductivityScore  < 8  then 'Middle_performer'
			when  g.Grade ='Middle' and fn_res.OverallScore > 150 and fn_res.AvgProductivityScore >= 7  then 'High_performer'

			when  g.Grade ='Senior' and fn_res.OverallScore = 100 and fn_res.AvgProductivityScore <= 8  then 'Low_performer'
			when  g.Grade ='Senior' and fn_res.OverallScore >= 100 and fn_res.OverallScore < 150 and fn_res.AvgProductivityScore > 8 and fn_res.AvgProductivityScore  < 16  then 'Middle_performer'
			when  g.Grade ='Senior' and fn_res.OverallScore > 150 and fn_res.AvgProductivityScore >= 14  then 'High_performer'
			
			when  g.Grade ='Expert' and fn_res.OverallScore =100   then 'Low_performer' --?
			when  g.Grade ='Expert' and fn_res.OverallScore >= 100 and fn_res.OverallScore < 150   then 'Middle_performer' --?
			when  g.Grade ='Expert' and fn_res.OverallScore > 150   then 'High_performer' --?

		end as [SubGrade] 
	from 
		[dbo].[t_s_report_excel] m
		  left join [dbo].[t_short_grades] g
			on g.Long_Grade = m.Grade
		cross apply [dbo].[get_ep_score](m.Full_Name) as fn_res
	where
		 EffectiveMonthDate = @LoadMonth;

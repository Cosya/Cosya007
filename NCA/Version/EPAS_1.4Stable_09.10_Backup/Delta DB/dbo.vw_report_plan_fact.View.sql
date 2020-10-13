USE [EPAS]
GO

/****** Object:  View [dbo].[vw_report_plan_fact]    Script Date: 05.10.2020 12:04:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




ALTER view [dbo].[vw_report_plan_fact]
	(
	    FullName,
		EffectiveMonthDate,
		PlanContractPosition ,
		FactContractPosition,
		DateFrom,
		DateTo,
		Hr_Rate,
		Grade,
		base,
		Addon,
		Variable,
		TotalMoney,
		work_days_count,
		Project,
		Sourceflag,
		ScenarioName,
		Corporate_overhead,
		Hrs_count -- day work
	  )
as  
	
	
	
	select 
		FullName,
		p.EffectiveMonthDate,
		case 
		when a.contractPosition is null then max(a.contractPosition) over (partition by FullName order by p.EffectiveMonthDate)
		else a.contractPosition end as  PlanContractPosition ,
		
		a.ContractPosition as FactContractPosition,
		a.DateFrom,
		a.DateTo,
		case when a.contractPosition = '--Not Billable--' then 0 
		when a.contractPosition is null  then max(isnull(r.Hr_Rate, 0)) over (partition by FullName order by p.EffectiveMonthDate)
		else isnull(r.Hr_Rate,0) end as  Hr_Rate,
		p.Grade, p.base, p.Addon, p.Variable,p.TotalMoney
		,c.work_days_count
		,case 
		when ex.Project  is null then max(ex.Project) over (partition by FullName order by p.EffectiveMonthDate)
		else ex.Project end as Project 

		,p.[Sourceflag]
		,s.ScenarioName
		,S.Corporate_overhead
		,s.Hrs_count -- day work

	from [dbo].[t_EP_Plan] p
		Left Join [SP].[Assignment] a
			on p.FullName = a.Person
			and p.EffectiveMonthDate >= a.[DateFrom] 
			and p.EffectiveMonthDate <= isnull(a.DateTo, cast('2099-12-31' as date ))
		left join [dbo].[t_rates] r
			ON  r.Short_Role = a.ContractPosition
				and r.Scenario_ID = p.Scenario_ID
			and p.EffectiveMonthDate between r.Start_date and r.End_date
		Left join [dbo].[t_scenario] s
			on s.ID = p.Scenario_ID
		left join [dbo].[t_s_report_excel] ex
			on ex.Full_Name = p.FullName
		 and ex.EffectiveMonthDate =  p.EffectiveMonthDate

		Left join (SELECT [Month_data] , COUNT([Day_of_Month_data] ) as work_days_count
						  FROM [dbo].[t_Calendar]
						  WHERE (([Weekday] in (1, 2, 3, 4, 5) AND [Holiday] IS NULL) OR ([Weekday] = 6 AND [Workday] IS NOT NULL))
						  GROUP BY [Month_data]) c
			ON cast(cast(c.[Month_data] as nvarchar (6))+'01' as date) = p.EffectiveMonthDate


						  







GO



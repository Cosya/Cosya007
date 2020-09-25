USE [EPAS]
GO

/****** Object:  View [dbo].[vw_lookup_role_assignment]    Script Date: 23.09.2020 15:52:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[vw_report_plan_fact]
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
		work_days_count
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
		when a.contractPosition is null then max(r.Hr_Rate) over (partition by FullName order by p.EffectiveMonthDate)
		else r.Hr_Rate end as  Hr_Rate,
		p.Grade, p.base, p.Addon, p.Variable,TotalMoney
		,c.work_days_count
	from [dbo].[t_EP_Plan] p
		Left Join [SP].[Assignment] a
			on p.FullName = a.Person
			and dateadd(year, 3, p.EffectiveMonthDate) >= a.[DateFrom] 
			and dateadd(year, 3, p.EffectiveMonthDate) <= isnull(a.DateTo, cast('2099-12-31' as date ))
		left join [dbo].[t_rates] r
		 ON  r.Short_Role = a.ContractPosition
		 and dateadd(year, 3, p.EffectiveMonthDate) between r.Start_date and r.End_date
		
		Left join (SELECT [Month_data] , COUNT([Day_of_Month_data] ) as work_days_count
						  FROM [dbo].[t_Calendar]
						  WHERE (([Weekday] in (1, 2, 3, 4, 5) AND [Holiday] IS NULL) OR ([Weekday] = 6 AND [Workday] IS NOT NULL))
						  GROUP BY [Month_data]) c
			ON cast(cast(c.[Month_data] as nvarchar (6))+'01' as date) = p.EffectiveMonthDate

	--order by EffectiveMonthDate

GO



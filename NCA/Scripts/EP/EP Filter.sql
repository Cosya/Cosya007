SELECT distinct
			
			PER.Name
			--,per.Seniority_Id
			,SEN.Name as Seniority
			, oc.name as Ocupation
			, dep.Name as Department
			, per.StartDate
			, per.FinishDate
		FROM
			[EP].[PA].[EvaluationPeer] EPeer
			join sp.[Person] per
				on EPeer.[Person_Id] = per.[Id]
				and per.Department_Id in (
											SELECT
												[Id]
											FROM 
												[EP].[SP].[Department]
											WHERE 
												Name = 'Deloitte BU' 
											)
				and per.Seniority_Id not in		
										(SELECT 
											[Id]
										  FROM 
											[EP].[SP].[Seniority]
										  WHERE
											Name in ('Level 4', 'Level 3', 'Level 2')
								
										)
		join [EP].[SP].[Seniority] SEN
			ON per.Seniority_Id = 	SEN.Id
		Join [EP].[SP].[Occupation] oc
			ON per.Occupation_Id = 	oc.Id
		join ep.[SP].[Department] dep
			ON per.Department_Id = 	dep.Id

--	where per.FinishDate 
	order by 1
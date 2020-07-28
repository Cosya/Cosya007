Use EP;
/* mapping from [PA].[SeniorityScore]
	Name	Value
	Trainee	1
	Expert	16
	Senior	8
	Middle	4
	Junior	2
*/	
Begin
Declare @EmployeeName nvarchar(128)= 'Kostiantyn Bondarenko'; -- поставить любого сотрудника из EP

	with CTE_Seniority as (
		select 
			con.[Id], 
			con.[Period], 
			per.[Name], 
			rel.[Name] Role, 
			con.OverallScore ,
			iif(m.Name is null, '-', m.name) as mark, 
			ss.Value ProductivityScore 
		from 
			pa.[Context] con
			join PA.[ContextState] st 	 on con.[State_Id] = st.[Id]
			join PA.[EvaluationPeer] ep	 on con.[Id] = ep.[Context_Id]
			join sp.[Person] per 		 on ep.[Person_Id] = per.[Id]
			join pa.[Relation] rel 		 on rel.[Id] = ep.[Relation_Id] 
			join pa.[ContextCategory] cc on con.[ContextCategory_Id] = cc.[Id]
			join pa.EPFeedback fd		 on fd.EP_Id = ep.Id
			join pa.Grade g				 on g.id = fd.Grade_id
			join pa.KPI k				 on k.Id = g.KPI_Id
			left join pa.Mark m			 on m.id = g.Mark_id
			join sp.Seniority s			 on s.Name = m.name
			join pa.SeniorityScore ss	 on ss.Seniority_Id =s.Id
		where  
			exists 
 				(
				select 
					[Context].[Id]
     			from 
					[EP].[PA].[Context]
					join PA.[EvaluationPeer] ep	on [Context].[Id] = ep.[Context_Id]
					join sp.Person on Person.Id = ep.Person_Id
					join pa.[Relation] rel 		on rel.[Id] = ep.[Relation_Id] 
				where 
					con.[Id] = [Context].[Id]
					and person.Name = @EmployeeName  
					and rel.Name = 'Evaluated Person'

			)
	and st.Description = 'Completed' and rel.[Name] in ('Evaluator', 'Direct Manager' )
	and  cc.[Description] = 'Specialist'
	and k.Name = 'Productivity')

--развернутый вариант дл€ анализа
	Select distinct
	--	ID as Eval_programm_id
	--	,period
	--	,name as Evaluator_name
	--	,role as Evaluator_Role 
	--	,mark as EP_system_Evaluator_Mark --оценка конкретного евалюейтора в виде грейда из еп
		OverallScore as EP_system_OverallScore--обща€ оценка по всей программе в баллах из ≈ѕ
	--	,ProductivityScore -- артифишиал оценка а баллах на основании EP_system_Evaluator_Mark (мапинг вверху скрипта)
		,avg(ProductivityScore) over (partition by ID) as Avg_ProductivityScore -- средн€€ артифишиал оценка в баллах
		,case 
			when avg(ProductivityScore) over (partition by ID) <=1  then 'Trainee'
			when avg(ProductivityScore) over (partition by ID) > 1 and avg(ProductivityScore) over (partition by ID) <=3  then 'Junior'
			when avg(ProductivityScore) over (partition by ID) > 3 and avg(ProductivityScore) over (partition by ID) <=6  then 'Middle'
			when avg(ProductivityScore) over (partition by ID) > 6 and avg(ProductivityScore) over (partition by ID) <=12  then 'Senoir'
			when avg(ProductivityScore) over (partition by ID) > 12   then 'Expert'
		end as calc_sub_grade -- средн€€ артифишиал оценка в виде грейда 
	from 
		CTE_Seniority
	where 
		CTE_Seniority.Period in 
			(
				Select 
					max(Period) 
				from 
					CTE_Seniority
				)
		
	Order by  2,1;

end;

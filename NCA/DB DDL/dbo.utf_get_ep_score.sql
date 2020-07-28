USE [EPAS_DEV3]
GO
/****** Object:  UserDefinedFunction [dbo].[Split]    Script Date: 21.07.2020 12:39:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER FUNCTION [dbo].[get_ep_score]
(    
   @EmployeeName NVARCHAR(128)
   
)
RETURNS @RtnValue TABLE 
(
   
   EmployeeName NVARCHAR(128),
   LastEvalReriod date,
   OverallScore INT,
   AvgProductivityScore INT
) 
AS
BEGIN 
    
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

	Insert into @RtnValue (
		EmployeeName, 
		LastEvalReriod,
		OverallScore, 
		AvgProductivityScore 
			)
	Select distinct
		@EmployeeName
		,Period 
		,OverallScore 
		,avg(ProductivityScore) over (partition by ID) as AvgProductivityScore
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
	return	
 
END

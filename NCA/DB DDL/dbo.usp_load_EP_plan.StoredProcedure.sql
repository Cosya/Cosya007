USE [EPAS_DEV]
GO
/****** Object:  StoredProcedure [dbo].[usp_load_EP_plan]    Script Date: 12.10.2020 11:31:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--obsolete SP
ALTER PROCEDURE [dbo].[usp_load_EP_plan]
	@LoadMonth date--,
	--@ScenarioName nvarchar(256) 
	
AS
BEGIN
	Declare @RC int;
	Declare @Input nvarchar(256) =  cast(@LoadMonth as Nvarchar)  ;
	Declare @CountM int;
	Declare @CountP int;
	Declare @Concat nvarchar(256);
	--Declare @Sourceflag int;
	Declare @max_fact_date DATE;
	Declare @lastDayOftheyear  date;
	
	Declare @Precalc AS TABLE 
			(		
			[EP_ID] [uniqueidentifier] NOT NULL,
			[FullName] [nvarchar](256) NOT NULL,
			[EffectiveMonthDate] [date] NOT NULL,
			[EP_date] [date] NOT NULL,
			[Scenario_ID] [uniqueidentifier] NOT NULL,
			[Grade] [nvarchar](50) NOT NULL,
			[Base] [money] NULL,
			[Currency] [nvarchar](255) NOT NULL,
			[Addon] [money] NULL,
			[Variable] [money] NULL,
			[TotalMoney]  [money],
			[Sourceflag] [Int]

			);
 
 
	SET NOCOUNT ON;
	--Loging start
	EXECUTE @RC = [dbo].[usp_log]
  		'EXCEL',																--@Source NVARCHAR(128), 
		@Input ,																--@Params NVARCHAR(512),
		'usp_load_EP_plan',														--@Sp_name NVARCHAR(256),
		'[t_EP_Plan]',															--@Target_table NVARCHAR(256),
		'',																		--@Record_count int,
		'Start'																	--@Comment NVARCHAR(4000)

		--- 0  -fact excell, 1 - precalc, 2 - powerapp  


	--init 


	SELECT @lastDayOftheyear =  DATEADD (dd, -1, DATEADD(yy, DATEDIFF(yy, 0, @LoadMonth) +1, 0));
	Select  @max_fact_date =  max(EffectiveMonthDate) from dbo.[t_EP_Plan] where Sourceflag = 0;


	-- reload data
	IF @LoadMonth <= @max_fact_date
	
	
		begin

			delete from  
				[dbo].[t_EP_Plan] 
			where 
				(EffectiveMonthDate >= @LoadMonth and Sourceflag in (0,1))
				; 
					
		end
		
	-- New fact data	
	IF @LoadMonth > @max_fact_date 
	
			begin

			delete from  
				[dbo].[t_EP_Plan] 
			where 
				
				(EffectiveMonthDate =  @LoadMonth and EffectiveMonthDate < @lastDayOftheyear and Sourceflag in(1,2))-- remove all plan to raplace it with fact
				
				or 

				(EffectiveMonthDate >  @LoadMonth and EffectiveMonthDate < @lastDayOftheyear and Sourceflag in(1));  -- remove all plan and keep power apps apdated for future periods  
				
				; 
			end 


		insert into dbo.[t_EP_Plan]
			(
				[EP_ID],
				[FullName],
				[EffectiveMonthDate],
				[EP_date],
				[Scenario_ID],
				[Grade],
				[Base],
				[Currency],
				[Addon],
				--[Type_addon],
				[Variable],
				Sourceflag
	
			)
			select distinct
				
				EP_ID,
				m.Full_Name,
				m.EffectiveMonthDate, 
				DATEADD(month, p.[EvaluationFrequency], fn_res.LastEvalReriod) AS [EP_date],
				s.ID,
				g.Grade,
				m.Base,
				m.Currency,
				m.Addon,
				m.Variable,
				0 as Sourceflag  
			from 
				[dbo].[t_s_report_excel] m
				
				left join [dbo].[t_short_grades] g
					on g.Long_Grade = m.Grade
				
				Left join [SP].[Person] p
					on p.Name = dbo.udf_SwapName (m.Full_Name)
				
				cross apply [dbo].[get_ep_score](dbo.udf_SwapName (m.Full_Name)) as fn_res
				cross join [dbo].[t_scenario] s
				
			
			
			where
				 EffectiveMonthDate =  @LoadMonth;

-- precalc plan salary

		insert into @Precalc
			(
				[EP_ID],
				[FullName],
				[EffectiveMonthDate],
				[EP_date],
				[Scenario_ID],
				[Grade],
				[Base],
				[Currency],
				[Addon],
				[Variable],
				Sourceflag  
			)
		
		Select 
			[EP_ID],
			[FullName], 
			cast (cast(calendar.month_data as nvarchar) + '01' as date) as EffectiveMonthDate,
			[EP_date],
			[Scenario_ID],
			[Grade], 
			[Base], 
			[Currency],
			[Addon],
			[Variable],
			1 --precalc
			
		from 
			[dbo].[t_EP_Plan] 
			cross join (Select 
							distinct  t.month_data 
						from 
							[dbo].[t_Calendar] t 
						where 
							t.Date > dateadd(month, +1, @LoadMonth)
							and date < @lastDayOftheyear) calendar

		where 
			EffectiveMonthDate = @LoadMonth
			;
 /*
	insert into dbo.[t_EP_Plan]
			(
			[EP_ID],
			[FullName],
			[EffectiveMonthDate],
			[EP_date],
			[Scenario_ID],
			[Grade],
			[Base],
			[Currency],
			[Addon],
			[Variable],
			Sourceflag
	
			)
		select 
			[EP_ID],
			[FullName],
			[EffectiveMonthDate],
			[EP_date],
			[Scenario_ID],
			[Grade],
			[Base],
			[Currency],
			[Addon],
			[Variable],
			Sourceflag  
		from  
			@Precalc;
*/
	
	WITH Source AS (
		SELECT
			[EP_ID],
			[FullName],
			[EffectiveMonthDate],
			[EP_date],
			[Scenario_ID],
			[Grade],
			[Base],
			[Currency],
			[Addon],
			[Variable],
			Sourceflag
		FROM 
			@Precalc)
	
	MERGE INTO dbo.[t_EP_Plan] AS Target
	USING Source
	ON  Target.[FullName] = Source.[FullName]
		and Target.[EffectiveMonthDate] = Source.[EffectiveMonthDate]
		and Target.[Scenario_ID] = Source.[Scenario_ID]


	WHEN MATCHED AND (
		Target.[Sourceflag] = 2
		
	) THEN
		UPDATE SET
			Target.[EP_ID] = Source.[EP_ID],
			Target.[Created_on] = current_timestamp
	
	WHEN NOT MATCHED BY TARGET THEN
		INSERT( [EP_ID],
				[FullName],
				[EffectiveMonthDate],
				[EP_date],
				[Scenario_ID],
				[Grade],
				[Base],
				[Currency],
				[Addon],
				[Variable],
				Sourceflag
			) 
		VALUES( [EP_ID],
				[FullName],
				[EffectiveMonthDate],
				[EP_date],
				[Scenario_ID],
				[Grade],
				[Base],
				[Currency],
				[Addon],
				[Variable],
				Sourceflag
			) ;
	
	--WHEN NOT MATCHED BY SOURCE THEN
	--DELETE;
	--GO

	
		--Loging end
	Select 
		@CountM = count(*) 
	from 
		[dbo].[t_subgrade] 
	
	where EffectiveMonthDate =@LoadMonth;


	 Select @Concat = cast(@CountM as Nvarchar) ;

	EXECUTE @RC = [dbo].[usp_log]
  		'EXCEL',																--@Source NVARCHAR(128), 
		@Input ,																--@Params NVARCHAR(512),
		'usp_load_EP_plan',													--@Sp_name NVARCHAR(256),
		't_EP_Plan',													--@Target_table NVARCHAR(256),
		@Concat,																--@Record_count int,
		'End'																	--Comment		
  
END


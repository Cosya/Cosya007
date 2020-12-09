USE [EPAS]
GO
/****** Object:  StoredProcedure [dbo].[usp_load_sub_grade]    Script Date: 13.10.2020 22:40:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--obsolete SP
ALTER PROCEDURE [dbo].[usp_load_sub_grade]
	@LoadMonth date
	
AS
BEGIN
	DECLARE @RC int;
	Declare @Input nvarchar(256) =  cast(@LoadMonth as Nvarchar)  ;
	Declare @CountM int;
	Declare @CountP int;
	Declare @Concat nvarchar(256);

	SET NOCOUNT ON;
	--Loging start
	EXECUTE @RC = [dbo].[usp_log]
  		'EXCEL',																--@Source NVARCHAR(128), 
		@Input ,																--@Params NVARCHAR(512),
		'usp_load_sub_grade',													--@Sp_name NVARCHAR(256),
		'[t_manager_map],[t_project_map]',										--@Target_table NVARCHAR(256),
		'',																		--@Record_count int,
		'Start'																	--@Comment NVARCHAR(4000)

	--project 
	delete from  [dbo].[t_subgrade]
	where EffectiveMonthDate =@LoadMonth;

	insert into dbo.[t_subgrade]
	(
	[EffectiveMonthDate],
	[Full_Name],
	[OverallScore],
	[AvgProductivityScore],
	[SubGrade]

	)
	select distinct
		m.EffectiveMonthDate, 
		m.Full_Name,
		fn_res.OverallScore,
		fn_res.AvgProductivityScore, 
		
		[dbo].[udf_CalcSubGrade] ( g.Grade, fn_res.OverallScore,fn_res.AvgProductivityScore) as [SubGrade]  
	from 
		[dbo].[t_s_report_excel] m
		  left join [dbo].[t_short_grades] g
			on g.Long_Grade = m.Grade
		  outer apply [dbo].[get_ep_score](dbo.udf_SwapName (m.Full_Name)) as fn_res --cross >> outer not to restrict the data
	where
		 EffectiveMonthDate = @LoadMonth;

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
		'usp_load_sub_grade',													--@Sp_name NVARCHAR(256),
		'[t_subgrade]',													--@Target_table NVARCHAR(256),
		@Concat,																--@Record_count int,
		'End'																	--Comment		
  
END


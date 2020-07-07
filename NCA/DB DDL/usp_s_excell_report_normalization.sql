USE [EPAS]
GO

/****** Object:  StoredProcedure [dbo].[usp_s_excell_report_normalization]    Script Date: 07.07.2020 12:19:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


--obsolete SP
CREATE PROCEDURE [dbo].[usp_s_excell_report_normalization]
	@LoadMonthStart date,
	@LoadMonthEnd date
	
AS
BEGIN
	DECLARE @RC int;
	Declare @Input nvarchar(256) =  cast(@LoadMonthStart as Nvarchar) +','+ Cast(@LoadMonthEnd as Nvarchar) ;
	Declare @CountM int;
	Declare @CountP int;
	Declare @Concat nvarchar(256);

	SET NOCOUNT ON;
	--Loging start
	EXECUTE @RC = [dbo].[usp_log]
  		'EXCEL',																--@Source NVARCHAR(128), 
		@Input ,																--@Params NVARCHAR(512),
		'usp_s_excell_report_normalization',									--@Sp_name NVARCHAR(256),
		'[t_manager_map],[t_project_map]',										--@Target_table NVARCHAR(256),
		'',																		--@Record_count int,
		'Start'																	--@Comment NVARCHAR(4000)

	--project 
	delete from [dbo].[t_project_map]
	where EffectiveMonthDate between @LoadMonthStart and @LoadMonthEnd;

	insert into [t_project_map]
	(
	[EffectiveMonthDate],
	[Full_Name],
	[Project]
	)
	select 
		EffectiveMonthDate, 
		Full_Name,
		Value as Project  
	from 
		[EPAS].[dbo].[t_s_report_excel] m
		CROSS APPLY STRING_SPLIT(m.Project, ';')
	where
		 EffectiveMonthDate between @LoadMonthStart and @LoadMonthEnd;

	--manager 
	delete from [dbo].[t_manager_map]
	where
		EffectiveMonthDate between @LoadMonthStart and @LoadMonthEnd;

	insert into [t_manager_map]
	(
		[EffectiveMonthDate],
		[Full_Name],
		[Direct_Manager]
	)
	select 
		EffectiveMonthDate, 
		Full_Name,
		Value as Direct_Manager  
	from 
		[EPAS].[dbo].[t_s_report_excel] m
		CROSS APPLY STRING_SPLIT(m.Direct_Manager, ';')
	where
		 EffectiveMonthDate between @LoadMonthStart and @LoadMonthEnd;

		--Loging end
	Select 
		@CountM = count(*) 
	from 
		[EPAS].[dbo].[t_manager_map] 
	where 
		EffectiveMonthDate between @LoadMonthStart and @LoadMonthEnd;

	Select 
		@CountP = count(*) 
	from 
		[EPAS].[dbo].[t_Project_map] 
	where 
		EffectiveMonthDate between @LoadMonthStart and @LoadMonthEnd;

	 Select @Concat = cast(@CountM as Nvarchar) +','+ Cast(@CountP as Nvarchar);

	EXECUTE @RC = [dbo].[usp_log]
  		'EXCEL',																--@Source NVARCHAR(128), 
		@Input ,																--@Params NVARCHAR(512),
		'usp_s_excell_report_normalization',									--@Sp_name NVARCHAR(256),
		'[t_manager_map],[t_project_map]',										--@Target_table NVARCHAR(256),
		@Concat,																--@Record_count int,
		'End'																	--Comment		
  
END

GO



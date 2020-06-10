USE [EPAS]
GO
/****** Object:  StoredProcedure [dbo].[usp_PostExcelImport]    Script Date: 03.06.2020 13:52:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[usp_PostExcelImport]
	-- Add the parameters for the stored procedure here

	@LoadMonth date, --
	@PriorLoadMonth date
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	update [EPAS].[dbo].[t_s_report_excel] 
		set [EffectiveMonthDate]= @LoadMonth --'2020-02-01' 
	where 
		[EffectiveMonthDate] is null

	update [EPAS].[dbo].[t_subgrade_excel] 
		set [EffectiveMonthDate]= @LoadMonth --'2020-02-01' 
	where [EffectiveMonthDate] is null
	--
	delete  
	from 
		[EPAS].[dbo].[t_s_report_excel] 
	where 
		grade like '%manager%' 
		or grade like '%administrator%' 
		or grade like '%executive%'
	--
	delete  
	from 
		[EPAS].[dbo].[t_s_report_excel] 
	where 
		currency = 'UAH'
	--
	delete 
	from 
		[EPAS].[dbo].[t_subgrade_excel] 
	where SubGrade is null

	delete 
	from 
		[EPAS].[dbo].[t_s_report_excel] 
	where 
		TotalMoney < 100
	--
	update [EPAS].[dbo].[t_s_report_excel] 
		set Project = REPLACE(Project, 'Deloitte-Administrative;','') 
	where 
		Project <> 'Deloitte-Administrative'
	--
	update [EPAS].[dbo].[t_s_report_excel] 
		set Project = REPLACE(Project, ';Deloitte-Administrative','') 
	where Project <> 'Deloitte-Administrative'
	--
	update [EPAS].[dbo].[t_s_report_excel] 
		set Project = REPLACE(Project, 'Deloitte-NCA;','') 
	where 
		Project <> 'Deloitte-NCA'
	--
	update [EPAS].[dbo].[t_s_report_excel] 
		set Project = REPLACE(Project, ';Deloitte-NCA','') 
	where 
		Project <> 'Deloitte-NCA'
	
	update [EPAS].[dbo].[t_s_report_excel] 
		set Project = REPLACE(Project, 'Corporate Development-Administrative;','') 
	where 
		Project <> 'Corporate Development-Administrative'
	--
	update [EPAS].[dbo].[t_s_report_excel] 
		set Project = REPLACE(Project, ';Corporate Development-Administrative','') 
	where 
		Project <> 'Corporate Development-Administrative'

	select 
		* 
	from 
		[EPAS].[dbo].[t_s_report_excel] t1
		left join [EPAS].[dbo].[t_s_report_excel] t2 
			on t1.EffectiveMonthDate = @LoadMonth --'2019-07-01' 
			and t2.EffectiveMonthDate = @PriorLoadMonth --'2019-06-01' 
			and t1.Full_Name = t2.Full_Name
	where 
		t1.Grade <> t2.Grade or t1.Grade is null
		and t1.EffectiveMonthDate =  @LoadMonth --'2019-07-01'
		and t2.EffectiveMonthDate = @PriorLoadMonth --'2019-06-01'

END


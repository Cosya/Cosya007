USE [EPAS]
GO

/****** Object:  StoredProcedure [dbo].[usp_report_Statistics_ByLocation]    Script Date: 6/2/2020 11:21:48 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_report_Statistics_ByLocation]
	-- Add the parameters for the stored procedure here
	@Month1 date,
	@Month2 date
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


select
	re.EffectiveMonthDate,
	sg.Short_Grade,
	sg.Specialization,
	sg.Grade,
	sg.Grade_Type,
	re.Group_Leader,
	re.Full_Name,
	re.Location_Short,
	TotalMoney as Compensation
FROM [EPAS].[dbo].[t_s_report_excel] re
  left join [EPAS].[dbo].[t_short_grades] sg 
	on re.Grade = sg.Long_Grade
where 
	re.EffectiveMonthDate>=@Month1
	and re.EffectiveMonthDate<=@Month2

END
GO



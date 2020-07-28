USE [EPAS]
GO

/****** Object:  StoredProcedure [dbo].[usp_report_TotalPortfolio]    Script Date: 6/2/2020 11:22:00 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_report_TotalPortfolio]
	-- Add the parameters for the stored procedure here
	@Year int,
	@Group_Leader nvarchar(255),
	@Location nvarchar(255)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT
sg.Short_Grade,
[MonthName] as [Month],
re.EffectiveMonthDate as MonthDate,
DATEPART(MONTH, re.EffectiveMonthDate) as MonthNum,
Min(TotalMoney) as [Min],
Round(Avg(TotalMoney),0) as Average,
Max(TotalMoney) as [Max]
  FROM [EPAS].[dbo].[t_s_report_excel] re
  left join [EPAS].[dbo].[t_short_grades] sg on re.Grade = sg.Long_Grade
where 
	(re.Location_Short = @Location OR @Location = 'All Locations')
	and (re.Group_Leader = @Group_Leader OR @Group_Leader = 'All Group Leaders')
	and re.EffectiveYear=@Year
group by sg.Short_Grade, DATENAME(mm,re.EffectiveMonthDate), DATEPART(MONTH, re.EffectiveMonthDate), re.EffectiveMonthDate
order by MonthNum, Short_Grade

END
GO



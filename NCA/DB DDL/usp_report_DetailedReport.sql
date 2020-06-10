USE [EPAS]
GO

/****** Object:  StoredProcedure [dbo].[usp_report_DetailedReport]    Script Date: 6/2/2020 11:21:35 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_report_DetailedReport]
	-- Add the parameters for the stored procedure here
	 @Month date
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select
re.Full_Name,
sg.Short_Grade,
sg.Grade,
sg.Specialization,
sg.Grade_Type,
re.Group_Leader,
re.Location_Short as [Location],
re.Project,
TotalMoney as TotalMoney,
Base,
Addon,
Variable
  FROM [EPAS].[dbo].[t_s_report_excel] re
  left join [EPAS].[dbo].[t_short_grades] sg on re.Grade = sg.Long_Grade
where 
	 re.EffectiveMonthDate = @Month


END
GO



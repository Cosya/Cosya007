/****** Script for SelectTopNRows command from SSMS  ******/
Update [EPAS_DEV3].[dbo].[t_short_grades]
  Set Short_Grade = 'BI Jr Dev'
   WHERE Short_Grade = '.Net Jr Dev'
  and Specialization = 'BI ＆ data management'

  Select  * from [EPAS_DEV3].[dbo].[t_short_grades]
  WHERE Short_Grade = '.Net Jr Dev'
  --and Specialization = '.NET'
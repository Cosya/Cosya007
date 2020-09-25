USE [EPAS]
GO
/****** Object:  StoredProcedure [dbo].[usp_SPAssignmentLoad]    Script Date: 15.09.2020 18:19:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
ALTER PROCEDURE [dbo].[usp_dboCalendarLoad]
AS
BEGIN

	DECLARE @DefaultInt INT = 0;
	DECLARE @DefaultString nvarchar(255) = 'merging';
	
	
	Delete  from [dbo].[t_Calendar] ;


	INSERT INTO [dbo].[t_Calendar]
					(
						[Date_data] ,
						[Year_data] ,
						[Quarter_data] ,
						[Month_data] ,
						[Week_data] ,
						[Day_of_Year_data],
						[Day_of_Month_data] ,
						[Weekday] ,
						[Date] ,
						[Date_data_char] ,
						[Holiday] ,
						[Workday],
						[One] ,
						[MovedWeekend]
					)


					Select
						
						[Date_data] ,
						[Year_data] ,
						[Quarter_data] ,
						[Month_data] ,
						[Week_data] ,
						[Day_of_Year_data],
						[Day_of_Month_data] ,
						[Weekday] ,
						[Date] ,
						[Date_data_char] ,
						[Holiday] ,
						[Workday],
						[One] ,
						[MovedWeekend]
					from 
						[CorporateDWH].[dbo].[tDate] ;
						

	
	--GO
	PRINT 'Import was successful from PA.[t_Calendar]'
END
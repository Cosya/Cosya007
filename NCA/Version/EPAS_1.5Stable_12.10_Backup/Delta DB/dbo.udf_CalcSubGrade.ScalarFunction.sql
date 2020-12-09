USE [EPAS]
GO
/****** Object:  UserDefinedFunction [dbo].[udf_CalcSubGrade]    Script Date: 13.10.2020 16:51:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER FUNCTION [dbo].[udf_CalcSubGrade] 

( @IN_Grade varchar(255),
   @IN_OverallScore INT,
   @IN_AvgProductivityScore INT
)

RETURNS varchar(255)

AS

BEGIN

declare @TraineeAvgGrade	int = 1;
declare @JuniorAvgGrade     int = 2;
declare @MiddleAvgGrade     int = 4;
declare @SeniorAvgGrade     int = 8;
declare @ExpertAvgGrade		int = 16;
declare @Subgrade varchar(50) = 'Unknown'; 


IF (@IN_OverallScore is null) or (@IN_AvgProductivityScore is null) or (@IN_Grade is null)
	set @Subgrade = 'Middle_performer'

IF @IN_OverallScore<80 
	set @Subgrade = 'Low_performer' 

--expert 

IF @IN_Grade = 'Expert' and @IN_AvgProductivityScore> 90  and @IN_AvgProductivityScore > @ExpertAvgGrade 
	set @Subgrade = 'High_performer' 

IF @IN_Grade = 'Expert' and @IN_OverallScore>=80 and @IN_OverallScore<90  
	set @Subgrade = 'Middle_performer'

IF @IN_Grade = 'Expert' and @IN_AvgProductivityScore<= @ExpertAvgGrade 
     set @Subgrade =  'Low_performer' 


--senior

IF (@IN_Grade = 'Senior' or @IN_Grade = 'Team Leader') and @IN_OverallScore>=90 and @IN_AvgProductivityScore > @SeniorAvgGrade 
	set @Subgrade = 'High_performer'
--ELSE  
	--set @Subgrade = 'Middle_performer'

IF (@IN_Grade = 'Senior' or @IN_Grade = 'Team Leader') and @IN_OverallScore>=80 and @IN_OverallScore<90 
	set @Subgrade =  'Middle_performer' 

IF(@IN_Grade = 'Senior' or @IN_Grade = 'Team Leader') and @IN_AvgProductivityScore<= @SeniorAvgGrade
	set @Subgrade =  'Low_performer' 

--middle

IF @IN_Grade = 'Middle' and @IN_OverallScore>=90 and @IN_AvgProductivityScore > @MiddleAvgGrade 
	set @Subgrade = 'High_performer'
--ELSE  
	--set @Subgrade = 'Middle_performer'

IF @IN_Grade = 'Middle' and @IN_OverallScore>=80 and @IN_OverallScore<90 
	set @Subgrade =  'Middle_performer' 

IF @IN_Grade = 'Middle' and @IN_AvgProductivityScore<= @MiddleAvgGrade
     set @Subgrade =  'Low_performer' 

--Junior

IF @IN_Grade = 'Junior' and @IN_OverallScore>=90 and @IN_AvgProductivityScore > @JuniorAvgGrade 
     set @Subgrade = 'High_performer'
--ELSE  set @Subgrade = 'Middle_performer'

IF @IN_Grade = 'Junior' and @IN_OverallScore>=80 and @IN_OverallScore<90 
	set @Subgrade =  'Middle_performer' 

IF @IN_Grade = 'Junior' and @IN_AvgProductivityScore<= @MiddleAvgGrade
     set @Subgrade =  'Low_performer' 

--Trainee
IF @IN_Grade = 'Trainee' and @IN_OverallScore>=90 and @IN_AvgProductivityScore > @TraineeAvgGrade 
     set @Subgrade = 'High_performer'
--ELSE  
--	set @Subgrade = 'Middle_performer'

IF @IN_Grade = 'Trainee' and @IN_OverallScore>=80 and @IN_OverallScore<90 
	set @Subgrade =  'Middle_performer' 

IF @IN_Grade = 'Trainee' and @IN_AvgProductivityScore<= @TraineeAvgGrade
		set @Subgrade =  'Low_performer' 


RETURN @Subgrade


 

END

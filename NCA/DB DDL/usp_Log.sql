USE [EPAS]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create or alter procedure [dbo].[usp_log]
  
	@Source NVARCHAR(128), 
	@Params NVARCHAR(512),
	@Sp_name NVARCHAR(256),
	@Target_table NVARCHAR(256),
	@Record_count NVARCHAR(128),
	@Comment NVARCHAR(4000)
AS
BEGIN
	SET NOCOUNT ON;
	
		     -- Insert log record into the table
			INSERT INTO t_log (
					Source , 
					params ,
					SP_name,
					Target_table,
					Record_count,
					Comment
			)
				SELECT 
					@Source			as Source,		
					@Params			as Params,			
					@Sp_name		as Sp_name,		
					@Target_table	as Target_table,
					@Record_count	as Record_count,
					@Comment        as Comment


END;
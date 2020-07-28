USE [EPAS_DEV3]
GO
/****** Object:  StoredProcedure [Import].[PersonLoad]    Script Date: 16.07.2020 18:37:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE dbo.usp_PAContextLoad
AS
BEGIN

	DECLARE @DefaultInt INT = 0;
	DECLARE @DefaultString nvarchar(255) = 'merging';

	WITH Source AS (
		SELECT
			 
			 [Id] 
			 ,[Period] 
			 ,[Type_Id] 
			 ,[State_Id] 
			 ,[OverallScore]
			 ,[DateUpdated]
			 ,[UnderDiscussionCount] 
			 ,[ContextCategory_Id]
			 ,[Status_Id] 
	
		FROM [EP].[PA].[Context])
	
	MERGE INTO [PA].[Context] AS Target
	USING Source
	ON Target.Id = Source.Id
	WHEN MATCHED AND (
		
			 target.[Period]					<> source.[Period]
			 OR target.[Type_Id] 				<> source.[Type_Id] 				
			 OR target.[State_Id] 				<> source.[State_Id] 				
			 OR target.[OverallScore]			<> source.[OverallScore]			
			 OR target.[DateUpdated]			<> source.[DateUpdated]			
			 OR target.[UnderDiscussionCount] 	<> source.[UnderDiscussionCount] 	
			 OR target.[ContextCategory_Id]		<> source.[ContextCategory_Id]		
			 OR target.[Status_Id] 				<> source.[Status_Id] 				
		
	) THEN
		UPDATE SET
			 target.[Period]				= source.[Period],
			 target.[Type_Id] 				= source.[Type_Id] ,				
			 target.[State_Id] 				= source.[State_Id] ,				
			 target.[OverallScore]			= source.[OverallScore]	,		
			 target.[DateUpdated]			= source.[DateUpdated]	,		
			 target.[UnderDiscussionCount] 	= source.[UnderDiscussionCount], 	
			 target.[ContextCategory_Id]	= source.[ContextCategory_Id],		
			 target.[Status_Id] 			= source.[Status_Id] 
	

	WHEN NOT MATCHED BY TARGET THEN
		INSERT(Id, [Period], [Type_Id], [State_Id], [OverallScore],[DateUpdated],[UnderDiscussionCount],[ContextCategory_Id],[Status_Id]) 
		VALUES(Id, [Period], [Type_Id], [State_Id], [OverallScore], [DateUpdated],[UnderDiscussionCount],[ContextCategory_Id],[Status_Id])
	WHEN NOT MATCHED BY SOURCE THEN
	DELETE;
	--GO
	PRINT 'Import was successful from PA.[EvaluationPeer]'
END
USE [EPAS_DEV3]
GO
/****** Object:  StoredProcedure [Import].[PersonLoad]    Script Date: 16.07.2020 18:37:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE dbo.usp_PAEvaluationPeerLoad
AS
BEGIN

	DECLARE @DefaultInt INT = 0;
	DECLARE @DefaultString nvarchar(255) = 'merging';

	WITH Source AS (
		SELECT
			 [Id] 
			,[Context_Id] 
			,[Person_Id] 
			,[Relation_Id]
			,[State_Id] 
			,[DateCreated]
			,[DateUpdated]
			,[Status_Id] 
		
		FROM [EP].[PA].[EvaluationPeer])
	
	MERGE INTO [PA].[EvaluationPeer] AS Target
	USING Source
	ON Target.Id = Source.Id
	WHEN MATCHED AND (
		   Target.[Context_Id] <> Source.[Context_Id]
		OR Target.[Person_Id] <> Source.[Person_Id]
		OR Target.[Relation_Id]<> Source.[Relation_Id]
		OR Target.[State_Id] <> Source.[State_Id]
		OR Target.[DateCreated]  <> Source.[DateCreated]
		OR Target.[DateUpdated] <> Source.[DateUpdated]
		OR Target.[Status_Id]  <> Source.[Status_Id]
		
	) THEN
		UPDATE SET
			Target.[Context_Id] = Source.[Context_Id],
			Target.[Person_Id] = Source.[Person_Id],
			Target.[Relation_Id]= Source.[Relation_Id],
			Target.[State_Id] = Source.[State_Id],
			Target.[DateCreated]  = Source.[DateCreated],
			Target.[DateUpdated] = Source.[DateUpdated],
			Target.[Status_Id]  = Source.[Status_Id]
	

	WHEN NOT MATCHED BY TARGET THEN
		INSERT(Id, [Context_Id], [Person_Id], [Relation_Id], [State_Id],[DateCreated],[DateUpdated],[Status_Id]) 
		VALUES(Id, [Context_Id], [Person_Id], [Relation_Id], [State_Id], [DateCreated],[DateUpdated],[Status_Id])
	WHEN NOT MATCHED BY SOURCE THEN
	DELETE;
	--GO
	PRINT 'Import was successful from PA.[EvaluationPeer]'
END
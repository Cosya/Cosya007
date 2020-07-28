USE [EPAS_DEV3]
GO
/****** Object:  StoredProcedure [Import].[PersonLoad]    Script Date: 16.07.2020 18:37:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE dbo.usp_PAEPFeedbackLoad
AS
BEGIN

	DECLARE @DefaultInt INT = 0;
	DECLARE @DefaultString nvarchar(255) = 'merging';

	WITH Source AS (
		SELECT [Id]
			,[EP_Id]
			,[Grade_Id]
			,[Comment]
					
		FROM [EP].[PA].[EPFeedback])
	
	MERGE INTO [PA].[EPFeedback] AS Target
	USING Source
	ON Target.Id = Source.Id
	WHEN MATCHED AND (
		Target.[EP_Id] <> Source.[EP_Id]
		OR Target.[Grade_Id] <> Source.[Grade_Id]
		OR ISNULL(Target.[Comment], @DefaultString) <> ISNULL(Source.[Comment], @DefaultString)
		
	) THEN
		UPDATE SET
			Target.[EP_Id] = Source.[EP_Id],
			Target.[Grade_Id] = Source.[Grade_Id],
			Target.[Comment] = Source.[Comment]
			
	WHEN NOT MATCHED BY TARGET THEN
		INSERT(Id, [EP_Id], [Grade_Id], [Comment]) 
		VALUES(Id, [EP_Id], [Grade_Id], [Comment])
	WHEN NOT MATCHED BY SOURCE THEN
	DELETE;
	--GO
	PRINT 'Import was successful from PA.[EPFeedback]'
END
USE [EPAS_DEV3]
GO

/****** Object:  StoredProcedure [Import].[SeniorityLoad]    Script Date: 16.07.2020 17:56:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_PAContextCategoryLoad]
AS
BEGIN

	DECLARE @DefaultString nvarchar(255) = 'merging';
	DECLARE @DefaulttinyInt tinyInt = 0;
	
	WITH Source AS (
		SELECT [Id]
			,[Value]
			,[Description]
		
		FROM [EP].[PA].[ContextCategory])
	
	MERGE INTO [PA].[ContextCategory] AS Target
	USING Source
	ON Target.Id = Source.Id
	WHEN MATCHED AND (
		 ISNULL(Target.[Value], @DefaulttinyInt) <> ISNULL(Source.[Value], @DefaulttinyInt) 
		OR ISNULL(Target.[Description], @DefaultString) <> ISNULL(Source.[Description], @DefaultString) 
		
	) THEN
		UPDATE SET
			Target.[Value] = Source.[Value],
			Target.[Description] = Source.[Description]
		
	WHEN NOT MATCHED BY TARGET THEN
		INSERT(Id, [Value],  [Description]) 
		VALUES(Id, [Value],  [Description])
	WHEN NOT MATCHED BY SOURCE THEN
	DELETE;
	--GO

	PRINT 'Import was successful from PA.[ContextCategory]'
END
GO



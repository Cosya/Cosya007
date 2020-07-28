USE [EPAS_DEV3]
GO
/****** Object:  StoredProcedure [Import].[PersonLoad]    Script Date: 16.07.2020 18:37:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE dbo.usp_PAGradeLoad
AS
BEGIN

	DECLARE @DefaultInt INT = 0;
	DECLARE @DefaultString nvarchar(255) = 'merging';

	WITH Source AS (
		SELECT [Id]
			,[KPI_Id]
			,[Mark_Id]
			,[Value]
			,[Description]
			,[ContextCategory_Id]
		
		FROM [EP].[PA].[Grade])
	
	MERGE INTO [PA].[Grade] AS Target
	USING Source
	ON Target.Id = Source.Id
	WHEN MATCHED AND (
		 Target.[KPI_Id] <> Source.[KPI_Id]
		OR Target.[Mark_Id] <> Source.[Mark_Id]
		OR ISNULL(Target.[Value], @DefaultInt) <> ISNULL(Source.[Value], @DefaultInt)
		OR ISNULL(Target.[Description], @DefaultString) <> ISNULL(Source.[Description], @DefaultString)
		OR Target.[ContextCategory_Id]  <> Source.[ContextCategory_Id]
		
	) THEN
		UPDATE SET
			Target.[KPI_Id] = Source.[KPI_Id],
			Target.[Mark_Id] = Source.[Mark_Id],
			Target.[Value] = Source.[Value],
			Target.[Description] = Source.[Description]
	WHEN NOT MATCHED BY TARGET THEN
		INSERT(Id, [KPI_Id], [Mark_Id], [Value], [Description],[ContextCategory_Id]) 
		VALUES(Id, [KPI_Id], [Mark_Id], [Value], [Description], [ContextCategory_Id])
	WHEN NOT MATCHED BY SOURCE THEN
	DELETE;
	--GO
	PRINT 'Import was successful from PA.[Grade]'
END
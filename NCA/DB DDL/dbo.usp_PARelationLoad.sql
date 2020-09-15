USE [EPAS]
GO
/****** Object:  StoredProcedure [Import].[PersonLoad]    Script Date: 16.07.2020 18:37:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
Create PROCEDURE dbo.usp_PARelationLoad
AS
BEGIN
	DECLARE @DefaultString nvarchar(255) = 'merging';
	DECLARE @DefaultTinyInt tinyint = 0;
	DECLARE @DefaultVarBinary varbinary = 0;
	DECLARE @DefaultBit bit = 1;

	WITH Source AS (
		SELECT
			[Id],
			[Name],
			[ProcessOrder],
			[Description]
		FROM [EP].[PA].[Relation])
	
	MERGE INTO [PA].[Relation] AS Target
	USING Source
	ON Target.Id = Source.Id
	WHEN MATCHED AND (
		Target.Name <> Source.Name
		OR Target.[ProcessOrder] <> Source.[ProcessOrder]
		OR ISNULL(Target.[Description], @DefaultString) <> ISNULL(Source.[Description], @DefaultString) 
	) THEN
		UPDATE SET
			Target.[Name] = Source.[Name],
			Target.[ProcessOrder] = Source.[ProcessOrder],
			Target.[Description] = Source.[Description]

	WHEN NOT MATCHED BY TARGET THEN
		INSERT(Id, Name, [ProcessOrder], [Description]) 
		VALUES(Id, Name, [ProcessOrder], [Description])
	WHEN NOT MATCHED BY SOURCE THEN
	DELETE;
	--GO

	PRINT 'Import was successful from PA.[Relation]'
END
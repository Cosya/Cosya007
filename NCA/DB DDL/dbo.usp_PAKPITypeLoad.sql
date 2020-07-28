USE [EPAS_DEV3]
GO

/****** Object:  StoredProcedure [Import].[SeniorityLoad]    Script Date: 16.07.2020 17:56:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_PAKPITypeLoad]
AS
BEGIN

	DECLARE @DefaultString nvarchar(255) = 'merging';
	
	WITH Source AS (
		SELECT [Id]
			,[Name]
			,[Description]
		
		FROM [EP].[PA].[KPIType])
	
	MERGE INTO [PA].[KPIType] AS Target
	USING Source
	ON Target.Id = Source.Id
	WHEN MATCHED AND (
		Target.[Name] <> Source.[Name] 
		OR ISNULL(Target.[Description], @DefaultString) <> ISNULL(Source.[Description], @DefaultString) 
		
	) THEN
		UPDATE SET
			Target.[Name] = Source.[Name],
			Target.[Description] = Source.[Description]
		
	WHEN NOT MATCHED BY TARGET THEN
		INSERT(Id, [Name],  [Description]) 
		VALUES(Id, [Name],  [Description])
	WHEN NOT MATCHED BY SOURCE THEN
	DELETE;
	--GO

	PRINT 'Import was successful from PA.[KPIType]'
END
GO



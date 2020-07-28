USE [EPAS_DEV3]
GO
/****** Object:  StoredProcedure [Import].[PersonLoad]    Script Date: 16.07.2020 18:37:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
Create PROCEDURE dbo.usp_PAMarkLoad
AS
BEGIN
	DECLARE @DefaultString nvarchar(255) = 'merging';


	WITH Source AS (
		SELECT
			[Id],
			[Name]
		FROM [EP].[PA].[Mark])
	
	MERGE INTO [PA].[Mark] AS Target
	USING Source
	ON Target.Id = Source.Id
	WHEN MATCHED AND (
		Target.Name <> Source.Name
		
	) THEN
		UPDATE SET
			Target.[Name] = Source.[Name]
	WHEN NOT MATCHED BY TARGET THEN
		INSERT(Id, Name) 
		VALUES(Id, Name)
	WHEN NOT MATCHED BY SOURCE THEN
	DELETE;
	--GO

	PRINT 'Import was successful from PA.[Relation]'
END
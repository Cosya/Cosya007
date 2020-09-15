USE [EPAS]
GO

/****** Object:  StoredProcedure [Import].[SeniorityLoad]    Script Date: 16.07.2020 17:56:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_SPSeniorityLoad]
AS
BEGIN

	DECLARE @DefaultString nvarchar(255) = 'merging';
	
	WITH Source AS (
		SELECT [Id]
			,[Name]
			,[Order]
			,[Description]
			,[State_Id]

		FROM [EP].[SP].[Seniority])
	
	MERGE INTO [SP].[Seniority] AS Target
	USING Source
	ON Target.Id = Source.Id
	WHEN MATCHED AND (
		Target.[Name] <> Source.[Name] 
		OR Target.[Order] <> Source.[Order]
		OR ISNULL(Target.[Description], @DefaultString) <> ISNULL(Source.[Description], @DefaultString) 
		OR Target.[State_Id] <> Source.[State_Id]
	) THEN
		UPDATE SET
			Target.[Name] = Source.[Name],
			Target.[Order] = Source.[Order],
			Target.[Description] = Source.[Description],
			Target.[State_Id] = Source.[State_Id]
	WHEN NOT MATCHED BY TARGET THEN
		INSERT(Id, [Name], [Order], [Description], [State_Id]) 
		VALUES(Id, [Name], [Order], [Description], [State_Id])
	WHEN NOT MATCHED BY SOURCE THEN
	DELETE;
	--GO

	PRINT 'Import was successful from SP.[Seniority]'
END
GO



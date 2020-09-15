USE [EPAS]
GO

/****** Object:  StoredProcedure [Import].[SeniorityLoad]    Script Date: 16.07.2020 17:56:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_PAKPILoad]
AS
BEGIN

	DECLARE @DefaultString nvarchar(255) = 'merging';
	
	WITH Source AS (
		SELECT [Id]
			,[Name]
			,[Type_Id] 
			,[Order]
			,[Description]
		FROM [EP].[PA].[KPI])
	
	MERGE INTO [PA].[KPI] AS Target
	USING Source
	ON Target.Id = Source.Id
	WHEN MATCHED AND (
		Target.[Name] <> Source.[Name] 
		OR Target.[Type_Id] <> Source.[Type_Id] 
		OR Target.[Order] <> Source.[Order]
		OR ISNULL(Target.[Description], @DefaultString) <> ISNULL(Source.[Description], @DefaultString) 
	
	) THEN
		UPDATE SET
			Target.[Name] = Source.[Name],
			Target.[Type_Id] = Source.[Type_Id],
			Target.[Order] = Source.[Order],
			Target.[Description] = Source.[Description]
			
	WHEN NOT MATCHED BY TARGET THEN
		INSERT(Id, [Name], [Type_Id], [Order], [Description]) 
		VALUES(Id, [Name],[Type_Id], [Order], [Description])
	WHEN NOT MATCHED BY SOURCE THEN
	DELETE;
	--GO
	PRINT 'Import was successful from PA.[KPI]'
END
GO



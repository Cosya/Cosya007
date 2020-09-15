USE [EPAS]
GO

/****** Object:  StoredProcedure [Import].[StateLoad]    Script Date: 16.07.2020 16:34:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE dbo.[usp_SPStateLoad]
AS
BEGIN

	DECLARE @DefaultString nvarchar(255) = 'merging';

	WITH Source AS (
		SELECT [Id]
			,[Value]
			,[Description]

		FROM [EP].[SP].[State])
	
	MERGE INTO [SP].[State] AS Target
	USING Source
	ON Target.Id = Source.Id
	WHEN MATCHED AND (
		Target.[Value] <> Source.[Value]
		OR ISNULL(Target.[Description], '') <> ISNULL(Source.[Description], '') 
	) THEN
		UPDATE SET
			Target.[Value] = Source.[Value],
			Target.[Description] = Source.[Description]
	WHEN NOT MATCHED BY TARGET THEN
		INSERT(Id, [Value], [Description]) 
		VALUES(Id, [Value], [Description])
	WHEN NOT MATCHED BY SOURCE THEN
	DELETE;
	--GO

	PRINT 'Import was successful from SP.[State]'
END
GO

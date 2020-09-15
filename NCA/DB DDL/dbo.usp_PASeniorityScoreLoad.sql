USE [EPAS]
GO

/****** Object:  StoredProcedure [Import].[SeniorityLoad]    Script Date: 16.07.2020 17:56:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[usp_PASeniorityScoreLoad]
AS
BEGIN

	DECLARE @DefaultString nvarchar(255) = 'merging';
	
	WITH Source AS (
		SELECT 
			[Seniority_Id],
			[Value]
		FROM [EP].[PA].[SeniorityScore])
	
	MERGE INTO [PA].[SeniorityScore] AS Target
	USING Source
	ON Target.Seniority_Id = Source.Seniority_Id
	WHEN MATCHED AND (
		Target.[Value] <> Source.[Value] 
	) THEN
		UPDATE SET
			Target.[Value] = Source.[Value] 
	WHEN NOT MATCHED BY TARGET THEN
		INSERT([Seniority_Id], [Value]) 
		VALUES([Seniority_Id], [Value])
	WHEN NOT MATCHED BY SOURCE THEN
	DELETE;
	--GO

	PRINT 'Import was successful from SP.[SeniorityScore]'
END
GO



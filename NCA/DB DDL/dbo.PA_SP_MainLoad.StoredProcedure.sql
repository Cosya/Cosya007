USE [EPAS]
GO
/****** Object:  StoredProcedure [dbo].[PA_SP_MainLoad]    Script Date: 15.09.2020 18:37:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
ALTER PROCEDURE [dbo].[PA_SP_MainLoad]
AS
BEGIN
	DECLARE @ImportId int
	DECLARE @ImportResult nvarchar(MAX)

	INSERT INTO [dbo].[ImportResult] (Start) VALUES(GETDATE())
	SET @ImportId = SCOPE_IDENTITY()

	EXEC sp_msforeachtable "ALTER TABLE ? NOCHECK CONSTRAINT all"

	BEGIN TRANSACTION;

	BEGIN TRY

		EXEC dbo.[usp_SPStateLoad]
		EXEC [dbo].[usp_SPSeniorityLoad]
		EXEC dbo.[usp_SPPersonLoad]
		EXEC [dbo].[usp_PASeniorityScoreLoad]
		EXEC dbo.usp_PARelationLoad
		EXEC dbo.usp_PAMarkLoad
		EXEC [dbo].[usp_PAKPITypeLoad]
		EXEC [dbo].[usp_PAKPILoad]
		EXEC [dbo].[usp_PAContextCategoryLoad]
		EXEC dbo.usp_PAGradeLoad
		EXEC dbo.usp_PAContextLoad
		EXEC dbo.usp_PAEvaluationPeerLoad
		EXEC dbo.usp_PAContextStateLoad
		EXEC dbo.usp_PAEPFeedbackLoad
		EXEC [dbo].[usp_SPAssignmentLoad]
		EXEC [dbo].[usp_dboCalendarLoad]

		SET @ImportResult = 'Import Complete'
	END TRY
	BEGIN CATCH
		
		SELECT @ImportResult = ERROR_MESSAGE()

		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
	END CATCH

	IF @@TRANCOUNT > 0
		COMMIT TRANSACTION;

	UPDATE dbo.[ImportResult] SET CommentError = @ImportResult, [End] = GETDATE()  WHERE Id = @ImportId
	PRINT(@ImportResult)

EXEC sp_msforeachtable "ALTER TABLE ? WITH CHECK CHECK CONSTRAINT all"

END
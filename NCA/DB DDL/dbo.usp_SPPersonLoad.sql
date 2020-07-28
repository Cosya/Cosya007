USE [EPAS_DEV3]
GO
/****** Object:  StoredProcedure [Import].[PersonLoad]    Script Date: 16.07.2020 18:37:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE dbo.usp_SPPersonLoad
AS
BEGIN

	DECLARE @EmptyGuid UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000000';
	DECLARE @DateMax DATE = CAST('9999-12-31' AS DATE);
	DECLARE @DefaultString nvarchar(255) = 'merging';
	DECLARE @DefaultTinyInt tinyint = 0;
	DECLARE @DefaultVarBinary varbinary = 0;
	DECLARE @DefaultBit bit = 1;

	WITH Source AS (
		SELECT [Id]
			,[Name]
			,[Dummy]
			,[Location_Id]
			,[Department_Id]
			,[Seniority_Id]
			,[Occupation_Id]
			,[Specialization_Id]
			,[HourlyPayType_Id]
			,[StaffType_Id]
			,[PartnerCompany_Id]
			,[MaternityLeave]
			,[EvaluationFrequency]  
			,[State_Id]
			,[LDAPSamAccountName]
			,[LDAPDisplayName]
			,[LDAPCN]
			,[LDAPSID]
			,[LDAPEmail]
			,[Execution]
			,[ProbationDuration]
			,[LDAPPhoto]
			,[StartDate]
			,[FinishDate]
			,[RelationshipWithInfopulse_Id]
			,[RelationshipWithPartner_Id]
			,[CompensationPackage]
			,[FirstNameUa]
			,[PatronymicNameUa]
			,[LastNameUa]
			,[LastName]
			,[FirstName]
			,[Birthday]
			,[Sex]
			,[EVRYAccount]
			,[EVRYID]

		FROM [ESD].[SP].[Person])
	
	MERGE INTO [SP].[Person] AS Target
	USING Source
	ON Target.Id = Source.Id
	WHEN MATCHED AND (
		Target.Name <> Source.Name
		OR Target.[Dummy] <> Source.[Dummy]
		OR Target.[Location_Id] <> Source.[Location_Id]
		OR Target.[Department_Id] <> Source.[Department_Id]
		OR Target.[Seniority_Id] <> Source.[Seniority_Id]
		OR Target.[Occupation_Id] <> Source.[Occupation_Id]
		OR ISNULL(Target.[Specialization_Id], @EmptyGuid) <> ISNULL(Source.[Specialization_Id], @EmptyGuid)
		OR Target.[HourlyPayType_Id] <> Source.[HourlyPayType_Id]
		OR Target.[StaffType_Id] <> Source.[StaffType_Id]
		OR ISNULL(Target.[PartnerCompany_Id], @EmptyGuid) <> ISNULL(Source.[PartnerCompany_Id], @EmptyGuid)
		OR Target.[MaternityLeave] <> Source.[MaternityLeave]
		OR ISNULL(Target.[EvaluationFrequency], @DefaultTinyInt) <> ISNULL(Source.[EvaluationFrequency], @DefaultTinyInt)
		OR Target.[State_Id] <> Source.[State_Id]
		OR Target.[LDAPSamAccountName] <> Source.[LDAPSamAccountName]
		OR Target.[LDAPDisplayName] <> Source.[LDAPDisplayName]
		OR Target.[LDAPCN] <> Source.[LDAPCN]
		OR Target.[LDAPSID] <> Source.[LDAPSID]
		OR Target.[LDAPEmail] <> Source.[LDAPEmail]
		OR ISNULL(Target.[Execution], @DateMax) <> ISNULL(Source.[Execution], @DateMax)
		OR ISNULL(Target.[ProbationDuration], @DefaultTinyInt) <> ISNULL(Source.[ProbationDuration], @DefaultTinyInt)
		OR ISNULL(Target.[LDAPPhoto], @DefaultVarBinary) <> ISNULL(Source.[LDAPPhoto], @DefaultVarBinary)
		OR ISNULL(Target.[StartDate], @DateMax) <> ISNULL(Source.[StartDate], @DateMax)
		OR ISNULL(Target.[FinishDate], @DateMax) <> ISNULL(Source.[FinishDate], @DateMax)
		OR ISNULL(Target.[RelationShipWithInfopulse_Id], @EmptyGuid) <> ISNULL(Source.[RelationShipWithInfopulse_Id], @EmptyGuid)
		OR ISNULL(Target.[RelationShipWithPartner_Id], @EmptyGuid) <> ISNULL(Source.[RelationShipWithPartner_Id], @EmptyGuid)
		OR ISNULL(Target.[CompensationPackage], @DefaultBit) <> ISNULL(Source.[CompensationPackage], @DefaultBit)
		OR ISNULL(Target.[FirstNameUa], @DefaultString) <> ISNULL(Source.[FirstNameUa], @DefaultString)
		OR ISNULL(Target.[PatronymicNameUa], @DefaultString) <> ISNULL(Source.[PatronymicNameUa], @DefaultString)
		OR ISNULL(Target.[LastNameUa], @DefaultString) <> ISNULL(Source.[LastNameUa], @DefaultString)
		OR ISNULL(Target.[LastName], @DefaultString) <> ISNULL(Source.[LastName], @DefaultString)
		OR ISNULL(Target.[FirstName], @DefaultString) <> ISNULL(Source.[FirstName], @DefaultString)
		OR ISNULL(Target.[BirthDay], @DateMax) <> ISNULL(Source.[BirthDay], @DateMax)
		OR ISNULL(Target.[Sex], @DefaultString) <> ISNULL(Source.[Sex], @DefaultString)
		OR ISNULL(Target.[EVRYAccount], @DateMax) <> ISNULL(Source.[EVRYAccount], @DateMax)
		OR ISNULL(Target.[EVRYId], @DateMax) <> ISNULL(Source.[EVRYId], @DateMax)
	) THEN
		UPDATE SET
			Target.Name = Source.Name,
			Target.[Dummy] = Source.[Dummy],
			Target.[Location_Id] = Source.[Location_Id],
			Target.[Department_Id] = Source.[Department_Id],
			Target.[Seniority_Id] = Source.[Seniority_Id],
			Target.[Occupation_Id] = Source.[Occupation_Id],
			Target.[Specialization_Id] = Source.[Specialization_Id],
			Target.[HourlyPayType_Id] = Source.[HourlyPayType_Id],
			Target.[StaffType_Id] = Source.[StaffType_Id],
			Target.[PartnerCompany_Id] = Source.[PartnerCompany_Id],
			Target.[MaternityLeave] = Source.[MaternityLeave],
			Target.[EvaluationFrequency] = Source.[EvaluationFrequency],
			Target.[State_Id] = Source.[State_Id],
			Target.[LDAPSamAccountName] = Source.[LDAPSamAccountName],
			Target.[LDAPDisplayName] = Source.[LDAPDisplayName],
			Target.[LDAPCN] = Source.[LDAPCN],
			Target.[LDAPSID] = Source.[LDAPSID],
			Target.[LDAPEmail] = Source.[LDAPEmail],
			Target.[Execution] = Source.[Execution],
			Target.[ProbationDuration] = Source.[ProbationDuration],
			Target.[LDAPPhoto] = Source.[LDAPPhoto],
			Target.[StartDate] = Source.[StartDate],
			Target.[FinishDate] = Source.[FinishDate],
			Target.[RelationshipWithInfopulse_Id] = Source.[RelationshipWithInfopulse_Id],
			Target.[RelationshipWithPartner_Id] = Source.[RelationshipWithPartner_Id],
			Target.[CompensationPackage] = Source.[CompensationPackage],
			Target.[FirstNameUa] = Source.[FirstNameUa],
			Target.[PatronymicNameUa] = Source.[PatronymicNameUa],
			Target.[LastNameUa] = Source.[LastNameUa],
			Target.[LastName] = Source.[LastName],
			Target.[FirstName] = Source.[FirstName],
			Target.[Birthday] = Source.[Birthday],
			Target.[Sex] = Source.[Sex],
			Target.[EVRYAccount] = Source.[EVRYAccount],
			Target.[EVRYID] = Source.[EVRYID]
	WHEN NOT MATCHED BY TARGET THEN
		INSERT(Id, Name, [Dummy], [Location_Id], [Department_Id], [Seniority_Id], [Occupation_Id], [Specialization_Id], [HourlyPayType_Id], [StaffType_Id], [PartnerCompany_Id], [MaternityLeave], [EvaluationFrequency], [State_Id], [LDAPSamAccountName], [LDAPDisplayName], [LDAPCN], [LDAPSID], [LDAPEmail], [Execution], [ProbationDuration], [LDAPPhoto], [StartDate], [FinishDate], [RelationshipWithInfopulse_Id], [RelationshipWithPartner_Id], [CompensationPackage], [FirstNameUa], [PatronymicNameUa], [LastNameUa], [LastName], [FirstName], [Birthday], [Sex], [EVRYAccount], [EVRYID]) 
		VALUES(Id, Name, [Dummy], [Location_Id], [Department_Id], [Seniority_Id], [Occupation_Id], [Specialization_Id], [HourlyPayType_Id], [StaffType_Id], [PartnerCompany_Id], [MaternityLeave], [EvaluationFrequency], [State_Id], [LDAPSamAccountName], [LDAPDisplayName], [LDAPCN], [LDAPSID], [LDAPEmail], [Execution], [ProbationDuration], [LDAPPhoto], [StartDate], [FinishDate], [RelationshipWithInfopulse_Id], [RelationshipWithPartner_Id], [CompensationPackage], [FirstNameUa], [PatronymicNameUa], [LastNameUa], [LastName], [FirstName], [Birthday], [Sex], [EVRYAccount], [EVRYID])
	WHEN NOT MATCHED BY SOURCE THEN
	DELETE;
	--GO

	PRINT 'Import was successful from SP.[Person]'
END
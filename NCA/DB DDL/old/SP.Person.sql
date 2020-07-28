USE [EPAS_DEV]
GO

/****** Object:  Table [SP].[Person]    Script Date: 16.07.2020 15:26:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [SP].[Person](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](512) NOT NULL,
	[Dummy] [bit] NOT NULL,
	[Location_Id] [uniqueidentifier] NOT NULL,
	[Department_Id] [uniqueidentifier] NOT NULL,
	[Seniority_Id] [uniqueidentifier] NOT NULL,
	[Occupation_Id] [uniqueidentifier] NOT NULL,
	[Specialization_Id] [uniqueidentifier] NULL,
	[HourlyPayType_Id] [uniqueidentifier] NOT NULL,
	[StaffType_Id] [uniqueidentifier] NOT NULL,
	[PartnerCompany_Id] [uniqueidentifier] NULL,
	[MaternityLeave] [bit] NOT NULL,
	[EvaluationFrequency] [tinyint] NULL,
	[State_Id] [uniqueidentifier] NOT NULL,
	[LDAPSamAccountName] [nvarchar](512) NOT NULL,
	[LDAPDisplayName] [nvarchar](512) NOT NULL,
	[LDAPCN] [nvarchar](512) NOT NULL,
	[LDAPSID] [nvarchar](max) NOT NULL,
	[LDAPEmail] [nvarchar](512) NOT NULL,
	[Execution] [datetime] NULL,
	[ProbationDuration] [tinyint] NULL,
	[LDAPPhoto] [varbinary](max) NULL,
	[StartDate] [date] NULL,
	[FinishDate] [date] NULL,
	[RelationshipWithInfopulse_Id] [uniqueidentifier] NULL,
	[RelationshipWithPartner_Id] [uniqueidentifier] NULL,
	[CompensationPackage] [bit] NULL,
	[FirstNameUa] [nvarchar](50) NULL,
	[PatronymicNameUa] [nvarchar](50) NULL,
	[LastNameUa] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[FirstName] [nvarchar](50) NULL,
	[Birthday] [date] NULL,
	[Sex] [nvarchar](50) NULL,
	[PhotoUrl]  AS (('https://ihome/Topics/Resources/Team_200_200/'+replace([LDAPDisplayName],' ','.'))+'.jpg'),
	[EVRYAccount] [nvarchar](255) NULL,
	[EVRYID] [nvarchar](255) NULL,
 CONSTRAINT [Person_PK] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [SP].[Person]  WITH CHECK ADD  CONSTRAINT [Person_Seniority_FK] FOREIGN KEY([Seniority_Id])
REFERENCES [SP].[Seniority] ([Id])
GO

ALTER TABLE [SP].[Person] CHECK CONSTRAINT [Person_Seniority_FK]
GO


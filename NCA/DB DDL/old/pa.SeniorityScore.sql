USE [EPAS_DEV]
GO

/****** Object:  Table [PA].[SeniorityScore]    Script Date: 15.07.2020 13:52:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [PA].[SeniorityScore](
	[Seniority_Id] [uniqueidentifier] NOT NULL,
	[Value] [tinyint] NOT NULL,
 CONSTRAINT [PK_SeniorityScore] PRIMARY KEY CLUSTERED 
(
	[Seniority_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [PA].[SeniorityScore]  WITH CHECK ADD  CONSTRAINT [FK_SeniorityScore_Seniority] FOREIGN KEY([Seniority_Id])
REFERENCES [SP].[Seniority] ([Id])
GO

ALTER TABLE [PA].[SeniorityScore] CHECK CONSTRAINT [FK_SeniorityScore_Seniority]
GO



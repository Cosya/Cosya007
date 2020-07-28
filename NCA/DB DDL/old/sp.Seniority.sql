USE [EPAS_DEV]
GO

/****** Object:  Table [SP].[Seniority]    Script Date: 15.07.2020 13:54:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [SP].[Seniority](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](32) NOT NULL,
	[Order] [tinyint] NOT NULL,
	[Description] [nvarchar](255) NULL,
	[State_Id] [uniqueidentifier] NOT NULL,
 CONSTRAINT [Seniority_PK] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [SP].[Seniority]  WITH CHECK ADD  CONSTRAINT [Seniority_State_FK] FOREIGN KEY([State_Id])
REFERENCES [SP].[State] ([Id])
GO

ALTER TABLE [SP].[Seniority] CHECK CONSTRAINT [Seniority_State_FK]
GO



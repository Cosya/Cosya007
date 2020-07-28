USE [EPAS_DEV]
GO

/****** Object:  Table [PA].[Grade]    Script Date: 16.07.2020 12:47:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [PA].[Grade](
	[Id] [uniqueidentifier] NOT NULL,
	[KPI_Id] [uniqueidentifier] NOT NULL,
	[Mark_Id] [uniqueidentifier] NULL,
	[Value] [int] NULL,
	[Description] [nvarchar](max) NULL,
	[ContextCategory_Id] [uniqueidentifier] NOT NULL,
 CONSTRAINT [Grade_PK] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [PA].[Grade] ADD  DEFAULT (newid()) FOR [ContextCategory_Id]
GO

ALTER TABLE [PA].[Grade]  WITH CHECK ADD  CONSTRAINT [Grade_ContextCategory_FK] FOREIGN KEY([ContextCategory_Id])
REFERENCES [PA].[ContextCategory] ([Id])
GO

ALTER TABLE [PA].[Grade] CHECK CONSTRAINT [Grade_ContextCategory_FK]
GO

ALTER TABLE [PA].[Grade]  WITH CHECK ADD  CONSTRAINT [Grade_KPI_FK] FOREIGN KEY([KPI_Id])
REFERENCES [PA].[KPI] ([Id])
GO

ALTER TABLE [PA].[Grade] CHECK CONSTRAINT [Grade_KPI_FK]
GO

ALTER TABLE [PA].[Grade]  WITH CHECK ADD  CONSTRAINT [Grade_Mark_FK] FOREIGN KEY([Mark_Id])
REFERENCES [PA].[Mark] ([Id])
GO

ALTER TABLE [PA].[Grade] CHECK CONSTRAINT [Grade_Mark_FK]
GO



USE [EPAS_DEV]
GO

/****** Object:  Table [PA].[ContextCategory]    Script Date: 16.07.2020 12:49:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [PA].[ContextCategory](
	[Id] [uniqueidentifier] NOT NULL,
	[Value] [tinyint] NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
 CONSTRAINT [Context_Category_PK] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO



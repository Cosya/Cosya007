USE [EPAS_DEV]
GO

/****** Object:  Table [PA].[Relation]    Script Date: 16.07.2020 15:25:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [PA].[Relation](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](32) NOT NULL,
	[ProcessOrder] [tinyint] NOT NULL,
	[Description] [nvarchar](max) NULL,
 CONSTRAINT [Relation_PK] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO



USE [EPAS_DEV]
GO

/****** Object:  Table [dbo].[t_short_grades]    Script Date: 05.08.2020 12:05:08 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[t_short_grades](
	[Long_Grade] [nvarchar](255) NOT NULL,
	[Short_Grade] [nvarchar](255) NOT NULL,
	[Grade] [nvarchar](50) NOT NULL,
	[Specialization] [nvarchar](50) NOT NULL,
	[Grade_Type] [nvarchar](50) NOT NULL,
	[Short_Role] [nvarchar](50) NULL,
 CONSTRAINT [PK_t_short_grades] PRIMARY KEY CLUSTERED 
(
	[Long_Grade] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO



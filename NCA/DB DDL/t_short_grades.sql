USE [EPAS]
GO

/****** Object:  Table [dbo].[t_short_grades]    Script Date: 6/2/2020 11:20:29 AM ******/
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
 CONSTRAINT [PK_t_short_grades] PRIMARY KEY CLUSTERED 
(
	[Long_Grade] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO



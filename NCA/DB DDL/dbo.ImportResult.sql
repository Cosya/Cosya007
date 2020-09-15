USE [EPAS]
GO

/****** Object:  Table [Import].[ImportResult]    Script Date: 17.07.2020 14:25:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ImportResult](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Start] [datetime] NOT NULL,
	[End] [datetime] NULL,
	[CommentError] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO



USE [EPAS]
GO

/****** Object:  Table [PA].[EPFeedback]    Script Date: 17.07.2020 13:21:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [PA].[EPFeedback](
	[Id] [uniqueidentifier] NOT NULL,
	[EP_Id] [uniqueidentifier] NOT NULL,
	[Grade_Id] [uniqueidentifier] NOT NULL,
	[Comment] [nvarchar](max) NULL,
 CONSTRAINT [EPFeedback_PK] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO





USE [EPAS]
GO
/****** Object:  Table [SP].[State]    Script Date: 15.09.2020 9:15:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SP].[State](
	[Id] [uniqueidentifier] NOT NULL,
	[Value] [smallint] NOT NULL,
	[Description] [nvarchar](255) NULL,
 CONSTRAINT [State_PK] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

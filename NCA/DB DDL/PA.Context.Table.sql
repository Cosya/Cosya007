USE [EPAS]
GO
/****** Object:  Table [PA].[Context]    Script Date: 15.09.2020 9:15:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PA].[Context](
	[Id] [uniqueidentifier] NOT NULL,
	[Period] [date] NOT NULL,
	[Type_Id] [uniqueidentifier] NOT NULL,
	[State_Id] [uniqueidentifier] NOT NULL,
	[OverallScore] [real] NULL,
	[DateUpdated] [datetime] NOT NULL,
	[UnderDiscussionCount] [int] NOT NULL,
	[ContextCategory_Id] [uniqueidentifier] NOT NULL,
	[Status_Id] [uniqueidentifier] NOT NULL,
 CONSTRAINT [Context_PK] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [PA].[Context] ADD  DEFAULT (getdate()) FOR [DateUpdated]
GO
ALTER TABLE [PA].[Context] ADD  DEFAULT ((0)) FOR [UnderDiscussionCount]
GO
ALTER TABLE [PA].[Context] ADD  DEFAULT (newid()) FOR [ContextCategory_Id]
GO
ALTER TABLE [PA].[Context] ADD  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [Status_Id]
GO

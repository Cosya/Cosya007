USE [EPAS_DEV]
GO

/****** Object:  Table [PA].[EvaluationPeer]    Script Date: 16.07.2020 12:51:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [PA].[EvaluationPeer](
	[Id] [uniqueidentifier] NOT NULL,
	[Context_Id] [uniqueidentifier] NOT NULL,
	[Person_Id] [uniqueidentifier] NOT NULL,
	[Relation_Id] [uniqueidentifier] NOT NULL,
	[State_Id] [uniqueidentifier] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[DateUpdated] [datetime] NOT NULL,
	[Status_Id] [uniqueidentifier] NOT NULL,
 CONSTRAINT [EvaluationPeer_PK] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [PA].[EvaluationPeer] ADD  DEFAULT (getdate()) FOR [DateCreated]
GO

ALTER TABLE [PA].[EvaluationPeer] ADD  DEFAULT (getdate()) FOR [DateUpdated]
GO

ALTER TABLE [PA].[EvaluationPeer] ADD  DEFAULT (newid()) FOR [Status_Id]
GO

ALTER TABLE [PA].[EvaluationPeer]  WITH CHECK ADD  CONSTRAINT [EvaluationPeer_Context_FK] FOREIGN KEY([Context_Id])
REFERENCES [PA].[Context] ([Id])
GO

ALTER TABLE [PA].[EvaluationPeer] CHECK CONSTRAINT [EvaluationPeer_Context_FK]
GO




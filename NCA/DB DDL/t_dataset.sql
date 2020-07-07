USE [EPAS_DEV]
GO

/****** Object:  Table [dbo].[t_dataset]    Script Date: 07.07.2020 12:25:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[t_dataset](
	[Dataset_ID] [uniqueidentifier] NOT NULL,
	[FileName] [nvarchar](256) NOT NULL,
	[Created_by] [nvarchar](256) NOT NULL,
	[Created_on] [datetime] NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[t_dataset] ADD  DEFAULT (CONVERT([nvarchar],user_name())) FOR [Created_by]
GO

ALTER TABLE [dbo].[t_dataset] ADD  DEFAULT (getdate()) FOR [Created_on]
GO



USE [EPAS]
GO

/****** Object:  Table [dbo].[t_manager_map]    Script Date: 23.06.2020 10:11:05 ******/
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



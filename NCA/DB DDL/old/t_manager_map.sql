USE [EPAS_DEV]
GO

/****** Object:  Table [dbo].[t_manager_map]    Script Date: 07.07.2020 12:26:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[t_manager_map](
	[ID] [uniqueidentifier] NOT NULL,
	[EffectiveMonthDate] [date] NOT NULL,
	[Full_Name] [nvarchar](255) NOT NULL,
	[Direct_Manager] [nvarchar](255) NULL,
	[Created_by] [nvarchar](256) NOT NULL,
	[Created_on] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[t_manager_map] ADD  DEFAULT (newid()) FOR [ID]
GO

ALTER TABLE [dbo].[t_manager_map] ADD  DEFAULT (CONVERT([nvarchar],user_name())) FOR [Created_by]
GO

ALTER TABLE [dbo].[t_manager_map] ADD  DEFAULT (getdate()) FOR [Created_on]
GO



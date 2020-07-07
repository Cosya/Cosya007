USE [EPAS_DEV]
GO

/****** Object:  Table [dbo].[t_log]    Script Date: 07.07.2020 12:26:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[t_log](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Source] [nvarchar](128) NULL,
	[params] [nvarchar](512) NULL,
	[SP_name] [nvarchar](256) NULL,
	[Target_table] [nvarchar](256) NULL,
	[Record_count] [nvarchar](128) NULL,
	[Comment] [nvarchar](4000) NULL,
	[Created_by] [nvarchar](256) NOT NULL,
	[Created_on] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[t_log] ADD  DEFAULT (CONVERT([nvarchar],user_name())) FOR [Created_by]
GO

ALTER TABLE [dbo].[t_log] ADD  DEFAULT (getdate()) FOR [Created_on]
GO



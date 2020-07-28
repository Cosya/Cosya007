<<<<<<< HEAD
USE [EPAS_DEV]
GO

/****** Object:  Table [dbo].[t_log]    Script Date: 07.07.2020 12:26:07 ******/
=======

USE [EPAS]
GO

/****** Object:  Table [dbo].[t_project_map]    Script Date: 16.06.2020 16:39:46 ******/
>>>>>>> f018c7e1dd3cdd2a50b44d1aa7468d0ec4c21ace
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

<<<<<<< HEAD
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

=======
CREATE TABLE [dbo].[t_log]
(
	"Id" int IDENTITY(1,1) ,
	"Source" NVARCHAR(128), --ssis or 
	"params" NVARCHAR(512),-- elt/postload/
	"SP_name" NVARCHAR(256),
	"Target_table" NVARCHAR(256),
	"Record_count"  NVARCHAR(128),
	"Comment" NVARCHAR(4000),
	"Created_by" NVARCHAR(256) DEFAULT  cast(CURRENT_USER as Nvarchar)  NOT NULL,
	"Created_on" datetime  DEFAULT current_timestamp NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)

WITH 
(
	PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)	ON [PRIMARY]
>>>>>>> f018c7e1dd3cdd2a50b44d1aa7468d0ec4c21ace


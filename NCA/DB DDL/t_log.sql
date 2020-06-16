
USE [EPAS]
GO

/****** Object:  Table [dbo].[t_project_map]    Script Date: 16.06.2020 16:39:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
DROP TABLE [dbo].[t_log];

CREATE TABLE [dbo].[t_log]
(
	"Id" uniqueidentifier NOT NULL,
	"Source" NVARCHAR(128), --ssis or 
	"params" NVARCHAR(512),-- elt/postload/
	"SP_name" NVARCHAR(256),
	"Target_table" NVARCHAR(256),
	"Record_count" BIGINT,
	"Comment" NVARCHAR(4000),
	"Created_by" NVARCHAR(256) DEFAULT  cast(CURRENT_USER as Nvarchar)  NOT NULL,
	"Created_on" datetime  DEFAULT current_timestamp NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)

WITH 
(
	PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
)	ON [PRIMARY]

GO
ALTER TABLE [dbo].[t_log] ADD  DEFAULT (newid()) FOR [ID]
GO

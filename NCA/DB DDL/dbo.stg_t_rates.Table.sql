USE [EPAS]
GO

/****** Object:  Table [dbo].[stg_t_s_report_excel]    Script Date: 10.08.2020 16:18:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[stg_t_rates](
	[Role]  [nvarchar](255) NULL ,
	[Short_Role]  [nvarchar](255) NULL,
	[Hr_Rate] [nvarchar](255) NULL,
	[Start_date] [nvarchar](255) NULL,
	[End_date] [nvarchar](255) NULL,
	[Created_by] [nvarchar](256) NOT NULL,
	[Created_on] [datetime] NOT NULL,
	[Status_id] [int] NOT NULL,
	[DatasetID] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[stg_t_rates] ADD  DEFAULT (CONVERT([nvarchar],user_name())) FOR [Created_by]
GO

ALTER TABLE [dbo].[stg_t_rates] ADD  DEFAULT (getdate()) FOR [Created_on]
GO

ALTER TABLE [dbo].[stg_t_rates] ADD  DEFAULT ((0)) FOR [Status_id]
GO




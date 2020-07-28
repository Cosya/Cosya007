USE [EPAS_DEV]
GO

/****** Object:  Table [dbo].[stg_t_s_report_excel]    Script Date: 07.07.2020 12:24:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[stg_t_s_report_excel](
	[Full_Name_UA] [nvarchar](255) NULL,
	[Full_Name] [nvarchar](255) NULL,
	[Relationship_IP] [nvarchar](255) NULL,
	[Relationship_Partner] [nvarchar](255) NULL,
	[Partner_Company] [nvarchar](255) NULL,
	[Department] [nvarchar](255) NULL,
	[Group_Leader] [nvarchar](255) NULL,
	[Project] [nvarchar](255) NULL,
	[Direct_Manager] [nvarchar](255) NULL,
	[Hourly_Pay_Type] [nvarchar](255) NULL,
	[Grade] [nvarchar](255) NULL,
	[Maternity_Leave] [nvarchar](255) NULL,
	[Compensation_Package_Group] [nvarchar](255) NULL,
	[Location] [nvarchar](255) NULL,
	[Staff_Type] [nvarchar](255) NULL,
	[Start_Date] [nvarchar](255) NULL,
	[Base] [nvarchar](255) NULL,
	[Currency] [nvarchar](255) NOT NULL,
	[Addon] [nvarchar](255) NULL,
	[Type_addon] [nvarchar](255) NULL,
	[Variable] [nvarchar](255) NULL,
	[Created_by] [nvarchar](256) NOT NULL,
	[Created_on] [datetime] NOT NULL,
	[Status_id] [int] NOT NULL,
	[DatasetID] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[stg_t_s_report_excel] ADD  DEFAULT (CONVERT([nvarchar],user_name())) FOR [Created_by]
GO

ALTER TABLE [dbo].[stg_t_s_report_excel] ADD  DEFAULT (getdate()) FOR [Created_on]
GO

ALTER TABLE [dbo].[stg_t_s_report_excel] ADD  DEFAULT ((0)) FOR [Status_id]
GO



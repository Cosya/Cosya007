USE [EPAS_DEV]
GO

/****** Object:  Table [dbo].[t_Excell_load_errors]    Script Date: 07.07.2020 12:25:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[t_Excell_load_errors](
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
	[DatasetID] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO



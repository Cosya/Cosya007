USE [EPAS]
GO

/****** Object:  Table [dbo].[t_s_report_excel]    Script Date: 07.06.2020 23:27:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
DROP TABLE [dbo].[t_report_excel];
CREATE TABLE [dbo].[t_report_excel]
	(
	[EffectiveMonthDate] [date] NULL,
	[Full_Name_UA] [nvarchar](255) NULL,
	[Full_Name] [nvarchar](255) NULL,
	[Relationship_IP] [nvarchar](255) NULL,
	[Relationship_Partner] [nvarchar](255) NULL,
	[Partner_Company] [nvarchar](255) NULL,
	[Department] [nvarchar](255) NULL,
	[Group_Leader] [nvarchar](255) NULL,
	[Project_id] UNIQUEIDENTIFIER NULL ,
	[Direct_Manager_id] UNIQUEIDENTIFIER NULL ,
	[Hourly_Pay_Type] [integer] NOT NULL,
	[Grade] [nvarchar](255) NULL,
	[Maternity_Leave] [nvarchar](255) NULL,
	[Compensation_Package_Group] [nvarchar](255) NULL,
	[Location] [nvarchar](255) NULL,
	[Staff_Type] [nvarchar](255) NULL,
	[Start_Date] [date] NULL,
	[Base] [money] NULL,
	[Currency] [nvarchar](255) NOT NULL,
	[Addon] [money] NULL,
	[Type_addon] [nvarchar](255) NULL,
	[Variable] [money] NULL,
	[TotalMoney]  [money],
	[ImportedDt] [datetime] NOT NULL,
	[Location_Short]  [nvarchar](255) NULL,
	[EffectiveYear] [nvarchar] (4),
	[MonthName]  [nvarchar] (50)
) ON [PRIMARY]
GO

--ALTER TABLE [dbo].[t_s_report_excel] ADD  CONSTRAINT [DF_t_s_report_excel_ImportedDt]  DEFAULT (getdate()) FOR [ImportedDt]
--GO



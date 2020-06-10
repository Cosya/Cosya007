USE [EPAS]
GO

/****** Object:  Table [dbo].[t_s_report_excel]    Script Date: 6/2/2020 11:20:08 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[t_s_report_excel](
	[EffectiveMonthDate] [date] NULL,
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
	[Start_Date] [date] NULL,
	[Base] [money] NULL,
	[Currency] [nvarchar](255) NOT NULL,
	[Addon] [money] NULL,
	[Type_addon] [nvarchar](255) NULL,
	[Variable] [money] NULL,
	[TotalMoney]  AS (([Base]+[Addon])+[Variable]),
	[ImportedDt] [datetime] NOT NULL,
	[Location_Short]  AS (case when substring([Location],(1),charindex(',',[Location]+',')-(1))='' then 'Remote' else substring([Location],(1),charindex(',',[Location]+',')-(1)) end),
	[EffectiveYear]  AS (datepart(year,[EffectiveMonthDate])),
	[MonthName]  AS (datename(month,[EffectiveMonthDate]))
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[t_s_report_excel] ADD  CONSTRAINT [DF_t_s_report_excel_ImportedDt]  DEFAULT (getdate()) FOR [ImportedDt]
GO



USE [EPAS]
GO

/****** Object:  Table [dbo].[t_subgrade_excel]    Script Date: 6/2/2020 11:20:44 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[t_subgrade_excel](
	[EffectiveMonthDate] [date] NULL,
	[Full_Name] [nvarchar](255) NULL,
	[SubGrade] [nvarchar](50) NULL,
	[ImportedDt] [datetime] NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[t_subgrade_excel] ADD  CONSTRAINT [DF_t_subgrade_excel_ImportedDt]  DEFAULT (getdate()) FOR [ImportedDt]
GO



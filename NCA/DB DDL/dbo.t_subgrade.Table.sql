USE [EPAS]
GO

/****** Object:  Table [dbo].[t_subgrade_excel]    Script Date: 21.07.2020 15:16:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[t_subgrade](
	[EffectiveMonthDate] [date] NOT NULL,
	[Full_Name] [nvarchar](255) NOT NULL,
	[OverallScore][Integer] NOT NULL,
	[AvgProductivityScore][integer] NOT NULL, 
	[SubGrade] [nvarchar](50) NOT NULL,
	[ImportedDt] [datetime] NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[t_subgrade] ADD  CONSTRAINT [DF_t_subgrade_ImportedDt]  DEFAULT (getdate()) FOR [ImportedDt]
GO



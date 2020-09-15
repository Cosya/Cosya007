USE [EPAS]
GO
/****** Object:  Table [dbo].[t_subgrade]    Script Date: 15.09.2020 9:15:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_subgrade](
	[EffectiveMonthDate] [date] NOT NULL,
	[Full_Name] [nvarchar](255) NOT NULL,
	[OverallScore] [int] NOT NULL,
	[AvgProductivityScore] [int] NOT NULL,
	[SubGrade] [nvarchar](50) NOT NULL,
	[ImportedDt] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[t_subgrade] ADD  CONSTRAINT [DF_t_subgrade_ImportedDt]  DEFAULT (getdate()) FOR [ImportedDt]
GO

USE [EPAS]
GO

/****** Object:  Table [dbo].[t_subgrade]    Script Date: 16.10.2020 16:30:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
DROP TABLE [dbo].[t_subgrade];
CREATE TABLE [dbo].[t_subgrade](
	[EffectiveMonthDate] [date] NOT NULL,
	[Full_Name] [nvarchar](255) NOT NULL,
	[OverallScore] [int]  NULL,
	[AvgProductivityScore] [int]  NULL,
	[SubGrade] [nvarchar](50) NOT NULL,
	[ImportedDt] [datetime] NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[t_subgrade] ADD  CONSTRAINT [DF_t_subgrade_ImportedDt]  DEFAULT (getdate()) FOR [ImportedDt]
GO



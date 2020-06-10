USE [EPAS]
GO

/****** Object:  Table [dbo].[t_s_report_excel]    Script Date: 04.06.2020 17:03:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[t_manager_map]
	(
		ID UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY,
		[EffectiveMonthDate] [date] NOT NULL,
		[Full_Name] [nvarchar](255) NOT NULL,
		[Direct_Manager] [nvarchar](255) NULL
	)
ON [PRIMARY]
 
GO




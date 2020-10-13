USE [EPAS]
GO

/****** Object:  Table [dbo].[t_rates_load_errors ]    Script Date: 01.10.2020 23:10:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[t_rates_load_errors ](
	[Role] [nvarchar](255) NULL,
	[Short_Role] [nvarchar](255) NULL,
	[Hr_Rate] [nvarchar](255) NULL,
	[Start_date] [nvarchar](255) NULL,
	[End_date] [nvarchar](255) NULL,
	[ScenarioName] [nvarchar](255) NULL,
	[DatasetID] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO



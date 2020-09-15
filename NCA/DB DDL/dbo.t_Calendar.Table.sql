USE [EPAS_DEV]
GO

/****** Object:  Table [dbo].[tDate]    Script Date: 10.09.2020 13:11:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[t_Calendar](
	[Date_data] [int] NOT NULL,
	[Year_data] [int] NOT NULL,
	[Quarter_data] [int] NOT NULL,
	[Month_data] [int] NOT NULL,
	[Week_data] [int] NOT NULL,
	[Day_of_Year_data] [int] NOT NULL,
	[Day_of_Month_data] [int] NOT NULL,
	[Weekday] [int] NOT NULL,
	[Date] [smalldatetime] NOT NULL,
	[Date_data_char] [char](20) NOT NULL,
	[Holiday] [char](10) NULL,
	[Workday] [char](10) NULL,
	[One] [int] NOT NULL,
	[MovedWeekend] [bit] NULL
) ON [PRIMARY]
GO



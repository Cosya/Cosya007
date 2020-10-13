USE [EPAS_DEV]
GO

/****** Object:  Table [dbo].[t_EP_Plan]    Script Date: 01.10.2020 23:51:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[t_EP_Plan](
	[ID] [uniqueidentifier] NOT NULL,
	[EP_ID] [uniqueidentifier] NOT NULL,
	[FullName] [nvarchar](256) NOT NULL,
	[EffectiveMonthDate] [date] NOT NULL,
	[EP_date] [date] NOT NULL,
	[Scenario_ID] [uniqueidentifier] NOT NULL,
	[Grade] [nvarchar](50) NOT NULL,
	[Base] [money] NULL,
	[Currency] [nvarchar](255) NOT NULL,
	[Addon] [money] NULL,
	[Variable] [money] NULL,
	[TotalMoney]  AS (([Base]+[Addon])+[Variable]),
	[Sourceflag] [int] NULL,
	[Created_by] [nvarchar](256) NOT NULL,
	[Created_on] [datetime] NOT NULL,
 CONSTRAINT [EP_Plan_PK] PRIMARY KEY CLUSTERED 
(
	[FullName] ASC,
	[EffectiveMonthDate] ASC,
	[Scenario_ID]

)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[t_EP_Plan] ADD  DEFAULT (newid()) FOR [ID]
GO

ALTER TABLE [dbo].[t_EP_Plan] ADD  DEFAULT (CONVERT([nvarchar],user_name())) FOR [Created_by]
GO

ALTER TABLE [dbo].[t_EP_Plan] ADD  DEFAULT (getdate()) FOR [Created_on]
GO



USE [EPAS]
GO
/****** Object:  Table [dbo].[t_EP_Plan]    Script Date: 15.09.2020 9:15:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_EP_Plan](
	[ID] [uniqueidentifier] NOT NULL,
	[FullName] [nvarchar](256) NOT NULL,
	[EffectiveMonthDate] [date] NOT NULL,
	[EP_date] [date] NOT NULL,
	[Scenario_ID] [uniqueidentifier] NOT NULL,
	[Grade] [nvarchar](50) NOT NULL,
	[Base] [money] NULL,
	[Currency] [nvarchar](255) NOT NULL,
	[Addon] [money] NULL,
	[Type_addon] [nvarchar](255) NULL,
	[Variable] [money] NULL,
	[TotalMoney]  AS (([Base]+[Addon])+[Variable]),
	[Created_by] [nvarchar](256) NOT NULL,
	[Created_on] [datetime] NOT NULL,
 CONSTRAINT [EP_Plan_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[t_EP_Plan] ADD  DEFAULT (CONVERT([nvarchar],user_name())) FOR [Created_by]
GO
ALTER TABLE [dbo].[t_EP_Plan] ADD  DEFAULT (getdate()) FOR [Created_on]
GO
ALTER TABLE [dbo].[t_EP_Plan]  WITH CHECK ADD  CONSTRAINT [EP_Plan_Scenario_FK] FOREIGN KEY([Scenario_ID])
REFERENCES [dbo].[t_scenario] ([ID])
GO
ALTER TABLE [dbo].[t_EP_Plan] CHECK CONSTRAINT [EP_Plan_Scenario_FK]
GO

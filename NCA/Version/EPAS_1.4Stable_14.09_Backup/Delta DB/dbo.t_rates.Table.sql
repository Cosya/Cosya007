USE [EPAS_DEV]
GO

/****** Object:  Table [dbo].[t_rates]    Script Date: 11.09.2020 14:17:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[t_rates](
	[ID] [uniqueidentifier] NOT NULL,
	[Role] [nvarchar](256) NOT NULL,
	[Short_Role] [nvarchar](50) NOT NULL,
	[Hr_Rate] [money] NOT NULL,
	[Start_date] [date] NOT NULL,
	[End_date] [date] NOT NULL,
	[Scenario_ID] [uniqueidentifier] NULL,
	[Created_by] [nvarchar](256) NOT NULL,
	[Created_on] [datetime] NOT NULL,
 CONSTRAINT [PK_Rates] PRIMARY KEY CLUSTERED 
(
	[Short_Role] ASC
	--,[Start_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[t_rates] ADD  DEFAULT (newid()) FOR [ID]
GO

ALTER TABLE [dbo].[t_rates] ADD  DEFAULT (CONVERT([nvarchar],user_name())) FOR [Created_by]
GO

ALTER TABLE [dbo].[t_rates] ADD  DEFAULT (getdate()) FOR [Created_on]
GO

ALTER TABLE [dbo].[t_rates]  WITH CHECK ADD  CONSTRAINT [Rates_Scenario_FK] FOREIGN KEY([Scenario_ID])
REFERENCES [dbo].[t_scenario] ([ID])
GO

ALTER TABLE [dbo].[t_rates] CHECK CONSTRAINT [Rates_Scenario_FK]
GO



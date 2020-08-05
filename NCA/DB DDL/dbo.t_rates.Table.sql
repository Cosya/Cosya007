USE [EPAS_DEV]
GO

/****** Object:  Table [dbo].[t_dataset]    Script Date: 29.07.2020 13:00:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[t_rates](
	[ID] [uniqueidentifier] NOT NULL,
	[RateName] [nvarchar](256) NOT NULL,
	[Hr_Rate] Money NOT NULL,
	[Scenario_ID] [uniqueidentifier] NOT NULL,
	[Created_by] [nvarchar](256) NOT NULL,
	[Created_on] [datetime] NOT NULL
 CONSTRAINT [Rates_PK] PRIMARY KEY CLUSTERED 
(
[Id] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[t_rates] ADD  DEFAULT (CONVERT([nvarchar],user_name())) FOR [Created_by]
GO

ALTER TABLE [dbo].[t_rates] ADD  DEFAULT (getdate()) FOR [Created_on]
GO


ALTER TABLE [dbo].[t_rates]  WITH CHECK ADD  CONSTRAINT [Rates_Scenario_FK] FOREIGN KEY([Scenario_ID])
REFERENCES [dbo].[t_Scenario] ([Id])
GO

ALTER TABLE [dbo].[t_rates] CHECK CONSTRAINT [Rates_Scenario_FK]
GO


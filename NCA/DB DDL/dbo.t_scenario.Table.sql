USE [EPAS]
GO

/****** Object:  Table [dbo].[t_dataset]    Script Date: 29.07.2020 13:00:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[t_scenario](
	[ID] [uniqueidentifier] NOT NULL,
	[ScenarioName] [nvarchar](256) NOT NULL,
	[Corporate_overhead] Money NOT NULL,
	[Hrs_count] [uniqueidentifier] NOT NULL,
	[Created_by] [nvarchar](256) NOT NULL,
	[Created_on] [datetime] NOT NULL
 CONSTRAINT [Scenario_PK] PRIMARY KEY CLUSTERED 
(
[Id] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[t_scenario] ADD  DEFAULT (CONVERT([nvarchar],user_name())) FOR [Created_by]
GO

ALTER TABLE [dbo].[t_scenario] ADD  DEFAULT (getdate()) FOR [Created_on]
GO


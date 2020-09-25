USE [EPAS_DEV]
GO

/****** Object:  Table [dbo].[t_scenario]    Script Date: 17.09.2020 9:41:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[t_scenario](
	[ID] [uniqueidentifier] NOT NULL,
	[ScenarioName] [nvarchar](256) NOT NULL,
	[Corporate_overhead] [money] NOT NULL,
	[Hrs_count] [integer] NOT NULL,
	[Created_by] [nvarchar](256) NOT NULL,
	[Created_on] [datetime] NOT NULL,
 CONSTRAINT [Scenario_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[t_scenario] ADD  DEFAULT (newid()) FOR [ID]
GO

ALTER TABLE [dbo].[t_scenario] ADD  DEFAULT (CONVERT([nvarchar],user_name())) FOR [Created_by]
GO

ALTER TABLE [dbo].[t_scenario] ADD  DEFAULT (getdate()) FOR [Created_on]
GO




/*

USE [EPAS_DEV]
GO

INSERT INTO [dbo].[t_scenario]
           (
           [ScenarioName]
           ,[Corporate_overhead]
           ,[Hrs_count]
       
		  )
Select 'Normal' as  [ScenarioName],
		0 as [Corporate_overhead],
		8 as [Hrs_count]

union all

Select 'Extended' as  [ScenarioName],
		0 as [Corporate_overhead],
		8 as [Hrs_count]


*/
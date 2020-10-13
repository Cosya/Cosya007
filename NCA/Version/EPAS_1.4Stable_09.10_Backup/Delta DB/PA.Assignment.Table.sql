USE [EPAS_DEV]
GO

/****** Object:  Table [dbo].[t_manager_map]    Script Date: 15.09.2020 11:56:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [SP].[Assignment](
					[ID][uniqueidentifier] NOT NULL,
					[Person_id] [uniqueidentifier] NOT NULL, 
					[Person] [nvarchar](512) NOT NULL,
					[Project_Id] [uniqueidentifier] NOT NULL,
					[Project] [nvarchar](256) NOT NULL,
					[role_id] [uniqueidentifier] NOT NULL,
					[role] [nvarchar](256) NOT NULL,
					[Manager_Id] [uniqueidentifier] NOT NULL,
					[Manager] [nvarchar](512) NOT NULL,
					[DateFrom] [date] NOT NULL,
					[DateTo] [date],
					[ContractPosition_Id] [uniqueidentifier] NOT NULL,
					[ContractPosition] [nvarchar](256) NOT NULL,
					[State_Id] [uniqueidentifier] NOT NULL

PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO



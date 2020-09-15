USE [EPAS]
GO
/****** Object:  Table [dbo].[FactSmallSales]    Script Date: 15.09.2020 9:15:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactSmallSales](
	[SalesOrderNumber] [nvarchar](20) NOT NULL,
	[SalesOrderLineNumber] [tinyint] NOT NULL,
	[ProductName] [nvarchar](250) NULL,
	[ProductSubcategoryName] [nvarchar](250) NULL,
	[CustomerName] [nvarchar](250) NULL,
	[SalesAmount] [money] NULL,
	[OrderDate] [date] NULL,
 CONSTRAINT [PK_FactSmallSales] PRIMARY KEY CLUSTERED 
(
	[SalesOrderNumber] ASC,
	[SalesOrderLineNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

USE [EPAS_DEV]
GO
/****** Object:  User [sa2]    Script Date: 16.07.2020 17:23:39 ******/
CREATE USER [sa2] FOR LOGIN [sa2] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [sa2]
GO

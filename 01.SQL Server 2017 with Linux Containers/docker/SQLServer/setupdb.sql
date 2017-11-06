USE [master]
GO
EXEC sp_configure 'contained database authentication', 1
RECONFIGURE
GO

DROP DATABASE IF EXISTS wordpress
GO

CREATE DATABASE wordpress 
GO


ALTER DATABASE [wordpress] SET CONTAINMENT = PARTIAL WITH NO_WAIT
GO
USE [wordpress]
GO
CREATE USER [wpadmin] WITH PASSWORD=N'<Password>'
GO
ALTER ROLE [db_owner] ADD MEMBER [wpadmin]
GO


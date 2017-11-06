USE [DemoDB]
GO

-- 初期化
ALTER DATABASE current SET QUERY_STORE CLEAR ALL
ALTER DATABASE current SET AUTOMATIC_TUNING ( FORCE_LAST_GOOD_PLAN = OFF)
GO

-- 設定
ALTER DATABASE CURRENT 
SET QUERY_STORE = ON
GO
ALTER DATABASE CURRENT 
SET QUERY_STORE (OPERATION_MODE = READ_WRITE, INTERVAL_LENGTH_MINUTES = 1)
GO
ALTER DATABASE CURRENT 
SET AUTOMATIC_TUNING ( FORCE_LAST_GOOD_PLAN = ON )
GO

SELECT * FROM sys.database_automatic_tuning_options
GO
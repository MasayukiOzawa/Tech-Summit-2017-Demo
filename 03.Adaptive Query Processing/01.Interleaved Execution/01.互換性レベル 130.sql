-- �݊������x�� 130 �͗\���s���͌Œ�s�����g�p����Ă���
USE [tpch]
GO

ALTER DATABASE CURRENT SET COMPATIBILITY_LEVEL = 130
GO

DBCC FREEPROCCACHE
GO
EXEC sp_executesql 
N'SELECT COUNT(*) FROM fn_MSTVF(@param1, @param2)',
N'@param1 date, @param2 date',
@param1 = '1997-06-18',
@param2 = '1997-06-20'
GO

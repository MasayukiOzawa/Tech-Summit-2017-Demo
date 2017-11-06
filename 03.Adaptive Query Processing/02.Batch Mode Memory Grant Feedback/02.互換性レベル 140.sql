USE [tpch]
GO
DBCC FREEPROCCACHE
GO
ALTER DATABASE [tpch] SET COMPATIBILITY_LEVEL = 140
GO

EXEC sp_executesql 
N'SELECT TOP 100 L_PARTKEY FROM LINEITEM WHERE L_SHIPDATE BETWEEN @param1 AND @param2 GROUP BY L_PARTKEY ORDER BY MAX(L_ORDERKEY) DESC', 
N'@param1 date, @param2 date',
@param1 = '1998-08-10',
@param2 = '1998-08-10'
GO

-- ����̃N�G���� 3 ����s���Ă��邪�A3 ��ڂ̎��s�Ŏ��s�v�����ɕω������� (���[�N�X�y�[�X�������[���œK������Ď��s�����)
EXEC sp_executesql 
N'SELECT TOP 100 L_PARTKEY FROM LINEITEM WHERE L_SHIPDATE BETWEEN @param1 AND @param2 GROUP BY L_PARTKEY ORDER BY MAX(L_ORDERKEY) DESC', 
N'@param1 date, @param2 date',
@param1 = '1998-01-01',
@param2 = '2001-12-31'
GO 3

SELECT plan_generation_num, execution_count 
FROM sys.dm_exec_query_stats WHERE query_hash = 0x30E5568A88D65317

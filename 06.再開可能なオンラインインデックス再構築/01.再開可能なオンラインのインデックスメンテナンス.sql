USE [tpch]
GO
ALTER INDEX [PK_LINEITEM] ON [dbo].[LINEITEM] REBUILD PARTITION = ALL 
WITH (ONLINE = ON, RESUMABLE = ON, MAX_DURATION = 10)
GO

-- ��~
USE [tpch]
GO
ALTER INDEX [PK_LINEITEM] ON [dbo].[LINEITEM] PAUSE 
GO

-- �L�����Z��
USE [tpch]
GO
ALTER INDEX [PK_LINEITEM] ON [dbo].[LINEITEM] ABORT
GO

-- �ĊJ
USE [tpch]
GO
ALTER INDEX [PK_LINEITEM] ON [dbo].[LINEITEM] RESUME 
WITH (MAXDOP=0, MAX_DURATION=1)
GO

-- �C���f�b�N�X�\�z��Ԃ̎擾
USE [tpch]
GO
SELECT * FROM tpch.sys.index_resumable_operations 
GO
CHECKPOINT
GO
SELECT * FROM LINEITEM  WHERE L_ORDERKEY = 57490087
UPDATE LINEITEM SET L_EXTENDEDPRICE = RAND()  WHERE L_ORDERKEY = 57490087

-- ���O�̎擾
SELECT 
OBJECT_NAME(ps.object_id) AS object_name,
Operation, Context, AllocUnitId, AllocUnitName, [Lock Information] ,au.type_desc
FROM sys.fn_dblog(NULL, NULL) AS fl
LEFT JOIN
sys.allocation_units AS au
ON
au.allocation_unit_id = fl.AllocUnitId
LEFT JOIN
sys.dm_db_partition_stats  AS ps
ON
ps.partition_id = au.container_id
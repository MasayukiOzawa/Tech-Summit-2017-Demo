-- �݊������x�� 140 �̏ꍇ�AMSTVF �̗\���s�����p�����[�^�[�ɍ��킹�čœK������Ă���
-- (MSTVF �̃e�[�u���X�L�����Ő���������肪���f�����悤�ɂȂ��Ă���)
-- ����ɂ��A�f�[�^���ɉ������K�؂Ȏ��s�v�����̑I�����s����悤�ɂȂ�
USE [tpch]
GO

ALTER DATABASE CURRENT SET COMPATIBILITY_LEVEL = 140
GO
DBCC FREEPROCCACHE
GO
EXEC sp_executesql 
N'SELECT COUNT(*) FROM fn_MSTVF(@param1, @param2)',
N'@param1 date, @param2 date',
@param1 = '1997-06-18',
@param2 = '1997-06-20'

GO
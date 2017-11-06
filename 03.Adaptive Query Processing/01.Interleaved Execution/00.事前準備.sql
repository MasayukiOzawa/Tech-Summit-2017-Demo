USE [tpch]
GO
-- Muti statement table value Function (MSTVFs) �Ŏg�p���邱�Ƃ��ł���

CREATE FUNCTION [dbo].[fn_MSTVF](@Start date, @End date)
RETURNS @tbl TABLE(
        L_ORDERKEY int,
        L_PARTKEY int,
        L_SUPPKEY int
)
AS
BEGIN
        INSERT INTO @tbl 
		SELECT L_ORDERKEY, L_PARTKEY, L_SUPPKEY 
		FROM LINEITEM WHERE L_SHIPDATE BETWEEN @start AND @end
        RETURN
END
GO

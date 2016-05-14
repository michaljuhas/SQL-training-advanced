# S03-L07 Using two indexes

// TODO

An OR using a single key is well optimized, as is the handling of AND.

The one tricky case is that of searching on two different keys combined with OR:

SELECT field1_index, field2_index FROM test_table
WHERE field1_index = '1' OR  field2_index = '1'
This case is optimized. See Section 9.2.1.4, “Index Merge Optimization”.

You can also solve the problem efficiently by using a UNION that combines the output of two separate SELECT statements. See Section 14.2.9.3, “UNION Syntax”.

Each SELECT searches only one key and can be optimized:

SELECT field1_index, field2_index
    FROM test_table WHERE field1_index = '1'
UNION
SELECT field1_index, field2_index
    FROM test_table WHERE field2_index = '1';

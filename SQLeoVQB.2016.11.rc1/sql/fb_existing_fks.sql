SELECT
     FK.RDB$CONSTRAINT_NAME AS FK_NAME,
     'INNER' AS JOIN_TYPE,
     '' AS OWNER,
     FK.RDB$RELATION_NAME AS TABLE_NAME,
     ISF.RDB$FIELD_NAME AS COLUMN_NAME,
     '' AS PKTABLE_OWNER,
     PK.RDB$RELATION_NAME AS PKTABLE_NAME,
     '' AS PKTABLE_ALIAS,
     ISP.RDB$FIELD_NAME AS PKCOLUMN_NAME,
     PK.RDB$CONSTRAINT_NAME AS PK_NAME
FROM
     RDB$REF_CONSTRAINTS RC INNER JOIN RDB$RELATION_CONSTRAINTS FK ON RC.RDB$CONSTRAINT_NAME = FK.RDB$CONSTRAINT_NAME
     INNER JOIN RDB$RELATION_CONSTRAINTS PK ON RC.RDB$CONST_NAME_UQ = PK.RDB$CONSTRAINT_NAME
     INNER JOIN RDB$INDEX_SEGMENTS ISP ON PK.RDB$INDEX_NAME = ISP.RDB$INDEX_NAME
     INNER JOIN RDB$INDEX_SEGMENTS ISF ON ISP.RDB$FIELD_POSITION = ISF.RDB$FIELD_POSITION
     AND FK.RDB$INDEX_NAME = ISF.RDB$INDEX_NAME
ORDER BY
     FK.RDB$RELATION_NAME ASC
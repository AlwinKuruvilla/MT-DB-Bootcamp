SELECT TABLE_NAME FROM INFORMATION_SCHEMA.COLUMNS;
SELECT CONCAT('CREATE TABLE', ' ', TABLE_NAME, ' (', COLUMN_NAME, ' ', DATA_TYPE) FROM INFORMATION_SCHEMA.COLUMNS

SELECT CONCAT('CREATE TABLE', ' ', TABLE_NAME) FROM INFORMATION_SCHEMA.COLUMNS WHE
UNION ALL
SELECT DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS
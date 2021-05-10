EXEC sp_msforeachtable "ALTER TABLE? NOCHECK CONSTRAINT all"
Declare @sql NVARCHAR(max)=''
Select @sql += 'Drop Table' +
QUOTENAME(TABLE_SCHEMA) + '.' +
QUOTENAME(TABLE_NAME)+ ';'
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'

Exec SP_executesql @sql
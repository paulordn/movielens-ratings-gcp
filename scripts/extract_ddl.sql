-- Extrai o DDL de todas as tabelas e views dos datasets do projeto.
-- Rode no console do BigQuery e salve o resultado como CSV
-- (Salvar resultados > CSV (arquivo local)) com o nome ddl_export.csv
-- dentro da pasta do projeto. O arquivo é ignorado pelo Git.

SELECT table_schema, table_name, table_type, ddl
FROM `netflix_raw`.INFORMATION_SCHEMA.TABLES

UNION ALL

SELECT table_schema, table_name, table_type, ddl
FROM `netflix_analytical`.INFORMATION_SCHEMA.TABLES

ORDER BY table_schema, table_type, table_name;

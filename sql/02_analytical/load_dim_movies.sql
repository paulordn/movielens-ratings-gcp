-- =====================================================
-- 1) DIM TABLE: dim_movies
-- Carga a partir de netflix_raw.raw_movies (colunas STRING).
-- O ano de lançamento é extraído do final do título, ex.: "Toy Story (1995)".
-- =====================================================

CREATE OR REPLACE TABLE `seu-projeto-gcp.netflix_analytical.dim_movies` AS
SELECT
  SAFE_CAST(movieID AS INT64) AS movie_id,
  CAST(title AS STRING) AS title,
  CAST(genres AS STRING) AS genres,
  SAFE_CAST(REGEXP_EXTRACT(CAST(title AS STRING), r'\((\d{4})\)\s*$') AS INT64) AS realease_year
FROM `seu-projeto-gcp.netflix_raw.raw_movies`;

CREATE VIEW `seu-projeto-gcp.netflix_analytical.vw_ratings_heatmap`
AS SELECT 
  EXTRACT(YEAR FROM rating_ts) as year,
  EXTRACT(MONTH FROM rating_ts) as month_number,
  FORMAT_TIMESTAMP('%b', rating_ts) as month_name,
  COUNT(*) AS total_ratings
FROM `seu-projeto-gcp.netflix_analytical.fact_ratings`
GROUP BY year, month_number, month_name
ORDER BY year, month_number, month_name;

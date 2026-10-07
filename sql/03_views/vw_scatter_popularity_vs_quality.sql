CREATE VIEW `seu-projeto-gcp.netflix_analytical.vw_scatter_popularity_vs_quality`
AS SELECT
  movie_id,
  title,
  genres,
  realease_year,
  total_ratings,
  avg_rating
FROM `seu-projeto-gcp.netflix_analytical.vw_movies_kpis`
WHERE total_ratings >= 50;

CREATE VIEW `seu-projeto-gcp.netflix_analytical.vw_top_movies`
AS SELECT 
  movie_id,
  title,
  genres,
  realease_year,
  total_ratings,
  ROUND(avg_rating,2) as avg_rating
FROM `seu-projeto-gcp.netflix_analytical.vw_movies_kpis`
WHERE total_ratings >= 20
and avg_rating BETWEEN 0 AND 5
ORDER BY avg_rating DESC, total_ratings DESC
LIMIT 10;

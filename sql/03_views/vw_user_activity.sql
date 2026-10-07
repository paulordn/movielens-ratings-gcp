CREATE VIEW `seu-projeto-gcp.netflix_analytical.vw_user_activity`
AS SELECT 
  user_id,
  COUNT(*) AS total_ratings,
  COUNT(DISTINCT movie_id) AS distinct_movies,
  AVG(rating) AS avg_rating,
  STDDEV(rating) as std_rating,
  MIN(rating_ts) as first_activity_ts,
  MAX(rating_ts) as last_activity_ts
FROM `seu-projeto-gcp.netflix_analytical.fact_ratings`
GROUP BY 1 
ORDER BY total_ratings DESC, avg_rating DESC;

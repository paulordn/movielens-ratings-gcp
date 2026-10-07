CREATE VIEW `seu-projeto-gcp.netflix_analytical.vw_movies_kpis`
AS SELECT 
  r.movie_id,
  m.title,
  m.genres,
  m.realease_year,
  COUNT(*) AS total_ratings,
  AVG(r.rating) as avg_rating,
  STDDEV(r.rating) as std_rating,
  MIN(r.rating_ts) as first_rating_ts,
  MAX(r.rating_ts) as last_rating_ts
FROM `seu-projeto-gcp.netflix_analytical.fact_ratings` as r
LEFT JOIN `seu-projeto-gcp.netflix_analytical.dim_movies` as m
  ON m.movie_id = r.movie_id
GROUP BY 1,2,3,4;

CREATE TABLE `seu-projeto-gcp.netflix_analytical.fact_ratings`
(
  user_id INT64,
  movie_id INT64,
  rating FLOAT64,
  rating_ts TIMESTAMP,
  src STRING
);

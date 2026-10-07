CREATE EXTERNAL TABLE `seu-projeto-gcp.netflix_raw.raw_user_recommendation_history`
(
  userId STRING,
  tstamp STRING,
  movieId STRING,
  predictedRating STRING
)
OPTIONS(
  allow_jagged_rows=true,
  allow_quoted_newlines=true,
  skip_leading_rows=1,
  format="CSV",
  uris=["gs://raw-layer-netflix/bronze/user_recommendation_history.csv"]
);

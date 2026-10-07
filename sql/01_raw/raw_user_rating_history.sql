CREATE EXTERNAL TABLE `seu-projeto-gcp.netflix_raw.raw_user_rating_history`
(
  userId STRING,
  movieId STRING,
  rating STRING,
  tstamp STRING
)
OPTIONS(
  allow_jagged_rows=true,
  allow_quoted_newlines=true,
  skip_leading_rows=1,
  format="CSV",
  uris=["gs://raw-layer-netflix/bronze/user_rating_history.csv"]
);

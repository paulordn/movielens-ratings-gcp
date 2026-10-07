CREATE EXTERNAL TABLE `seu-projeto-gcp.netflix_raw.raw_ratings_for_additional_users`
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
  uris=["gs://raw-layer-netflix/bronze/ratings_for_additional_users.csv"]
);

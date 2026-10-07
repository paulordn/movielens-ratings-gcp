CREATE EXTERNAL TABLE `seu-projeto-gcp.netflix_raw.raw_movie_elicitation_set`
(
  movieId STRING,
  month_idx STRING,
  source STRING,
  tstamp STRING
)
OPTIONS(
  allow_jagged_rows=true,
  allow_quoted_newlines=true,
  skip_leading_rows=1,
  format="CSV",
  uris=["gs://raw-layer-netflix/bronze/movie_elicitation_set.csv"]
);

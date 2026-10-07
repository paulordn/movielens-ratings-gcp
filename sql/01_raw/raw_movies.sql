CREATE EXTERNAL TABLE `seu-projeto-gcp.netflix_raw.raw_movies`
(
  movieID STRING,
  title STRING,
  genres STRING
)
OPTIONS(
  allow_jagged_rows=true,
  allow_quoted_newlines=true,
  skip_leading_rows=1,
  format="CSV",
  uris=["gs://raw-layer-netflix/bronze/movies.csv"]
);

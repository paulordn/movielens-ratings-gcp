CREATE EXTERNAL TABLE `seu-projeto-gcp.netflix_raw.raw_belief_data`
(
  userId STRING,
  movieId STRING,
  isSeen STRING,
  watchDate STRING,
  userElicitRating STRING,
  userPredictRating STRING,
  userCertainty STRING,
  tstamp STRING,
  movie_idx STRING,
  source STRING,
  systemPredictRating STRING
)
OPTIONS(
  allow_jagged_rows=true,
  allow_quoted_newlines=true,
  skip_leading_rows=1,
  format="CSV",
  uris=["gs://raw-layer-netflix/bronze/belief_data.csv"]
);

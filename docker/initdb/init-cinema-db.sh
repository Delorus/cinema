#!/usr/bin/sh

set -ex

echo "$PWD"

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    create table movies (
      id serial primary key,
      title text not null,
      year int,
      genres varchar(1024)
    );
    create table movie_tags (
      id serial primary key,
      tag_id int,
      user_id int not null,
      movie_id int not null,
      tag text not null,
      created bigint not null
    );
    create table ratings (
      id serial primary key,
      user_id int not null,
      movie_id int not null,
      rating float not null,
      created bigint not null
    );
    create table links (
      id serial primary key,
      movie_id int not null,
      imdb_id varchar(10) null,
      tmdb_id int null
    );
    \copy movies (id, title, genres) FROM '/docker-entrypoint-initdb.d/test_data/movies.csv' WITH (DELIMITER ',', FORMAT CSV, HEADER true, ESCAPE '"', ENCODING 'UTF-8');
    \copy movie_tags (user_id, movie_id, tag, created) FROM '/docker-entrypoint-initdb.d/test_data/tags.csv' WITH (DELIMITER ',', FORMAT CSV, HEADER true, ESCAPE '"', ENCODING 'UTF-8');
    \copy ratings (user_id, movie_id, rating, created) FROM '/docker-entrypoint-initdb.d/test_data/ratings.csv' WITH (DELIMITER ',', FORMAT CSV, HEADER true, ESCAPE '"', ENCODING 'UTF-8');
    \copy links (movie_id, imdb_id, tmdb_id) FROM '/docker-entrypoint-initdb.d/test_data/links.csv' WITH (DELIMITER ',', FORMAT CSV, HEADER true, ESCAPE '"', ENCODING 'UTF-8');
    vacuum full;
EOSQL

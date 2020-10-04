create table movies
(
    id     serial primary key,
    title  text not null,
    year   int,
    genres varchar(1024)
);
create table movie_tags
(
    id       serial primary key,
    tag_id   int,
    user_id  int    not null,
    movie_id int    not null,
    tag      text   not null,
    created  bigint not null
);
create table ratings
(
    id       serial primary key,
    user_id  int    not null,
    movie_id int    not null,
    rating   float  not null,
    created  bigint not null
);
create table links
(
    id       serial primary key,
    movie_id int         not null,
    imdb_id  varchar(10) null,
    tmdb_id  int         null
);

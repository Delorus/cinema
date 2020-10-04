create table genres
(
    id   serial primary key,
    name text not null
);

create unique index uniq_genre_name on genres (name);

create table movie_genres
(
    id       serial primary key,
    movie_id int not null,
    genre_id int not null
);

insert into genres (name)
select distinct unnest(string_to_array(genres, '|'))
from movies
where genres <> '(no genres listed)';

insert into movie_genres (movie_id, genre_id)
select m.id, g.id
from (
         select id, unnest(string_to_array(genres, '|')) as genre
         from movies
         where genres <> '(no genres listed)'
     ) m
         join genres g on (m.genre = g.name);

alter table movies
    drop column genres;

alter table movie_genres
    add constraint fk_movie_id foreign key (movie_id) references movies (id),
    add constraint fk_genre_id foreign key (genre_id) references genres (id);

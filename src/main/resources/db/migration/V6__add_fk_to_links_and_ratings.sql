alter table links
    add constraint fk_movie_id foreign key (movie_id) references movies (id);

alter table ratings
    add constraint fk_movie_id foreign key (movie_id) references movies (id);

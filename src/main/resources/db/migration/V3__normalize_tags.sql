create table tags
(
    id   serial primary key,
    name text not null
);

create unique index inx_uniq_tags_name on tags (name);

insert into tags (name)
select distinct tag
from movie_tags;

alter table tags
    add column if not exists tag_id int;

update movie_tags
set tag_id = t.id
from tags t
where tag = t.name;

alter table movie_tags
    alter column tag_id set not null,
    drop column tag,
    add constraint fk_movie_id foreign key (movie_id) references movies (id),
    add constraint fk_tag_id foreign key (tag_id) references tags (id);


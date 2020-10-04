alter table movie_tags
    alter column created set data type timestamptz using timestamp with time zone 'epoch' + created * interval '1 second';

alter table ratings
    alter column created set data type timestamptz using timestamp with time zone 'epoch' + created * interval '1 second';

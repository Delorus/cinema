alter table movies
    add column if not exists year int;

update movies
set year = cast(substring(title from '\(((20|19|18)\d{2})\)\s*$') as int);

update movies
set title = substring(title from '^(.*?)\s*\((20|19|18)\d{2}\)\s*$')
where year is not null;


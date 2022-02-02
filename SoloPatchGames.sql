/*Create a table of all the LCS patches solo played on*/

drop table if exists solopatches;
create table solopatches as
select *
from
toplanestats
where league = 'LCS'
or league = 'NA LCS'
and patch in
(select distinct patch
from
toplanestats
where 
player="Solo")
order by patch ASC;

#select distinct patch from solopatches;

select * from solopatches;

Select distinct * from solopatches where year = 2021 and (champion = 'Gnar' or champion = 'Renekton');

/*
drop table if exists solopatchesWorld;
create table solopatches as
select *
from
toplanestats
where league = 'LCS'
or league = 'NA LCS'
or league = 'EU LCS'
or league = 'LEC'
or league = 'LCK'
or league = 'LPL'
or league = 'NA LCS'
or league = 'NA LCS'
and patch in
(select distinct patch
from
toplanestats
where 
player="Solo")
and player != 'zig'
order by patch ASC;*/



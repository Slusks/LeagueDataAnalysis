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
and player != 'zig'
order by patch ASC;

#select distinct patch from solopatches;

select * from solopatches;

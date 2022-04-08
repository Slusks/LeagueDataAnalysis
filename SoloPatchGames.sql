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


SELECT 
    champion, 
    COUNT(champion) as 'games played',
    (100*count(champion))/sum(count(champion)) over () as 'percent of total'
FROM
    solopatches
WHERE
    player = 'Solo'
GROUP BY player , champion
ORDER BY COUNT(champion) DESC;

SELECT 
    champion, patch
FROM
    solopatches
WHERE
    player = 'Solo'
ORDER BY patch, champion DESC;

create view LCS_playrate as
Select 
A.year,
A.player,
A.champion,
A.champ_games,
B.games
From( Select
	year,
	player,
    champion,
    count(champion) as 'champ_games'
	from solopatches 
    group by year, player, champion
    /*order by year asc, player*/) as A
Join ( Select
	year,
	player,
    count(champion) as 'games'
	from solopatches 
    group by year, player
    /*order by year asc, player*/) as B
On B.year = A.year AND
B.player = A.player
order by A.year asc, A.player asc, A.champion asc;

select
*,
(champ_games/games)*100 as 'play percentage'
from
	LCS_playrate
order by year asc, player asc, champion asc;

create view LCS_champ_pool as
select year, player, count(Distinct champion) as 'champs_played' from LCS_playrate group by year, player;

select * from LCS_champ_pool;

select year, avg(champs_played) from LCS_champ_pool where champs_played > 2 group by year order by year;

select year, avg(champs_played) from LCS_champ_pool where player = 'Solo' group by year order by year;

select year, split, side, player, league, team from elixerdata where player = 'Solo' and (league = 'LCS' or league='NA LCS') order by year asc;
/*Solo's win percentage by team*/
select year, league, team, sum(result) as 'wins', count(result) as 'games',100*(sum(result)/count(result)) as 'win rate' from elixerdata where player="Solo" and league != 'LCS.A' and league != 'NA CS'  group by team order by year asc;

SELECT 
    year,
    team,
    champion,
    COUNT(champion) AS 'games',
    SUM(result) AS 'wins',
    ROUND(100 * (SUM(result) / COUNT(result)),2) AS 'win rate'
FROM
    elixerdata
WHERE
	player = 'Solo' 
	AND league != 'LCS.A'
	AND league != 'NA CS'
	AND team != 'Gold Coin United'
	AND team != 'Team Liquid Academy'
    AND team != 'Ember'
    and year > 2016
GROUP BY year, champion
/*having COUNT(champion) > 1*/
ORDER BY year asc, count(result) desc;


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



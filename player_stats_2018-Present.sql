/*Create view of all solo games and urls from 2018-2022*/

drop view if exists solo_teams;
create view solo_teams as
SELECT DISTINCT
    year,
    player,
    champion,
    team,
    league,
    url
FROM
    elixerdata
WHERE
    player = 'Solo' 
    AND (league = 'LCS'
	OR league = 'NA LCS')
    and NOT (team = 'Gold Coin United' 
    OR  team = 'Team Liquid Academy')
    and year >= 2018;
select * from solo_teams;

/* Just some stats for LCS players 2018-presentish*/
drop view if exists solo_team_stats ;    
create view solo_team_stats as
select
e.year,
e.player,
e.team,
e.result,
e.firstbloodkill,
e.firstbloodassist, 
e.firstbloodvictim,
e.total_cs,
s.damagetaken,
s.url,
e.position,
e.champion,
e.kills,
e.deaths,
e.assists,
e.dpm,
e.gamelength,
e.earnedgoldshare,
e.damageshare
from
elixerdata e
join scrapeddata s on e.url = s.url and e.champion = s.champion
where 
e.year >= '2018' 
and (e.league = 'LCS' or e.league = 'NA LCS')
order by e.year asc;

select * from solo_team_stats;

/* Just some stats for LCS players 2018-presentish*/
drop view if exists solo_team_stats ;    
create view solo_team_stats as
select
e.year,
e.player,
e.team,
e.result,
e.firstbloodkill,
e.firstbloodassist, 
e.firstbloodvictim,
e.total_cs,
s.damagetaken,
s.url,
e.position,
e.champion,
e.kills,
e.deaths,
e.assists,
e.dpm,
e.gamelength,
e.earnedgoldshare,
e.damageshare
from
elixerdata e
join scrapeddata s on e.url = s.url and e.champion = s.champion
where (e.url, e.team) in (
SELECT
	url, 
    team
    /*league,
    url,
	year,
    player,
    champion,*/
FROM
    elixerdata
WHERE
    player = 'Solo' 
    AND (league = 'LCS'
	OR league = 'NA LCS')
    and NOT (team = 'Gold Coin United' 
    OR  team = 'Team Liquid Academy')
    and year >= 2018)
and e.year >= '2018' 
and (e.league = 'LCS' or e.league = 'NA LCS')
order by e.year asc, e.team ;

/*
select distinct year, team, player, position from elixerdata where 
	(league = 'LCS'
	OR league = 'NA LCS')
    and NOT (team = 'Gold Coin United' 
    OR  team = 'Team Liquid Academy')
    and year >= 2018
    and NOT position = 'team'
    order by year, team, position;
*/

select
year,
player,
team,
result,
(sum(firstbloodkill + firstbloodassist)/sum(firstbloodkill + firstbloodassist)) as 'FB_Participation',
firstbloodkill,
firstbloodassist, 
e.firstbloodvictim,
e.total_cs,
s.damagetaken,
s.url,
e.position,
e.champion,
e.kills,
e.deaths,
e.assists,
e.dpm,
e.gamelength,
e.earnedgoldshare,
e.damageshare
from solo_team_stats

 


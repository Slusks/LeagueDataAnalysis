/*This captures all of Solo's Games*/

Create or replace view SoloStats AS 
SELECT
	e.url,
	e.year,
	e.split,
    e.side,
    e.position,
    s.champion,
    s.player,
    e.patch,
    e.result,
    e.earnedgoldshare,
    e.damageshare,
    e.total_cs,
    s.goldearned,
    s.damagetaken,
    s.totaldamagetoobjectives,
    e.dpm,
    e.gamelength,
    (e.dpm * e.gamelength) as 'totaldamage',
    e.goldat10, 
	e.xpat10, 
	e.csat10,
	e.opp_goldat10, 
	e.opp_xpat10, 
	e.opp_csat10, 
	e.golddiffat10,
	e.xpdiffat10, 
	e.csdiffat10, 
	e.goldat15, 
	e.xpat15, 
	e.csat15, 
	e.opp_goldat15, 
	e.opp_xpat15, 
	e.opp_csat15,
	e.golddiffat15, 
	e.xpdiffat15,
	e.csdiffat15
FROM
    all_scrapeddata s
join elixerdata e on e.url = s.url/*on s.kills = e.kills and s.assists = e.assists and s.deaths = e.deaths and e.champion = s.champion*/
WHERE
	(e.position = 'top' AND e.player = 'Solo') AND
    (s.player = 'FLY Solo' OR
    s.player = 'FOX Solo' OR
	s.player ='CG Solo' OR
    s.player = 'GG Solo' OR
    s.player ='CLG Solo') and
    e.patch !=0
    and e.url !='https://lpl.qq.com%'
order by year;

Select * from solostats;

/* Solo Stats by patch/result */
Select
patch,
result,
count(result) as 'games',
    avg(earnedgoldshare),
    avg(damageshare),
    avg(total_cs),
    avg(goldearned),
    avg(damagetaken),
    avg(totaldamagetoobjectives),
    avg(dpm),
    avg(gamelength),
    avg(goldat10), 
	avg(xpat10), 
	avg(csat10),
	avg(opp_goldat10), 
	avg(opp_xpat10), 
	avg(opp_csat10), 
	avg(golddiffat10),
	avg(xpdiffat10), 
	avg(csdiffat10), 
	avg(goldat15), 
	avg(xpat15), 
	avg(csat15), 
	avg(opp_goldat15), 
	avg(opp_xpat15), 
	avg(opp_csat15),
	avg(golddiffat15), 
	avg(xpdiffat15),
	avg(csdiffat15)
from
	solostats
group by patch, result
order by patch ASC, result DESC;

/* Solo champion stats */
Select
	champion,
    count(champion) as 'games',
    sum(result)/count(result) as 'win rate',
    avg(earnedgoldshare),
    avg(damageshare),
    avg(total_cs),
    avg(goldearned),
    avg(damagetaken),
    avg(totaldamagetoobjectives),
    avg(dpm),
    avg(gamelength),
    avg(dpm)*avg(gamelength) as 'avg_damage',
    avg(goldat10), 
	avg(xpat10), 
	avg(csat10),
	avg(opp_goldat10), 
	avg(opp_xpat10), 
	avg(opp_csat10), 
	avg(golddiffat10),
	avg(xpdiffat10), 
	avg(csdiffat10), 
	avg(goldat15), 
	avg(xpat15), 
	avg(csat15), 
	avg(opp_goldat15), 
	avg(opp_xpat15), 
	avg(opp_csat15),
	avg(golddiffat15), 
	avg(xpdiffat15),
	avg(csdiffat15)
from
	solostats
group by champion
order by games desc;

/*-----------------------------------Scratch Below this point-----------------------------------*/

SELECT 
    champion, count(champion) as 'games', player, team
FROM
    elixerdata
WHERE
    player = 'Solo' AND
    (team = 'Echo Fox' or
    team = 'Flyquest' or
    team = 'Clutch Gaming' or
    team = 'CLG')
group by team
ORDER BY games DESC;

select player from all_scrapeddata where player like '%Solo';

SELECT 
    player,
    count(url)
FROM
    all_scrapeddata
WHERE
    player = 'FLY Solo' OR
    player = 'FOX Solo' OR
	player ='CG Solo' OR
    player = 'GG Solo' OR
    player ='CLG Solo'
group by player;
  




select player, year, result, side from elixerdata where url='http://matchhistory.na.leagueoflegends.com/en/#match-details/TRLH1/1001550120?gameHash=1f605182d4770594&amp;tab=overview';





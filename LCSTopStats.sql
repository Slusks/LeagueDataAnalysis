/*Capturing all toplane games*/
Create or replace view LCStoplanestats AS 
SELECT
	e.url,
	e.year,
	e.split,
    e.league,
    e.side,
    e.position,
    e.team,
    e.teamkills,
    e.champion,
    e.player,
    e.kills,
    e.deaths,
    e.assists,
    100*(e.kills/e.teamkills) as 'killparticipation',
    e.patch,
    e.result,
    e.earnedgoldshare,
    e.damageshare,
    e.total_cs,
    e.dpm,
    e.gamelength,
    (e.dpm * (e.gamelength/60)) as 'totaldamage',
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
	e.csdiffat15,
	s.goldearned,
    s.damagetaken,
    s.totaldamagetoobjectives
FROM
    elixerdata e
left join all_scrapeddata s on s.url = e.url and e.champion = s.champion# and e.patch = s.patch/*on s.kills = e.kills and s.assists = e.assists and s.deaths = e.deaths */
WHERE
	e.position = 'top'
    and (e.league = 'LCS'
    or e.league ='NA LCS')
    and e.patch > 8.01
    and e.year < 2022
    and e.team !='Ember'
    and e.team !='Gold Coin United'
    and e.team != 'Team Liquid Academy'
	order by year;
/*
Select * from LCStoplanestats order by year asc;

Select * from LCStoplanestats where player = 'Solo';
Select * from LCStoplanestats where player != 'Solo';
*/
/*START HERE FOR GETTING SOLO VS TOPLANE AVERAGE*/
/*Full on aggregate toplaner stats. The end all be all*/
 
create or replace view theLCStopavgs as 
Select
	'TheLCSTop' as player,
	year,
    result,
    patch,
    avg(kills),
    avg(deaths),
    avg(assists),
    avg((kills + assists)/deaths) as 'avgKDA',
    avg(killparticipation),
    avg(killparticipation) as 'Percentage_KP',
    avg(earnedgoldshare),
    avg(damageshare),
    avg(damageshare/earnedgoldshare) as 'DamageSharePerGoldshare',
    avg((dpm*gamelength)/goldearned) as 'avgDealtDamagePerGoldEarnedRatio',
    avg(total_cs),
    avg(goldearned),
    avg(damagetaken),
    avg(damagetaken/goldearned) as 'avgAbsorbedDamagePerGoldEarnedRatio',
    avg(totaldamagetoobjectives),
    avg(dpm),
    avg(gamelength),
    avg((dpm/gamelength)*60) as 'DPM_gamelengthNormalized',
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
	LCStoplanestats
where
	player != 'Solo'
group by year, result, patch;

create or replace view theLCStopstdev as 
Select
	'Standard Deviation' as player,
	year,
    result,
    patch,
    std(kills),
    std(deaths),
    std(assists),
    std((kills + assists)/deaths) as 'stdKDA',
    std(killparticipation),
	std(killparticipation) as 'Percentage_KP',
    std(earnedgoldshare),
    std(damageshare),
    std(damageshare/earnedgoldshare) as 'DamageSharePerGoldshare',
    std((dpm*gamelength)/goldearned) as 'stdDealtDamagePerGoldEarnedRatio',
    std(total_cs),
    std(goldearned),
    std(damagetaken),
    std(damagetaken/goldearned) as 'stdAbsorbedDamagePerGoldEarnedRatio',
    std(totaldamagetoobjectives),
    std(dpm),
    std(gamelength),
    std((dpm/gamelength)*60) as 'DPM_gamelengthNormalized',
    std(goldat10), 
	std(xpat10), 
	std(csat10),
	std(opp_goldat10), 
	std(opp_xpat10), 
	std(opp_csat10), 
	std(golddiffat10),
	std(xpdiffat10), 
	std(csdiffat10), 
	std(goldat15), 
	std(xpat15), 
	std(csat15), 
	std(opp_goldat15), 
	std(opp_xpat15), 
	std(opp_csat15),
	std(golddiffat15), 
	std(xpdiffat15),
	std(csdiffat15)
from
	LCStoplanestats
where player !='Solo'
group by year, result, patch;	

#select * from LCStoplanestats where year = 2019;

drop table if exists LCSsolotable;
create table LCSsolotable as
SELECT 
    *
FROM
    LCStoplanestats
WHERE
player = 'Solo';

#select * from LCSsolotable;

create or replace view LCSsoloagg as
Select
	player,
	year,
    result,
    patch,
    avg(kills),
    avg(deaths),
    avg(assists),
    avg((kills + assists)/deaths) as 'avgKDA',
    avg(killparticipation),
	avg(killparticipation) as 'Percentage_KP',
    avg(earnedgoldshare),
    avg(damageshare),
    avg(damageshare/earnedgoldshare) as 'DamageSharePerGoldshare',
    avg((dpm*gamelength)/goldearned) as 'avgDealtDamagePerGoldEarnedRatio',
    avg(total_cs),
    avg(goldearned),
    avg(damagetaken),
    avg(damagetaken/goldearned) as 'avgAbsorbedDamagePerGoldEarnedRatio',
    avg(totaldamagetoobjectives),
    avg(dpm),
    avg(gamelength),
    avg((dpm/gamelength)*60) as 'DPM_gamelengthNormalized',
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
	LCSsolotable
group by year, result, patch;



drop table  if exists LCStopagg;
create table LCStopagg as
select * from LCSsoloagg union select * from theLCStopavgs union select * from theLCStopstdev order by year asc; 


create or replace view LCStopaggv as
select * from LCStopagg where exists (select patch from LCSsoloagg where patch = LCStopagg.patch) order by year, patch asc, result desc;

select * from LCStopaggv group by player, year, result;



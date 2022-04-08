/*Capturing all toplane games*/

Create or replace view toplanestats AS 
SELECT
	e.url,
	e.year,
	e.split,
    e.league,
    e.side,
    e.position,
    e.champion,
    e.player,
    e.kills,
    e.deaths,
    e.assists,
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
	e.position = 'TOP'
    and e.patch > 8.01
    and year < 2022
order by year;

select
*
from toplanestats
where
	league = 'LCS' or
	league = 'LPL' or
	league = 'LCK' or
	league = 'LJL' or
	league = 'LEC'or
	league = 'EULCS' or
	league = 'NALCS' or
	league = 'PCS' or
	league = 'OCE' or
	league = 'LCO'or
	league = 'VCS' or
	league = 'LCL' or
	league = 'LLA' or
	league = 'TCL' or
	league = 'CBLOL' or
	league = 'WCS' or
	league = 'MSI';


/*Test to make sure the join worked correctly */
/*select * from toplanestats where player = 'Nuguri';*/
#select * from toplanestats where player = '1250';


/* Toplaner Stats by player */
Create or replace view toplanestats_agg AS 
Select
	player,
    avg(kills),
    avg(deaths),
    avg(assists),
    min(patch),
    max(patch),
	100*(sum(result)/count(result)) as 'winPercentage',
    count(result) as 'games',
    sum(result) as 'wins',
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
	toplanestats
where 
	league = 'LCS' or
	league = 'LPL' or
	league = 'LCK' or
	league = 'LJL' or
	league = 'LEC'or
	league = 'EULCS' or
	league = 'NALCS' or
	league = 'PCS' or
	league = 'OCE' or
	league = 'LCO'or
	league = 'VCS' or
	league = 'LCL' or
	league = 'LLA' or
	league = 'TCL' or
	league = 'CBLOL' or
	league = 'WCS' or
	league = 'MSI'
group by player
having count(result) > 50
order by winPercentage DESC, games DESC;

select * from toplanestats_agg;

/* Toplane stats grouped by win/loss */
Select
	player,
    count(result) as 'games',
    result,
	min(patch),
    max(patch),
    avg(kills),
    avg(deaths),
    avg(assists),
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
	toplanestats
where league = 'LCS' or
league = 'WCS' or
league = 'LPL' or
league = 'LCK' or
league = 'LJL' or
league = 'LEC'or
league = 'EULCS' or
league = 'NALCS' or
league = 'PCS' or
league = 'OCE' or
league = 'LCO'or
league = 'VCS' or
league = 'LCL' or
league = 'LLA' or
league = 'TCL' or
league = 'CBLOL' or
league = 'MSI'
group by player, result
order by player, result;


#select player, patch, earnedgoldshare, damageshare from toplanestats where player = 'TheShy' order by patch;

/*START HERE FOR GETTING SOLO VS TOPLANE AVERAGE*/
/*Full on aggregate toplaner stats. The end all be all*/
drop table if exists toplaneragg;
create table toplaneragg as
Select
	year,
    count(champion) as 'games',
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
	avg(opp_csat15)
from
	toplanestats
group by year;
 
create or replace view thetopavgs as 
Select
	year,
	'TheTop' as player,
    avg(kills),
    avg(deaths),
    avg(assists),
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
	toplanestats
where (league = 'LCS' or
league = 'WCS' or
league = 'LPL' or
league = 'LCK' or
league = 'LJL' or
league = 'LEC'or
league = 'EULCS' or
league = 'NALCS' or
league = 'PCS' or
league = 'OCE' or
league = 'LCO'or
league = 'VCS' or
league = 'LCL' or
league = 'LLA' or
league = 'TCL' or
league = 'CBLOL' or
league = 'MSI') and
player != 'Solo'
group by year
having count(result) > 50;

create or replace view thetopstdev as 
Select
	year,
	'Standard Deviation' as player,
    STDDEV(kills),
    STDDEV(deaths),
    STDDEV(assists),
    STDDEV(earnedgoldshare),
    STDDEV(damageshare),
    STDDEV(total_cs),
    STDDEV(goldearned),
    STDDEV(damagetaken),
    STDDEV(totaldamagetoobjectives),
    STDDEV(dpm),
    STDDEV(gamelength),
    STDDEV(goldat10), 
	STDDEV(xpat10), 
	STDDEV(csat10),
	STDDEV(opp_goldat10), 
	STDDEV(opp_xpat10), 
	STDDEV(opp_csat10), 
	STDDEV(golddiffat10),
	STDDEV(xpdiffat10), 
	STDDEV(csdiffat10), 
	STDDEV(goldat15), 
	STDDEV(xpat15), 
	STDDEV(csat15), 
	STDDEV(opp_goldat15), 
	STDDEV(opp_xpat15), 
	STDDEV(opp_csat15),
	STDDEV(golddiffat15), 
	STDDEV(xpdiffat15),
	STDDEV(csdiffat15)
from
	toplanestats
where (league = 'LCS' or
league = 'WCS' or
league = 'LPL' or
league = 'LCK' or
league = 'LJL' or
league = 'LEC'or
league = 'EULCS' or
league = 'NALCS' or
league = 'PCS' or
league = 'OCE' or
league = 'LCO'or
league = 'VCS' or
league = 'LCL' or
league = 'LLA' or
league = 'TCL' or
league = 'CBLOL' or
league = 'MSI')
group by year
having count(result) > 10;	

drop table if exists solotable;
create table solotable as
SELECT 
    *
FROM
    toplanestats
WHERE
player = 'Solo' and 
(league = 'LCS' or
league = 'WCS' or
league = 'LPL' or
league = 'LCK' or
league = 'LJL' or
league = 'LEC'or
league = 'EU LCS' or
league = 'NA LCS' or
league = 'PCS' or
league = 'OCE' or
league = 'LCO'or
league = 'VCS' or
league = 'LCL' or
league = 'LLA' or
league = 'TCL' or
league = 'CBLOL' or
league = 'MSI');

select * from solotable;

create or replace view soloagg as
Select
	year,
	player,
    avg(kills),
    avg(deaths),
    avg(assists),
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
	solotable
group by year, player;


select * from soloagg;

select * from soloagg union select * from thetopavgs union select * from thetopstdev order by year asc; 



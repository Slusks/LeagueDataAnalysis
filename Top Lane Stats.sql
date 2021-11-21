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
order by year;


/*Test to make sure the join worked correctly */
/*select * from toplanestats where player = 'Nuguri';*/
#select * from toplanestats where player = '1250';


/* Toplaner Stats by player */
Create or replace view toplanestats_agg AS 
Select
	player,
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
where league = 'LCS' or
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
league = 'CBLOL'
group by player
having count(result) > 50
order by winPercentage DESC, games DESC;

select * from toplanestats_agg;

/* Toplane stats grouped by win/loss */
Select
	player,
    count(result) as 'games',
    result,
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
league = 'CBLOL'
group by player, result
order by player, result;


#select player, patch, earnedgoldshare, damageshare from toplanestats where player = 'TheShy' order by patch;

/* toplane champion stats */
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
	toplanestats
group by champion
order by games desc;

/*Full on aggregate toplaner stats. The end all be all*/

Select
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
	toplanestats;
    
Select
	player,
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
league = 'CBLOL' and
player != 'Solo'
having count(result) > 50;
    
    
    

#============================Scratch=================================================#

select player, url, patch from elixerdata where player='TheShy' order by patch desc;

select player, url, patch from all_scrapeddata where player = 'IGTheShy';
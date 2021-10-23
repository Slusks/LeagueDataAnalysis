Create or replace view s_1 AS 
select
	champion,
    totalphysicaldamagedealt,
    totalmagicdamagedealt,
    physicaldamagetochampions,
    magicdamagetochampions,
    totaldamagetoobjectives,
    damagetaken,
    damagehealed,
    timeccingothers,
    url
from
	all_scrapeddata
where totaldamagetoobjectives != 0;

Create or replace view e_1 AS
select
	champion,
	result,
    damageshare,
    dpm,
    position,
    team_kpm,
    heralds,
    earnedgold,
    earnedgoldshare,
    total_cs,
    damagetakenperminute,
    damagemitigatedperminute,
    url
from
	elixerdata
where champion !='' and position = 'top';
/*
#THIS SEEMS TO WORK LETS GOOOOOOOO
Select
e.champion,
e.result,
e.damageshare,
e.dpm,
s.totalphysicaldamagedealt,
s.totalmagicdamagedealt,
s.physicaldamagetochampions,
s.magicdamagetochampions,
s.totaldamagetoobjectives
from
	s_1 s 
join e_1 e on e.url = s.url AND e.champion = s.champion;
*/
select
	e.champion,
    #e.result,
    count(e.champion) as 'games',
    sum(e.result)/count(e.result) as 'win rate',
    AVG(e.dpm) as 'avgDPM',
	(CASE 
		When s.physicaldamagetochampions > s.magicdamagetochampions 
		then AVG(s.physicaldamagetochampions)
		else AVG(s.magicdamagetochampions)
		end) as 'avgDamage',
	CASE 
		When s.physicaldamagetochampions > s.magicdamagetochampions 
		then AVG(s.physicaldamagetochampions/s.damagetaken)
		else AVG(s.magicdamagetochampions/s.damagetaken)
		end as 'DamageRatio',
    AVG(s.physicaldamagetochampions) as 'avgPhysicalDamageToChampions',
    AVG(s.magicdamagetochampions) as 'avgMagicdamagetochampions',
    AVG(s.totaldamagetoobjectives) as 'avgTotalDamageToObjectives',
    AVG(s.damagetaken) as 'avgDamageTaken',
    AVG(e.damageshare) as 'avgDamageShare',
    AVG(s.damagehealed) as 'avgDamageHealed',
    AVG(s.timeccingothers) as 'avgTimeApplyingCC',
	AVG(e.team_kpm) as 'avgTeamKPM',
    AVG(e.heralds) as 'avgHeralds',
    AVG(e.earnedgold) as 'avgEarnedGold',
    AVG(e.earnedgoldshare) as 'avgEarnedGoldShare',
    AVG(e.total_cs) as 'avgCS',
    AVG(e.damagetakenperminute) as 'avgDamageTakenPerMinute',
    AVG(e.damagemitigatedperminute) as 'avgDamageMitigatedPerMinute'
    from
	s_1 s 
join e_1 e on s.url = e.url AND e.champion = s.champion
where s.totaldamagetoobjectives != 0 
	and e.position = 'top' 
group by s.champion
having count(e.champion) > 50
order by games DESC;


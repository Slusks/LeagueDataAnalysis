Create or replace view s_1 AS 
select
	champion,
    totalphysicaldamagedealt,
    totalmagicdamagedealt,
    physicaldamagetochampions,
    magicdamagetochampions,
    totaldamagetoobjectives,
    damagetaken,
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
    AVG(e.dpm) as 'avgDPM',
    #AVG(s.totalphysicaldamagedealt) as 'totalphysicaldamagedealt',
    #AVG(s.totalmagicdamagedealt) as 'totalmagicadamagedealt',
    AVG(s.physicaldamagetochampions) as 'physicaldamagetochampions',
    AVG(s.magicdamagetochampions) as 'magicdamagetochampions',
    AVG(s.totaldamagetoobjectives) as 'totaldamagetoobjectives',
    AVG(s.damagetaken) as 'damagetaken',
    AVG(e.damageshare) as 'avgdamageshare',
	#AVG(s.physicaldamagetochampions/s.damagetaken) as 'pdealt-taken',
    #AVG(s.magicdamagetochampions/s.damagetaken) as 'mdealt-taken',
    CASE 
		When s.physicaldamagetochampions > s.magicdamagetochampions 
		then AVG(s.physicaldamagetochampions/s.damagetaken)
		else AVG(s.magicdamagetochampions/s.damagetaken)
		end as 'DamageRatio'
    from
	s_1 s 
join e_1 e on s.url = e.url AND e.champion = s.champion
where s.totaldamagetoobjectives != 0 
	and e.position = 'top' 
group by s.champion
having count(e.champion) > 50
order by DamageRatio DESC;
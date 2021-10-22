select
	s.champion,
    count(s.champion) as 'games',
    e.patch,
    AVG(s.totalphysicaldamagedealt) as 'totalphysicaldamagedealt',
    AVG(s.totalmagicdamagedealt) as 'totalmagicadamagedealt',
    AVG(s.physicaldamagetochampions) as 'physicaldamagetochampions',
    AVG(s.magicdamagetochampions) as 'magicdamagetochampions',
    AVG(s.totaldamagetoobjectives) as 'totaldamagetoobjectives'
from
	scrapeddata s
join elixerdata e on s.url = e.url
where s.totaldamagetoobjectives != 0
group by champion, result
order by patch;

select
	s.champion,
    e.result,
    count(s.champion) as 'games',
    AVG(s.totalphysicaldamagedealt) as 'totalphysicaldamagedealt',
    AVG(s.totalmagicdamagedealt) as 'totalmagicadamagedealt',
    AVG(s.physicaldamagetochampions) as 'physicaldamagetochampions',
    AVG(s.magicdamagetochampions) as 'magicdamagetochampions',
    AVG(s.totaldamagetoobjectives) as 'totaldamagetoobjectives',
    AVG(e.damageshare) as 'avgdamageshare',
    AVG(e.dpm) as 'avgDPM'
from
	scrapeddata s
join elixerdata e on s.url = e.url
where s.totaldamagetoobjectives != 0
group by s.champion, e.result
order by s.champion;

Create or replace view s_1 AS 
select
	champion,
    totalphysicaldamagedealt,
    totalmagicdamagedealt,
    physicaldamagetochampions,
    magicdamagetochampions,
    totaldamagetoobjectives,
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
    url
from
	elixerdata
where champion !='';

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

select
	e.champion,
    e.result,
    count(e.champion) as 'games',
	AVG(e.damageshare) as 'avgdamageshare',
    AVG(e.dpm) as 'avgDPM',
    AVG(s.totalphysicaldamagedealt) as 'totalphysicaldamagedealt',
    AVG(s.totalmagicdamagedealt) as 'totalmagicadamagedealt',
    AVG(s.physicaldamagetochampions) as 'physicaldamagetochampions',
    AVG(s.magicdamagetochampions) as 'magicdamagetochampions',
    AVG(s.totaldamagetoobjectives) as 'totaldamagetoobjectives'
from
	s_1 s 
join e_1 e on e.url = s.url AND e.champion = s.champion
where s.totaldamagetoobjectives != 0
group by s.champion, e.result
order by s.champion;
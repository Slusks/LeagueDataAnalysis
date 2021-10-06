#union to combine all scraped data
#need to list out the columns so they get added in the right order

Create or replace view all_scrapeddata AS 
SELECT #these are the columns from the non-lpl scraped data
	assists,
	doublekills,
	deaths,
	firstblood,
	goldearned,
	champion,
	totalInhibitorKills,
	kills,
	killingsprees,
	largestcriticalstrike,
	largestkillingspree,
	largestmultikill,
	minionskilled,
	totalmagicdamagedealt,
	magicdamagetochampions,
	magicdamagetaken,
	player,
	neutralminionskilledinenemyjungle,
	neutralminionskilledinteamsjungle,
	totalphysicaldamagedealt,
	physicaldamagetaken,
	physicaldamagetochampions,
	pentakills,
	quadrakills,
	triplekills,
	damagetaken,
	totaldamagetochampions,
	damagehealed,
	totalTurretKills,
	controlwardspurchased,
	wardsdestroyed,
	url,
	totaldamagetoobjectives, 
	totaldamagetoturrets,
	selfmitigateddamage,
	firstbloodassist,
	firstinhibkill,
	firsttowerassist,
	firsttowerkill,
	gameid,
	patch,
	goldspent,
	longesttimespentliving,
	stealthwardspurchased,
	timeccingothers,
    visionscore,
    truedamagetochampions
FROM
    scrapeddata 
UNION SELECT #these are the columns from the lpl scraped data
    assists,
	doublekills,
	deaths,
	firstblood,
	goldearned,
	champion,
	totalInhibitorKills,
	kills,
	killingsprees,
	largestcriticalstrike,
	largestkillingspree,
	largestmultikill,
	minionskilled,
	totalmagicdamagedealt,
	magicdamagetochampions,
	magicdamagetaken,
	player,
	neutralminionskilledinenemyjungle,
	neutralminionskilledinteamsjungle,
	totalphysicaldamagedealt,
	physicaldamagetaken,
	physicaldamagetochampions,
	pentakills,
	quadrakills,
	triplekills,
	damagetaken,
	totaldamagetochampions,
	damagehealed,
	totalTurretKills,
	controlwardspurchased,
	wardsdestroyed,
	url,
	## the below columns dont exist in the lpl scraped data
	null as totaldamagetoobjectives, 
	null as totaldamagetoturrets,
	null as selfmitigateddamage,
	null as firstbloodassist,
	null as firstinhibkill,
	null as firsttowerassist,
	null as firsttowerkill,
	null as gameid,
	null as patch,
	null as goldspent,
	null as longesttimespentliving,
	null as stealthwardspurchased,
	null as timeccingothers,
    null as visionscore,
    null as truedamagetochampions
FROM
    all_lpldata;
    
select player, gameid, url from all_scrapeddata where patch=0;

select url, gameid from elixerdata;

select substring(url, -5, 4) as partial from all_lpldata;

SELECT DISTINCT
    SUBSTRING(url, - 5, 4) AS partial
FROM
    elixerdata
WHERE
    url LIKE '%lpl%'
Union
Select distinct
	substring(url, -5, 4) as partial
    from all_lpldata;

select url from all_scrapeddata;

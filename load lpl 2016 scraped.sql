#this is creating a table with the lpl 2016 and earlier (I think) data and then combining it with the rest of the lpl data

drop table if exists lpldata2016;
create table lpldata2016(
	assists int null,
	doublekills int null,
	deaths int null,
	firstblood bool null,
	goldearned int null,
	champion varchar(255),
	kills int null,
	killingsprees int null,
	largestmultikill int null,
	minionskilled int null,
	magicdamagetochampions int null,
	magicdamagetaken int null,
	player varchar(255) null,
	neutralminionskilledinenemyjungle int null,
	neutralminionskilledinteamsjungle int null,
	physicaldamagetaken int null,
	physicaldamagetochampions int null,
	pentakills int null,
	quadrakills int null,
	triplekills int null,
	damagetaken int null,
	totaldamagetochampions int null,
	totalturretkills int null,
	controlwardspurchased int null,
	wardsdestroyed int null,
	url varchar(255) null
    );
    
LOAD DATA LOCAL INFILE 'C://Users//sam//Desktop//ScrapeTest//prod//9-6-2021_Final//lpl_2016_prod_database_V3.csv' into table lpldata2016
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

drop table if exists all_lpldata;
create table all_lpldata(
	SELECT 
		assists,
		champion,
		controlwardspurchased,
		damagetaken,
		deaths,
		doublekills,
		firstblood,
		goldearned,
		killingsprees,
		kills,
		largestmultikill,
		magicdamagetochampions,
		magicdamagetaken,
		minionskilled,
		neutralminionskilledinenemyjungle,
		neutralminionskilledinteamsjungle,
		pentakills,
		physicaldamagetochampions,
		physicaldamagetaken,
		player,
		quadrakills,
		totaldamagetochampions,
		totalTurretKills,
		triplekills,
		url,
		wardsdestroyed,
		damagehealed,
		largestcriticalstrike,
		largestkillingspree,
		totalInhibitorKills,
		totalmagicdamagedealt,
		totalphysicaldamagedealt
	FROM
		baselpldata 
	UNION SELECT 
		assists,
		champion,
		controlwardspurchased,
		damagetaken,
		deaths,
		doublekills,
		firstblood,
		goldearned,
		killingsprees,
		kills,
		largestmultikill,
		magicdamagetochampions,
		magicdamagetaken,
		minionskilled,
		neutralminionskilledinenemyjungle,
		neutralminionskilledinteamsjungle,
		pentakills,
		physicaldamagetochampions,
		physicaldamagetaken,
		player,
		quadrakills,
		totaldamagetochampions,
		totalTurretKills,
		triplekills,
		url,
		wardsdestroyed,
		NULL AS damagehealed,
		NULL AS largestcriticalstrike,
		NULL AS largestkillingspree,
		NULL AS totalInhibitorKills,
		NULL AS totalmagicdamagedealt,
		NULL AS totalphysicaldamagedealt
	FROM
		lpldata2016);
        
	select * from all_lpldata;
        
    





    

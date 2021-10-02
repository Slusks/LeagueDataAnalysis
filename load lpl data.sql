#This is creating a table of all the post 2016 lpl data

drop table if exists baselpldata;
create table baselpldata(
	assists int null,
	doublekills int null,
	deaths int null,
	firstblood bool null,
	goldearned int null,
	champion varchar(255),
	totalInhibitorKills int null,
	kills int null,
	killingsprees int null,
	largestcriticalstrike int null,
	largestkillingspree int null,
	largestmultikill int null,
	minionskilled int null,
	totalmagicdamagedealt int null,
	magicdamagetochampions int null,
	magicdamagetaken int null,
	player varchar(255),
	neutralminionskilledinenemyjungle int null,
	neutralminionskilledinteamsjungle int null,
	totalphysicaldamagedealt int null,
	physicaldamagetaken int null,
	physicaldamagetochampions int null,
	pentakills int null,
	quadrakills int null,
	triplekills int null,
	damagetaken int null,
	totaldamagetochampions int null,
	damagehealed int null,
	totalTurretKills int null,
	controlwardspurchased int null,
	wardsdestroyed int null,
	url varchar(255)
    );
    
LOAD DATA LOCAL INFILE 'C://Users//sam//Desktop//ScrapeTest//prod//9-6-2021_Final//lpl_prod_database_V3.csv' into table baselpldata
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

select * from baselpldata;

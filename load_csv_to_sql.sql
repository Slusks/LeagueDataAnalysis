#creating a table of all the data taken from Oracle's elixer

drop table if exists elixerdata;
create table elixerdata(
	gameid VARCHAR(15) NULL,
	datacompleteness VARCHAR(10) NULL,
	url VARCHAR(255) NULL,
	league CHAR(10) NULL,
	year INT NULL,
	split VARCHAR(10) NULL,
	playoffs boolean NULL,
	date datetime NULL,
	game int NULL,
	patch float NULL,
	playerid int NULL,
	side char(4) NULL,
	position varchar(5) NULL,
	player varchar(255) NULL,
	team varchar(255) NULL,
	champion varchar(255) NULL,
	ban1 varchar(255) NULL,
	ban2 varchar(255) NULL,
	ban3 varchar(255) NULL,
	ban4 varchar(255) NULL,
	ban5 varchar(255) NULL,
	gamelength int NULL,
	result boolean NULL,
	kills int NULL,
	deaths int NULL,
	assists int NULL,
	teamkills int NULL,
	teamdeaths int NULL,
	doublekills int NULL,
	triplekills int NULL,
	quadrakills int NULL,
	pentakills int NULL,
	firstblood boolean NULL,
	firstbloodkill boolean  NULL,
	firstbloodassist boolean NULL,
	firstbloodvictim boolean NULL,
	team_kpm float NULL,
	ckpm float,
	firstdragon boolean NULL,
	dragons int NULL,
	opp_dragons int NULL,
	elementaldrakes int NULL,
	opp_elementaldrakes int NULL,
	infernals int NULL,
	mountains int NULL,
	clouds int NULL,
	oceans int NULL,
	dragons_type_unknown int NULL,
	elders int NULL,
	opp_elders int NULL,
	firstherald boolean NULL,
	heralds int  NULL,
	opp_heralds int NULL,
	firstbaron boolean NULL,
	barons int NULL,
	opp_barons int NULL,
	firsttower boolean NULL,
	towers int NULL,
	opp_towers int NULL,
	firstmidtower boolean NULL,
	firsttothreetowers boolean NULL,
	inhibitors int NULL,
	opp_inhibitors int NULL,
	damagetochampions int NULL,
	dpm float NULL,
	damageshare float NULL,
	wardsplaced int NULL,
	wpm float NULL,
	wardskilled int  NULL,
	wcpm float NULL,
	controlwardsbought int NULL,
	visionscore int NULL,
	vspm float NULL,
	totalgold int NULL,
	earnedgold int NULL,
	earned_gpm float NULL,
	earnedgoldshare float NULL,
	goldspent float NULL,
	gspd float NULL,
	total_cs int NULL,
	minionkills int NULL,
	monsterkills int NULL,
	monsterkillsownjungle int NULL,
	monsterkillsenemyjungle int NULL,
	cspm float NULL,
	goldat10 int NULL,
	xpat10 int NULL,
	csat10 int NULL,
	opp_goldat10 int NULL,
	opp_xpat10 int NULL,
	opp_csat10 int NULL,
	golddiffat10 int NULL,
	xpdiffat10 int NULL,
	csdiffat10 int NULL,
	goldat15 int NULL,
	xpat15 int NULL,
	csat15 int NULL,
	opp_goldat15 int NULL,
	opp_xpat15 int NULL,
	opp_csat15 int NULL,
	golddiffat15 int NULL,
	xpdiffat15 int NULL,
	csdiffat15 int NULL );
    
LOAD DATA LOCAL INFILE 'C://Users//sam//Desktop//ScrapeTest//prod//data//2021_league_stats_9-11-2021.csv' into table elixerdata
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;    
    
LOAD DATA LOCAL INFILE 'C://Users//sam//Desktop//ScrapeTest//prod//data//2020_league_stats.csv' into table elixerdata
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C://Users//sam//Desktop//ScrapeTest//prod//data//2019_league_stats.csv' into table elixerdata
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C://Users//sam//Desktop//ScrapeTest//prod//data//2018_league_stats.csv' into table elixerdata
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C://Users//sam//Desktop//ScrapeTest//prod//data//2017_league_stats.csv' into table elixerdata
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C://Users//sam//Desktop//ScrapeTest//prod//data//2016_league_stats.csv' into table elixerdata
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;


select * from elixerdata;
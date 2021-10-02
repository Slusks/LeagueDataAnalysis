#creating a table of all the non-lpl scraped data
#will probably need to confirm that the amateur data loaded correctly.


drop table if exists scrapeddata;
create table scrapeddata(
assists int null,
champion varchar(255) null,
totaldamagetoobjectives int null,
totaldamagetoturrets int null,
selfmitigateddamage int null,
deaths int null,
doublekills int null,
firstbloodassist bool null,
firstblood bool null,
firstinhibkill bool null,
firsttowerassist bool null,
firsttowerkill bool null,
gameid int null,
patch float null,
goldearned int null,
goldspent int null,
totalInhibitorKills int null,
killingsprees int null,
kills int null,
largestcriticalstrike int null,
largestkillingspree int null,
largestmultikill int null,
longesttimespentliving int null,
totalmagicdamagedealt int null,
magicdamagetochampions int null,
magicdamagetaken int null,
neutralminionskilledinenemyjungle int null,
neutralminionskilledinteamsjungle int null,
pentakills int null,
totalphysicaldamagedealt int null,
physicaldamagetochampions int null,
physicaldamagetaken int null,
quadrakills int null,
stealthwardspurchased int null,
player varchar(255),
timeccingothers int null,
totaldamagetochampions int null,
damagetaken int null,
damagehealed int null,
minionskilled int null,
totaltimeapplyingcc int null,
triplekills int null,
truedamagetochampions int null,
totalTurretKills int null,
visionscore int null,
controlwardspurchased int null,
wardsdestroyed int null,
url varchar(255) null
);
 
LOAD DATA LOCAL INFILE 'C://Users//sam//Desktop//ScrapeTest//prod//9-6-2021_Final//prod_database_V3.csv' into table scrapeddata
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES; 

LOAD DATA LOCAL INFILE 'C://Users//sam//Desktop//ScrapeTest//prod//9-6-2021_Final//prod_amateur_database_V3.csv' into table scrapeddata
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

select * from scrapeddata;






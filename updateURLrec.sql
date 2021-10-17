#Script file to update urlrec table which is going to be used to reconcile patches and other values between elixer and scraped data

#Run these as necessary
#show global variables like 'local_infile';
#set global local_infile=true;

drop table if exists urlrec;
create table urlrec(
elixer varchar(255),
scrape varchar(255));


LOAD DATA LOCAL INFILE 'F://LeagueStats//scraping//LeagueDataAnalysis//urlrec.csv' into table urlrec
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;    

#identify the rows where a short lpl url was linked to a longer one
select * from urlrec where elixer != scrape;
#it's always a shorter row tied to the longer row.
#Example: elixer = 8001, scrape = 8001 exists
# elixer = 8001, scrape = 800 exists exist
# elixer = 800, scrape = 800 does not exist



    

SELECT distinct
    url.*, e.patch
FROM
    urlrec url
        JOIN
    elixerdata e ON url.elixer = e.url
ORDER BY elixer;#e.patch;







/*
#Needed to do this becaue there was an error in how the that record carried over
update urlrec
set scrape = 'https://lpl.qq.com/es/stats.shtml?bmid=438\r'
where elixer = 'https://lpl.qq.com/es/stats.shtml?bmid=438';
 */ 
# elixer, scrape, patch



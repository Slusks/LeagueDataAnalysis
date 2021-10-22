#Script file to update urlrec table which is going to be used to reconcile patches and other values between elixer and scraped data

#Run these as necessary
#show global variables like 'local_infile';
#set global local_infile=true;

#Before running this script, open file in notepad++ and convert to Unix (CRLF -> LF)
#open in excel and drop all duplicates

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
# elixer = 800, scrape = 8001 exists exist
# elixer = 800, scrape = 800 does not exist



SELECT distinct
    url.*, e.patch
FROM
    urlrec url
        JOIN
    elixerdata e ON url.elixer = e.url
ORDER BY elixer;#e.patch;


SELECT distinct
    s.champion,
    count(s.champion) as 'gamesplayed'
FROM
    scrapeddata s
        JOIN
    elixerdata e ON s.champion = e.champion
group by s.champion
order by gamesplayed desc;

select champion, count(champion) as played from elixerdata where player !='' group by champion order by played DESC;
#37,142 unique urls in scrappedata (372,239 rows) That's about 10 rows per URL which is mostly expected
#37,279 unique urls in elixerdata (514574 rows) That's about 13 rows per url which is odd
#this would equal



#want to create a script to add patch numbers from oracle's elixer to the scraped table

select
    url,
    patch
from
	elixerdata
where patch !="0"
group by url
order by patch;

select patch from all_scrapeddata;

SELECT 
    url, 
    patch
FROM
    elixerdata
WHERE
    url LIKE '%lpl%';
    
SELECT 
    e.url, 
    s.url
FROM
    elixerdata e
left Join all_scrapeddata s on e.url = s.url
WHERE
    e.url LIKE '%lpl%';
    
drop table if exists urlrec;
create table urlrec(
elixer varchar(255),
scrape varchar(255));



LOAD DATA LOCAL INFILE 'F://LeagueStats//scraping//LeagueDataAnalysis//urlrec.csv' into table urlrec
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;    
    

    
    
    
    
    
    

Create or replace view compound_key AS 
SELECT 
    url, gameid, champion
FROM
    elixer_leaguestats
where
	champion !="";
    
select url from scraped_leaguestats where url;

select url from elixer_leaguestats limit 500;

select
	s.url as scraped,
    e.url as elixer
    from scraped_leaguestats s, elixer_leaguestats e;
    
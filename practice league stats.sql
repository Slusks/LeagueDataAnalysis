Select
	elixer.*,
    scraped.*
from elixer_leaguestats elixer
join 
scraped_leaguestats scraped 
on 
elixer.url = scraped.url and 
elixer.champion = scraped.champion and
elixer.kills = scraped.kills and
elixer.assists = scraped.assists and
elixer.deaths = scraped.deaths
where
elixer.player !="";

/*Select distinct
	elixer.url,
    scraped.url,
    elixer.gameid,
    scraped.gameid
from elixer_leaguestats elixer
join scraped_leaguestats scraped on elixer.champion = scraped.champion;*/
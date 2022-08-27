drop table if exists ToplaneFBLCS;
create table ToplaneFBLCS as
Select
	player,
    team,
    league,
	year,
    split,
	patch,
	position,
	firstblood,
	firstbloodkill,
	firstbloodassist,
	firstbloodvictim
from
	elixerdata
where 
    year > 2017 and
	position = 'top' and
	team != 'Gold Coin United' and
    team != 'eUnited' and
    team != 'Team Liquid Academy' and
	(league = 'LCS' or
	league = 'NA LCS')
	order by year, patch;
    
update ToplaneFBLCS set split = 'Summer'
where split = '';
    
select 
    year,
    split,
	sum(firstblood) as 'FB',
    sum(firstblood)/Count(firstblood) as 'FB%',
	sum(firstbloodkill) as 'FB Kill',
    sum(firstbloodkill)/Count(firstbloodkill) as '%FB Kill',
	sum(firstbloodassist) as 'FB Assist',
    sum(firstbloodassist)/Count(firstbloodassist) as '%FB Assist',
	sum(firstbloodvictim) as 'FB Victim',
    sum(firstbloodvictim)/Count(firstbloodvictim)as '%FB Victim'
from
	ToplaneFBLCS
where player != 'Solo'
group by year, split
order by year, split desc;
    
    
select 
	player,
    year,
	sum(firstblood) as 'FB',
    sum(firstblood)/Count(firstblood) as 'FB%',
	sum(firstbloodkill) as 'FB Kill',
    sum(firstbloodkill)/Count(firstbloodkill) as '%FB Kill',
	sum(firstbloodassist) as 'FB Assist',
    sum(firstbloodassist)/Count(firstbloodassist) as '%FB Assist',
	sum(firstbloodvictim) as 'FB Victim',
    sum(firstbloodvictim)/Count(firstbloodvictim)as '%FB Victim'
from
	ToplaneFBLCS
group by player, year
order by year, player, 'FB%';
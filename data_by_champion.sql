#aggregating stats by champion total
#will also want to do this by patch at some point but will have to use Elixer data for that becasuse some champ data doesn't have patch numbers

Create or replace view champion_aggregate AS 
SELECT 
	champion,
    count(gameid) as "games",
    AVG(kills) as 'avg_kills',
	AVG(assists) as 'avg_assists',
    AVG(deaths) as 'avg_deaths',
	AVG(totaldamagetoobjectives) as 'Avg_total_damage_too_objectives',
	AVG(totaldamagetoturrets) as 'avg_total_damage_too_turrets',
	AVG(selfmitigateddamage) as 'avg_self_mitigated_damage',
	COUNT(firstblood) as 'first_bloods',
	COUNT(firstbloodassist) as 'first_blood_assists',
	COUNT(firsttowerkill) as 'first_tower_kills',
	COUNT(firstinhibkill) as 'first_inhib_kills',
    AVG(totalInhibitorKills) as 'avg_inhib_kills',
	COUNT(firsttowerassist) as 'first_tower_assists',
	AVG(goldearned) as 'avg_gold_earned',
	AVG(goldspent) as 'avg_gold_spent',
	AVG(killingsprees) as 'avg_killinspree',
    AVG(totalphysicaldamagedealt) as 'avg_physical_damage_dealt',
    AVG(totalmagicdamagedealt) as 'avg_total_magic_damage_dealt',
	AVG(physicaldamagetochampions) as 'avg_physical_damage_dealt_to_champs',
    AVG(magicdamagetochampions) as 'avg_magic_damage_dealt_to_champs',
    AVG(totaldamagetochampions) as 'avg_total_damage_to_champs',
	AVG(physicaldamagetaken) as 'avg_physical_damage_taken',
	AVG(magicdamagetaken) as 'avg_magic_damage_taken',
    AVG(damagetaken) 'avg_damage_taken',
    Avg(damagehealed) as 'avg_damage_healed',
	AVG(neutralminionskilledinenemyjungle) as 'avg_enemy_jungle_minions',
	AVG(neutralminionskilledinteamsjungle) as 'avg_own_jungle_minions',
	#player varchar(255), #Is there a way to get most common player
	AVG(timeccingothers) as 'avg_time_ccing_others',
	AVG(minionskilled) as 'avg_cs',
	AVG(truedamagetochampions) as 'avg_true_damage_champs',
	AVG(visionscore) as 'avg_visionscore',
	AVG(controlwardspurchased) as 'avg_controlwardspurchased',
	AVG(wardsdestroyed) as 'avg_wardsdestroyed'
 FROM scraped_leaguestats
 
 where player !=""
 group by champion
 order by games DESC;
 
 select * from champion_aggregate;
 
 select
	champion,
    count(gameid) as 'games'
    from
    elixer_leaguestats
    where position !="team"
    group by champion
    order by games DESC;
    
    Select * from elixer_leaguestats  limit 50;
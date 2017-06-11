var/const
	scoreboard={""}
Rank_Entry
	var{Key;Kills;Date}
	New(mob/player/client/p)
		if(!p)return
		src.Key=p.key
		src.Kills=p.kills
		src.Date=time2text(world.realtime)
		..()
proc
	RankingDisplay(var/mob/player/p,rank_t=0,rank_m="Custom")
		if(!p||!rank_t)return
		var/list/ranks=new()
		var/savefile/F=new("save/k-ranks.sav")
		F[("stuff[rank_t][rank_m]")]>>(ranks)
		var/html={"
			<html>
			<head><title>Kill Ranks</title></head>
			<body>
			<style type="text/css">
				body{background-color: #000000; color: silver; scrollbar-face-color: #303030; scrollbar-highlight-color: #7A7A7A; scrollbar-3dlight-color: #555555; scrollbar-darkshadow-color: #3D3D3D; scrollbar-shadow-color: #171717; scrollbar-arrow-color: #F7F7F7; scrollbar-track-color: #1C1C1C}
			</style>
			<table cellpadding="3" cellspacing="0" border="1" align="center">
			<td>
			<center><b>Kill Ranks for the map '[rank_m]([rank_t])'</b></center>
			<table cellpadding="3" cellspacing="4" border="1" align="center">
			<tr>
			"}
		if(!ranks)html+="<td>No kill ranks to display.</td></tr>"
		else
			html+={"
				<tr>
					<td><b>#</td><td><i>(key)</i></td><td>Kills</td><td>Date</td>
				</tr>
				"}
			for(var/n in 1 to length(ranks))
				var{character=(ranks[(n)]);Rank_Entry/player=(ranks[(character)])}
				html+={"
					<tr>
						<td><u>[(n)]</td><td></u><i>([(player.Key)])</i></td><td>[num2text(round(player.Kills),100)]</td><td>[(player.Date)]</td>
					</tr>
					"}
		html+={"
			</tr>
			</td>
			</table>
			</table>
			"}
		p<<browse("[html]","window=killranks;size=524x344")
	Ranking(var/mob/player/client/p,rank_t=0,rank_m="Custom")
		if(!p||!rank_t)return 0
		var/savefile/F=new("save/k-ranks.sav")
		var/list/ranks=new()
		F[("stuff[rank_t][rank_m]")]>>(ranks)
		if(!ranks)ranks=new()
		var
			character="[(p.client.ckey)]/[(p.name)]"
			score=ranks.Find(character)
			Rank_Entry/newest=new(p)
			Rank_Entry/last
		if(score)
			var/Rank_Entry/old=(ranks[(character)])
			if(old.Kills>=p.kills)return 0
			while(score>1)
				last=ranks[(ranks[(score-1)])]
				if(last.Kills>=p.kills)break
				ranks[(score)]=(ranks[(score-1)])
				ranks[(--score)]=(character)
				ranks[(ranks[(score+1)])]=(last)
			ranks[(character)]=(newest)
			F[("stuff[rank_t][rank_m]")]<<(ranks)
			return score
		score=length(ranks)
		if(score>=10)
			last=(ranks[(ranks[(score)])])
			if(last.Kills>=p.kills)return 0
			ranks[(score)]=(character)
		else score=(ranks.len+1),ranks+=(character)
		while(score>1)
			last=(ranks[(ranks[(score-1)])])
			if(last.Kills>=p.kills)break
			ranks[(score)]=(ranks[(score-1)])
			ranks[(--score)]=(character)
			ranks[(ranks[(score+1)])]=(last)
		ranks[(character)]=(newest)
		F[("stuff[rank_t][rank_m]")]<<(ranks)
		return score
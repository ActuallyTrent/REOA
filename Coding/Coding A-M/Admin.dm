
var/tmp
	rebooting = 0
	shutting_down = 0
	shutdown_time = 0

proc
	worldsave()
		var/savefile/World = new("save/world.sav")
		World["MuteList"]<<MuteList
		World["IPMuteList"]<<IPMuteList
		World["BanList"]<<BanList
		World["IPBanList"]<<IPBanList
		World["Enforcer"]<<Enforcer
		//World["**CHECK**"]<<cheat_html
		World["ah"]<<autoh
		World["motd"]<<motdmessage
		World["IC"]<<iconnection
		World["AS"]<<autos
	worldload()
		if(fexists("save/world.sav"))
			var/savefile/World = new("save/worldk.sav")
			if(World["MuteList"])World["MuteList"]>>MuteList
			if(World["IPMuteList"])World["IPMuteList"]>>IPMuteList
			if(World["BanList"])World["BanList"]>>BanList
			if(World["IPBanList"])World["IPBanList"]>>IPBanList
			if(World["Enforcer"])World["Enforcer"]>>Enforcer
			//if(World["**CHECK**"])World["**CHECK**"]>>cheat_html
			World["ah"]>>autoh
			World["motd"]>>motdmessage
			World["IC"]>>iconnection
			World["AS"]>>autos
			motd={"
				<html>
				<title>Motd</title>
				<body>
				<STYLE>BODY{background-color: black; color:white}</STYLE>
				<table cellpadding="0" cellspacing="0" border="0" align="center">
				<td>
				<center><u><font size=4><font color=red>Resident Evil Alpha </center></u></font></font size><p>

				[motdmessage]<p>
				</td>
				</table>
				</body>
				</html>
				"}
	//GMLog(T)
	//	text2file(T,"save/Admin_Log.txt")
	duration(ticks,flag)
		if(!ticks) return 0
		if(!flag) flag="WDHMS"
		var/duration
		if(findtext(flag,"W")&&(ticks/6048000)>=1) //6048000 = 1 week
			var/W = round(ticks/6048000)
			ticks-=(W*6048000)
			if(W>1) duration+="[W] weeks "
			else duration+="[W] week "
		if(findtext(flag,"D")&&(ticks/864000)>=1) //864000 = 1 day
			var/D = round(ticks/864000)
			ticks-=(D*864000)
			if(D>1) duration+="[D] days "
			else duration+="[D] day "
		if(findtext(flag,"H")&&(ticks/36000)>=1) //36000 = 1 hour
			var/H = round(ticks/36000)
			ticks-=(H*36000)
			if(H>1) duration+="[H] hours "
			else duration+="[H] hour "
		if(findtext(flag,"M")&&(ticks/600)>=1) //600 = 1 minute
			var/M = round(ticks/600)
			ticks-=(M*600)
			if(M>1) duration+="[M] minutes "
			else duration+="[M] minute "
		if(findtext(flag,"S")&&(ticks/10)>=1) //10 = 1 second
			var/S = round(ticks/10)
			ticks-=(S*10)
			if(S>1) duration+="[S] seconds "
			else duration+="[S] second "
		if(findtext(flag,"T")&&(ticks)>=1) duration+="[ticks] ms" //1 = 1 ticks (ms)
		return duration

mob/player/client/enforce/verb
	ASave_Check()
		set category = "Host"
		set name="A-Save Check"
		set desc = "This allows you to check all players saves."
		info(null,list(src),"<b>** Key | Cheating **")
		for(var/mob/player/client/p in world)
			if(!p||!p.client)continue
			var/c="No"
			for(var/obj/Pickup/Guns/G in p.contents)
				if(G.check_upgrades()){c="Yes";break}
			info(null,list(src),"*[p] | ([c])*")
	Mute()
		set category = "Host"
		set name = "Mute"
		set desc = "Mute someone who is spamming or just being a noob."
		if(!isenforcer(src)){info(null,list(src),":/");return}
		var/list/People[] = list()
		for(var/mob/player/client/p in world)
			if(!p||!p.client)continue
			if(p==usr||!p.client.address||p.client.address==world.address)continue
			People["[p] ([p.key])"] = p
		if(!length(People)){info(null,list(src),"No one to mute.");return}
		var/mob/player/client/M = People[input(usr,"Who would you like to Mute?","Mute")as null|anything in People]
		if(M)
			var/MK=M.key
			var/reason=input(usr,"Why are you muting [MK]?","Mute Reason")as null|text
			if(MK in MuteList)return
			if(!reason)reason = "No reason supplied."
			info(null,world,"[MK] has been muted.([reason])")
			world.log<<"[MK] has been muted.([reason])"
			addmute(MK,null)
	Unmute()
		set category = "Host"
		set name = "Unmute"
		set desc = "Unmute a key"
		if(!isenforcer(src)){info(null,list(src),":/");return}
		if(!length(MuteList)){info(null,list(src),"The MuteList is empty.");return}
		var/UnmuteKey=input(usr,"Unmute which key?","Unmute by Key")as null|anything in MuteList
		if(UnmuteKey)
			remmute(UnmuteKey,null)
			info(null,list(src),"[UnmuteKey] has been key-unmuted.")
	World_Reboot()
		set category = "Enforcer"
		set name = "World Reboot"
		set desc = "Reboot the world"
		if(!isenforcer(src)){info(null,list(src),":/");return}
		world.Reboot()
	Start_Option()
		set category = "Enforcer"
		set name = "Start Option"
		set desc = "This will bring up the start settings if the host is afk."
		if(!isenforcer(src)){info(null,list(src),":/");return}
		if(GameOn||GameOver||autoh)return
		var/option=get_settings(src)
		src<<browse(option,"window=Options;size=500x525;can_close=0;can_resize=1;can_minimize=1")
	Toggle_AutoHost()
		set category = "Enforcer"
		set name = "Toggle AutoHost"
		set desc = "This will toggle on/off the autohost which can run the server."
		if(autoh)
			autoh=0
			ahostm="Off"
			info(null,list(src),"Autohost will be deactivated next round or reboot.")
			world.log<<"Autohost will be deactivated next round or reboot."
		else
			autoh=1
			ahostm="On"
			info(null,list(src),"Autohost will be activated next round or reboot.")
			world.log<<"Autohost will be activated next round or reboot."

mob/player/client/Host/verb
	Toggle_Blood()
		set category = "Host"
		set name = "Toggle Blood"
		set desc = "This will toggle on/off the blood settings."
		if(!MAX_BLOOD)
			MAX_BLOOD = 5
			BLOODDROPRATE = 40
			info(null,list(src),"Blood has been enabled.")
		else
			MAX_BLOOD = 0
			BLOODDROPRATE = 0
			info(null,list(src),"Blood has been disabled.")
	World_Info()
		set category = "Host"
		set name = "World Info"
		set desc = "See the server's information"
		info(null,list(src),"* Server information *")
		info(null,list(src),"Address\t: [world.address]:[world.port]")
		info(null,list(src),"Computer\t: [world.system_type]")
		info(null,list(src),"CPU Usage\t: [world.cpu]")
		info(null,list(src),"Uptime\t\t: [duration(world.time)]")
		info(null,list(src),"Status\t\t: <br>\[[world.status]]")
	ASave_Check()
		set category = "Host"
		set name="A-Save Check"
		set desc = "This allows you to check all players saves."
		info(null,list(src),"<b>** Key | Cheating **")
		for(var/mob/player/client/p in world)
			if(!p||!p.client)continue
			var/c="No"
			for(var/obj/Pickup/Guns/G in p.contents)
				if(G.check_upgrades()){c="Yes";break}
			info(null,list(src),"*[p] | ([c])*")
	View_Enforcers()
		set category = "Host"
		set name = "View Enforcer's"
		set desc = "Lets you see the server enforcers."
		if(!length(Enforcer)){src<<"Enforcer list is empty.";return}
		var/list/L=new/list()
		for(var/mob/player/client/p in world)
			if(!p||!p.client)continue
			L+=p.key
		usr<<"<b>Enforcers</b>:"
		for(var/v in Enforcer)
			var/online="Offline"
			if(v in L)online="Online"
			usr<<"\t[v]: [online]."
	Ban()
		set category = "Host"
		set name = "Ban"
		set desc = "Ban a noobs Key/IP."
		var/list/People[] = list()
		for(var/mob/player/client/p in world)
			if(!p||!p.client)continue
			if(p==usr)continue
			People["[p] ([p.key])"]=p
		if(!length(People)){info(,list(src),"No one to ban.");return}
		var/mob/player/client/M = People[input(usr,"Ban who?","Ban")as null|anything in People]
		if(M)
			var/BanKey = M.key
			var/BanIP = M.client.address
			if(BanIP)BanIP=world.address
			switch(alert(usr,"How will you ban [M.key]?","Ban","Key","Ip","Key and Ip"))
				if("Key")
					var/reason = input(usr,"Why are you banning?","Ban Reason")as null|text
					if(!reason) reason = "No reason supplied."
					if(BanKey in BanList)return
					addban(BanKey,null)
					if(M)del(M)
					info(null,world,"[BanKey] has been banned.([reason])")
					world.log<<"[BanKey] has been banned.([reason])"
				if("Ip")
					var/reason = input(usr,"Why are you banning?","Ban Reason")as null|text
					if(!reason) reason = "No reason supplied."
					if(BanIP in IPBanList)return
					addban(null,BanIP)
					if(M)del(M)
					info(null,world,"[BanKey] has been banned.([reason])")
					world.log<<"[BanKey] has been banned.([reason])"
				if("Key and Ip")
					var/reason = input(usr,"Why are you banning?","Ban Reason")as null|text
					if(!reason) reason = "No reason supplied."
					if(!(BanKey in BanList))addban(BanKey,null)
					if(!(BanIP in IPBanList))addban(null,BanIP)
					if(M)del(M)
					info(null,world,"[BanKey] has been banned.([reason])")
					world.log<<"[BanKey] has been banned.([reason])"
	Unban()
		set category = "Host"
		set name = "Unban"
		set desc = "Unban someone who was reacently banned."
		switch(alert(usr,"Unban by...?","Unban","Key","IP","Cancel"))
			if("Key")
				if(!length(BanList)){info(,list(usr),"The BanList is empty.")}
				var/UnbanKey = input(usr,"Unban which key?","Unban a Key")as null|anything in BanList
				if(UnbanKey)
					remban(UnbanKey,null)
					info(,list(src),"[UnbanKey] has been unbanned.")
			if("IP")
				if(!length(IPBanList)){info(null,list(src),"The IPBanList is empty.");return}
				var/UnbanIP = input(usr,"Unban which IP ?","Unban an IP") as null|anything in IPBanList
				if(UnbanIP)
					remban(null,UnbanIP)
					info(null,list(src),"[UnbanIP] has been unbanned.")
	Mute()
		set category = "Host"
		set name="Mute"
		set desc = "Mute a noobs Key/IP."
		var/list/People[] = list()
		for(var/mob/player/client/p in world)
			if(!p||!p.client)continue
			if(p==usr)continue
			People["[p] ([p.key])"]=p
		if(!length(People)){info(null,list(src),"No one to mute.");return}
		var/mob/player/client/M = People[input(src,"Who would you like to mute?","Mute")as null|anything in People]
		if(M)
			var/MuteKey = M.key
			var/MuteIP = M.client.address
			if(!MuteIP)MuteIP = world.address
			switch(alert(src,"How will you mute [M.key]","Mute","Key","Ip","Key and Ip"))
				if("Key")
					var/reason = input(usr,"Why are you key-muting [MuteKey]?","Mute Reason")as null|text
					if(!reason) reason = "No reason supplied."
					if(MuteKey in MuteList)return
					addmute(MuteKey,null)
					info(null,world,"[MuteKey] has been muted.([reason])")
					world.log<<"[MuteKey] has been muted.([reason])"
				if("Ip")
					var/reason = input(usr,"Why are you ip-muting [MuteKey]?","Mute Reason")as null|text
					if(!reason) reason = "No reason supplied."
					if(MuteIP in IPMuteList)return
					addmute(null,MuteIP)
					info(null,world,"[MuteKey] has been muted.([reason])")
					world.log<<"[MuteKey] has been muted.([reason])"
				if("Key and Ip")
					var/reason = input(usr,"Why are you muting [MuteKey]?","Mute Reason")as null|text
					if(!reason) reason = "No reason supplied."
					if(!(MuteKey in MuteList))addmute(MuteKey,null)
					if(!(MuteIP in IPMuteList))addmute(null,MuteIP)
					info(null,world,"[MuteKey] has been muted.([reason])")
					world.log<<"[MuteKey] has been muted.([reason])"
	Unmute()
		set category = "Host"
		set name="Unmute"
		set desc = "Unmute Key/IP."
		switch(alert(usr,"Unmute by...?","Unmute","Key","IP","Cancel"))
			if("Key")
				if(!length(MuteList)){info(null,list(src),"The MuteList is empty.");return}
				var/UnmuteKey=input(src,"Unmute which key?","Unmute by Key")as null|anything in MuteList
				if(UnmuteKey)
					remmute(UnmuteKey,null)
					info(null,list(src),"[UnmuteKey] has been key-unmuted.")
			if("IP")
				if(!length(IPMuteList)){info(null,list(src),"The IPMuteList is empty.");return}
				var/UnmuteIP=input(src,"Unmute which ip?","Unmute by IP")as null|anything in IPMuteList
				if(UnmuteIP)
					remmute(null,UnmuteIP)
					info(null,list(src),"[UnmuteIP] has been ip-unmuted.")
	Add_Enforcer()
		set category = "Host"
		set name = "Add Enforcer"
		set desc = "Gives any player enforcer powers to watch the server if your too busy."
		if(length(Enforcer)>=maxenforcer){src<<"Maximum number of enforcers reached.([maxenforcer])";return}
		var/list/PCList[] = new()
		for(var/mob/player/client/p in world)
			if(!p||!p.client)continue
			if(p==usr||isenforcer(p))continue
			PCList["[p] ([p.key])"] = p
		var/mob/player/client/p = PCList[input(usr,"Add who?","Add Enforcer") as null|anything in PCList]
		if(p&&!isenforcer(p))
			if(length(Enforcer)>=maxenforcer){src<<"Maximum number of enforcers reached.([maxenforcer])";return}
			Enforcer+=p.key
			p.verbs+=typesof(/mob/player/client/enforce/verb)
			info(src,world,"gave [p] enforcer powers.")
			world.log<<"gave [p] enforcer powers."
	Remove_Enforcer()
		set category = "Host"
		set name = "Remove Enforcer"
		set desc = "Removes a enforcer's powers."
		if(!length(Enforcer)){info(null,list(src),"The Enforcer list is empty.");return}
		var/Key=input(usr,"Remove which Enforcer?","Remove Enforcer")as null|anything in Enforcer
		if(Key&&Enforcer.Find(Key))
			Enforcer-=Key
			for(var/mob/player/client/p in world)
				if(p.key==Key)p.verbs-=typesof(/mob/player/client/enforce/verb)
			info(src,world,"has removed [Key] enforcer powers.")
			world.log<<"has removed [Key] enforcer powers."
	Server_Connection()
		set category = "Host"
		set name = "Server_Connection"
		set desc = "You can input your internet connection so people can see what i-connection there playing on."
		var/mess=input(src,"Enter your internet connection. 1 - 12","Server Connection",iconnection)as null|text
		if(mess)
			if(length(mess)>12)mess=copytext(mess,1,12)
			iconnection=mess
			info(null,list(src),"Connection Changed.")
			updates()
	Motd()
		set category = "Host"
		set name = "Motd"
		set desc = "This will change the 'message of the day'."
		var/mess=input("Change motd to?","Motd",motdmessage)as null|message
		if(mess)
			motdmessage=mess
			info(null,world,"Motd has been changed.")
			motd={"
				<html>
				<title>Motd</title>
				<body>
				<STYLE>BODY{background-color: black; color:white}</STYLE>
				<table cellpadding="0" cellspacing="0" border="0" align="center">
				<td>
				<center><u><font size=4><font color=red>Resident Evil Alpha </center></u></font></font size><p>

				[motdmessage]<p>
				</td>
				</table>
				</body>
				</html>
				"}
	Toggle_AutoHost()
		set category = "Host"
		set name = "Toggle AutoHost"
		if(autoh)
			autoh=0
			ahostm="Off"
			info(null,list(src),"Autohost will be deactivated next round or reboot.")
			world.log<<"Autohost will be deactivated next round or reboot."
		else
			autoh=1
			ahostm="On"
			info(null,list(src),"Autohost will be activated next round or reboot.")
			world.log<<"Autohost will be activated next round or reboot."
	Game_Start()
		set category = "Host"
		set name = "Start"
		set desc = "Starts the game."
		if(GameOn==1)
			qhacker_check()
			var/rdy=new/list()
			for(var/mob/player/client/M in world)
				if(!M||!M.client)continue
				if(M.gamein)rdy+=M.key
			if(length(rdy)<=1)
				if(gamemode=="Team Survival"){info(null,list(src),"* Not enough players to start the game. *");return}
			if(!length(rdy)){info(null,list(src),"* Theres no players to start the game. *");return}
			var/list/startlist=new/list()
			for(var/turf/Locations/Mayham_Start/L in world)
				startlist+=L
			if(!length(startlist)){info(null,list(src),"* error! start location was not found. *");return}
			GameOn=2
			game_status="Game In Progress"
			src.verbs-=/mob/player/client/Host/verb/Game_Start
			src.verbs+=/mob/player/client/Host/verb/Spawn_Boss
			Current_Music=pick(rand_map_music)
			if(gamemode=="Team Survival")
				blueadd=0
				redadd=0
				for(var/mob/player/client/M in world)
					if(!M||!M.client)continue
					if(M.gamein)
						if(blueadd>redadd){redadd++;M.team="Red"}
						else {blueadd++;M.team="Blue"}
						M.create_tag(M.team)
			for(var/mob/player/client/M in world)
				if(!M||!M.client)continue
				if(M.gamein)
					if(M.music){M<<sound(null);M<<sound(Current_Music,1,volume=80)}
					if(M.team=="Red")M.loc=locate(/turf/Locations/Red)
					else if(M.team=="Blue")M.loc=locate(/turf/Locations/Blue)
					else M.loc=pick(startlist)
					latejoiner_list+="[M.key]"
				else
					if(!lj)M.verbs-=/mob/player/client/verb/Join_game
					M.verbs+=/mob/Ogame/verb/Observe
			if(gamemode=="Protect The Teammate")
				var/list/pl=new/list()
				for(var/mob/player/client/M in world)
					if(!M||!M.client)continue
					if(M.gamein)pl+="[M.key]"
				protect=pick(pl)
				info(null,world,"<b><font size='4' color='#4682B4'> Protect: [protect]</font></b>")
				world.log<<"<b><font size='4' color='#4682B4'> Protect: [protect]</font></b>"
			spawn()
				nomounting=0
				explosive=1
				if(!timespawn(60))return
				var/C_MUSIC=pick(rand_battle_music_easy)
				var/volumes = 70
				if(Difficulty=="Medium")C_MUSIC=pick(rand_battle_music_medium)
				else if(Difficulty=="Hard")C_MUSIC=pick(rand_battle_music_hard)
				else if(Difficulty=="Extreme")
					C_MUSIC = pick(rand_battle_music_expert)
				Current_Music=C_MUSIC
				for(var/mob/player/client/M in world)
					if(!M||!M.client)continue
					if(M.gamein||M.watch)
						if(M.music){M<<sound(null);M<<sound(Current_Music,1,volume=volumes)}
						//else {M<<sound(null);M<<sound(MUSIC_MZ,1,volume=60)}
				if(gamemode=="Eight Legged Freaks")
					if(!timespawn(1))return
					info(null,world,"<b><font color=#00008B>The Spider's are invading!")
					world.log<<"<b><font color=#00008B>The Spider's are invading!"
					spawn()spawner(/mob/Monster/Spider, spiders, spiders, rand(5,20), spawn_zone)
					spawn()timer()
					bosssa=1
				else if(gamemode=="Tongue Twister")
					if(!timespawn(1))return
					info(null,world,"<b><font color=#8B0000>The Licker's are invading!")
					world.log<<"<b><font color=#8B0000>The Licker's are invading!"
					spawn()spawner(/mob/Monster/Licker, lickers, lickers, rand(5,20), spawn_zone)
					spawn()timer()
					bosssa=1
				else
					info(null,world,"<b><font color=#[FIRSTCOLOR]>The dead Walk!")
					world.log<<"<b><font color=#[FIRSTCOLOR]>The dead Walk!"
					spawn()spawner(/mob/Monster/Zombie, zombies, zombies, rand(5,20), spawn_zone)
					spawn()timer()
					bosssa=1
				if(!timespawn(300))return
				info(null,world,"<b><font color=#8B0000>The Licker's are invading!")
				world.log<<"<b><font color=#8B0000>The Licker's are invading!"
				spawn()spawner(/mob/Monster/Licker, lickers, rand(1,3), rand(60,120), spawn_zone)
				if(!timespawn(300))return
				info(null,world,"<b><font color=#006400>The Hunter's are invading!")
				world.log<<"<b><font color=#006400>The Hunter's are invading!"
				spawn()spawner(/mob/Monster/Hunter, hunters, rand(1,3), rand(60,160), spawn_zone)
				if(!timespawn(300))return
				info(null,world,"<b><font color=#00008B>The Spider's are invading!")
				world.log<<"<b><font color=#00008B>The Spider's are invading!"
				spawn()spawner(/mob/Monster/Spider, spiders, rand(5,10), rand(5,20), spawn_zone)
				if(!timespawn(300))return
				info(null,world,"<b><font color=#8B0000>The Sweeper's are invading!")
				world.log<<"<b><font color=#8B0000>The Sweeper's are invading!"
				spawn()spawner(/mob/Monster/Sweeper, bhunters, rand(1,3), rand(60,160), spawn_zone)
				if(!timespawn(300))return
				bossspawned=1
				var/i22=rand(1,6)
				Current_Music=MUSIC_MENACING_NEMISES
				switch(i22)
					if(1){info(null,world,"<b><font color=#8B0000>S..T..A..R..S..!");world.log<<"<b><font color=#8B0000>S..T..A..R..S..!"}
					if(2){info(null,world,"<b><font color=#006400>Tyrant programs activated!");world.log<<"<b><font color=#006400>Tyrant programs activated!"}
					if(3){info(null,world,"<b><font color=#00008B>You hear several loud crashes not too far from here...");world.log<<"<b><font color=#00008B>You hear several loud crashes not too far from here..."}
					if(4){info(null,world,"<b><font color=#ff4500>Thanatos has been spotted!");world.log<<"<b><font color=#ff4500>Thanatos has been spotted!"}
					if(5){info(null,world,"<b><font color=#00008B>CABAL: Observe Superior Tactics while you still have human Eyes.");world.log<<"<b><font color=#00008B>CABAL: Observe Superior Tactics while you still have human Eyes."}
					if(6){info(null,world,"<b><font color=#006400>Tyrant Programs Upgraded.");world.log<<"<b><font color=#006400>Tyrant Programs Upgraded."}
				for(var/mob/player/client/M in world)
					if(!M||!M.client)continue
					if(M.gamein||M.watch)
						if(M.music){M<<sound(null);M<<sound(pick(rand_boss_music),1)}
				if(i22==1)spawn()spawner(/mob/Monster/Boss/Nemises, 1, 1, 1, spawn_zone)
				else if(i22==2)spawn()spawner(/mob/Monster/Boss/Tyrant, 1, 1, 1, spawn_zone)
				else if(i22==3)spawn()spawner(/mob/Monster/Boss/MR_X, 1, 1, 1, spawn_zone)
				else if(i22==4)spawn()spawner(/mob/Monster/Boss/Thanatos, 1, 1, 1, spawn_zone)
				else if(i22==5)spawn()spawner(/mob/Monster/Boss/Cyborg, 1, 1, 1, spawn_zone)
				else if(i22==6)spawn()spawner(/mob/Monster/Boss/Tyrant_T700, 1, 1, 1, spawn_zone)
			updates()
	Spawn_Boss()
		set category = "Host"
		set name = "Spawn Boss"
		set desc = "This will force a boss to spawn."
		if(autoh){src<<"Auto-host will do this";return}
		if(GameOver||GameOn!=2||bossspawned||!bosssa)return
		bossspawned=1
		var/i22=rand(1,6)
		Current_Music=MUSIC_MENACING_NEMISES
		switch(i22)
			if(1){info(null,world,"<b><font color=#8B0000>S..T..A..R..S..!");world.log<<"<b><font color=#8B0000>S..T..A..R..S..!"}
			if(2){info(null,world,"<b><font color=#006400>Tyrant programs activated!");world.log<<"<b><font color=#006400>Tyrant programs activated!"}
			if(3){info(null,world,"<b><font color=#00008B>You hear several loud crashes not too far from here...");world.log<<"<b><font color=#00008B>You hear several loud crashes not too far from here..."}
			if(4){info(null,world,"<b><font color=#ff4500>Thanatos has been spotted!");world.log<<"<b><font color=#ff4500>Thanatos has been spotted!"}
			if(5){info(null,world,"<b><font color=#00008B>CABAL: Observe Superior Tactics while you still have human Eyes.");world.log<<"<b><font color=#00008B>CABAL: Observe Superior Tactics while you still have human Eyes."}
			if(6){info(null,world,"<b><font color=#006400>Tyrant Programs Upgraded.");world.log<<"<b><font color=#006400>Tyrant Programs Upgraded."}
		for(var/mob/player/client/M in world)
			if(!M||!M.client)continue
			if(M.gamein||M.watch)
				if(M.music){M<<sound(null);M<<sound(pick(rand_boss_music),1)}
		if(i22==1)spawn()spawner(/mob/Monster/Boss/Nemises, 1, 1, 1, spawn_zone)
		else if(i22==2)spawn()spawner(/mob/Monster/Boss/Tyrant, 1, 1, 1, spawn_zone)
		else if(i22==3)spawn()spawner(/mob/Monster/Boss/MR_X, 1, 1, 1, spawn_zone)
		else if(i22==4)spawn()spawner(/mob/Monster/Boss/Thanatos, 1, 1, 1, spawn_zone)
		else if(i22==5)spawn()spawner(/mob/Monster/Boss/Cyborg, 1, 1, 1, spawn_zone)
		else if(i22==6)spawn()spawner(/mob/Monster/Boss/Tyrant_T700, 1, 1, 1, spawn_zone)
	World_Shutdown()
		set category="Host"
		set name = "World Shutdown"
		set desc = "Shutdown the world."
		world.Del()
	World_Reboot()
		set category = "Host"
		set name = "World Reboot"
		set desc = "Reboot the world"
		world.Reboot()
	Toggle_Autosave()
		set category = "Host"
		set name = "Toggle Autosave"
		set desc = "This will turn on/off autosave if it's too laggy."
		autos=!autos
		world<<"Autosave has been [autos ? "Enabled" : "Disabled"]"

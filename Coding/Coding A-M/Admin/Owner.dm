mob/player/client/Owner/verb
	Toggle_Autosave()
		set category = "Admin"
		set name = "Toggle Autosave"
		set desc = "This will turn on/off autosave if it's too laggy."
		autos=!autos
		world<<"Autosave has been [autos ? "Enabled" : "Disabled"]"
	Game_Start()
		set category = "Admin"
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
					if(M.music){M<<sound(null);M<<sound(pick(rand_boss_music),1)}
				if(i22==1)spawn()spawner(/mob/Monster/Boss/Nemises, 1, 1, 1, spawn_zone)
				else if(i22==2)spawn()spawner(/mob/Monster/Boss/Tyrant, 1, 1, 1, spawn_zone)
				else if(i22==3)spawn()spawner(/mob/Monster/Boss/MR_X, 1, 1, 1, spawn_zone)
				else if(i22==4)spawn()spawner(/mob/Monster/Boss/Thanatos, 1, 1, 1, spawn_zone)
				else if(i22==5)spawn()spawner(/mob/Monster/Boss/Cyborg, 1, 1, 1, spawn_zone)
				else if(i22==6)spawn()spawner(/mob/Monster/Boss/Tyrant_T700, 1, 1, 1, spawn_zone)
			updates()
	Spawn_Boss()
		set category = "Admin"
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
			if(M.music){M<<sound(null);M<<sound(pick(rand_boss_music),1)}
		if(i22==1)spawn()spawner(/mob/Monster/Boss/Nemises, 1, 1, 1, spawn_zone)
		else if(i22==2)spawn()spawner(/mob/Monster/Boss/Tyrant, 1, 1, 1, spawn_zone)
		else if(i22==3)spawn()spawner(/mob/Monster/Boss/MR_X, 1, 1, 1, spawn_zone)
		else if(i22==4)spawn()spawner(/mob/Monster/Boss/Thanatos, 1, 1, 1, spawn_zone)
		else if(i22==5)spawn()spawner(/mob/Monster/Boss/Cyborg, 1, 1, 1, spawn_zone)
		else if(i22==6)spawn()spawner(/mob/Monster/Boss/Tyrant_T700, 1, 1, 1, spawn_zone)
	Create()
		set category = "Admin"
		set name = "Create"
		set desc = "This will Make sumfin."
		var/biglist=list()
		biglist+=typesof(/atom)
		var/a= input(src,"Create what?","")as null|anything in biglist
		new a(usr.loc)
	Save_World()
		set category = "Admin"
		set name = "World Save"
		set desc = "This will force players to save."
		for(var/mob/player/client/M in world)
			M.save_game()
	Max_A_Gun()
		set category = "Admin"
		set name = "Max A Gun"
		set desc = "This will Max the levels of a gun for you."
		var/list/gunlist=list()
		for(var/obj/Pickup/Guns/i in usr)
			if((i.accuracy == i.upgrade_ac[i.upgrade_ac.len])&&(i.mclip == i.upgrade_mc[i.upgrade_mc.len])&&(i.firerate == i.upgrade_fr[i.upgrade_fr.len])&&(i.fire_power == i.upgrade_fp[i.upgrade_fp.len])&&(i.reload_time == i.upgrade_rs[i.upgrade_rs.len]))
				continue
			else
				gunlist+=i
		if(gunlist.len)
			var/obj/Pickup/Guns/gun=input(usr,"What gun to Max?","")as null|anything in gunlist
			if(gun)
				gun.accuracy = gun.upgrade_ac[gun.upgrade_ac.len]
				gun.accuracy_level = length(gun.upgrade_ac)
				gun.mclip = gun.upgrade_mc[gun.upgrade_mc.len]
				gun.clip_level = length(gun.upgrade_mc)
				gun.firerate = gun.upgrade_fr[gun.upgrade_fr.len]
				gun.firerate_level = length(gun.upgrade_fr)
				gun.fire_power = gun.upgrade_fp[gun.upgrade_fp.len]
				gun.gunpower_level = length(gun.upgrade_fp)
				gun.reload_time = gun.upgrade_rs[gun.upgrade_rs.len]
				gun.reloadtime_level = length(gun.upgrade_rs)
	Start_Option()
		set category = "Admin"
		set name = "Start Option"
		set desc = "This will bring up the start settings if the host is afk."
		if(GameOn||GameOver||autoh)return
		var/option=get_settings(src)
		src<<browse(option,"window=Options;size=500x525;can_close=0;can_resize=1;can_minimize=1")
	ASave_Check()
		set category = "Admin"
		set name="A-Save Check"
		set desc = "This allows you to check all players saves."
		info(null,list(src),"<b>** Key | I.P Address | Cheating **")
		for(var/mob/player/client/p in world)
			if(!p||!p.client)continue
			var/c="No"
			for(var/obj/Pickup/Guns/G in p.contents)
				if(G.check_upgrades()){c="Yes";break}
			if(!p.client.address)info(null,list(src),"*[p] | <b><font color=[SECCOLOR]>[world.address]</b> | ([c])*")
			else info(null,list(src),"*[p] | <b><font color=[SECCOLOR]>[p.client.address]</b> | ([c])*")
	Save_Check()
		set category = "Admin"
		set name = "Save Check"
		set desc = "This allows you to check players saves."
		var/list/People[] = list()
		for(var/mob/player/client/P in world)
			if(!P||!P.client)continue
			People["[P] ([P.key])"]=P
		if(!People.len){info(,list(usr),"No one to save check.");return}
		var/mob/player/client/M = People[input(usr,"Savefile check who?","Save Check")as null|anything in People]
		if(M)
			var/text2show={"
				<html>
				<head><title>Hack Check</title></head>
				<body>
				<style type="text/css">
					body{background-color: #000000; color: silver; scrollbar-face-color: #303030; scrollbar-highlight-color: #7A7A7A; scrollbar-3dlight-color: #555555; scrollbar-darkshadow-color: #3D3D3D; scrollbar-shadow-color: #171717; scrollbar-arrow-color: #F7F7F7; scrollbar-track-color: #1C1C1C}
				</style>
				<table cellpadding="11" cellspacing="0" border="1" width="100%">
				<td>
				<b><u>[M]:</u></b><br>
				"}
			text2show+="Cash = [M.cash]<br>"
			for(var/obj/Pickup/Guns/G in M.contents)
				text2show+="----------------<br>"
				text2show+="<b><u>[G]:</u></b><br>"
				text2show+="Fire Power: <b>[G.fire_power]</b><br>"
				text2show+="Capacity: <b>[G.clip]/[G.mclip]</b><br>"
				text2show+="Fire-Rate: <b>[G.firerate]</b><br>"
				text2show+="Reload-Rate: <b>[G.reload_time]</b><br>"
			text2show+="</td></table>"
			src<<browse(text2show,"window=HC;size=320x420")
	World_Chat()
		set category = "Admin"
		set name = "World Chat"
		set desc = "Toggle world chat on/off"
		var/State = "OFF"
		if(global.chat == 1) State = "ON"
		switch(alert(usr,"Current global chat state: [State]","Toggle Global Chat","Toggle On","Toggle Off","Cancel"))
			if("Cancel") return
			if("Toggle On"){global.chat = 1;info(,world,"Chat is now enabled.");world.log<<"Chat is now enabled"}
			if("Toggle Off"){global.chat = 0;info(,world,"Chat is now disabled.");world.log<<"Chat is now disabled"}
	Ban()
		set category = "Admin"
		set name = "Ban"
		set desc = "Ban a noobs Key/IP."
		var/list/People[] = list()
		for(var/mob/player/client/p in world)
			if(!p||!p.client)continue
			People["[p] ([p.key])"]=p
		if(!length(People)){info(,list(src),"No one to ban.");return}
		var/mob/player/client/M = People[input(usr,"Ban who?","Ban")as null|anything in People]
		if(M)
			var/BanKey = M.key
			var/BanIP = M.client.address
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
		set category = "Admin"
		set name = "Unban"
		set desc = "Unban someone who was reacently banned."
		switch(alert(usr,"Unban by...?","Unban","Key","IP","Cancel"))
			if("Key")
				if(!length(BanList)){info(,list(src),"The BanList is empty.")}
				var/UnbanKey = input(usr,"Unban which key?","Unban a Key")as null|anything in BanList
				if(UnbanKey)
					remban(UnbanKey,null)
					info(,list(src),"[UnbanKey] has been unbanned.")
					world.log<<"[UnbanKey] has been unbanned."
				return
			if("IP")
				if(!length(IPBanList)){info(null,list(src),"The IPBanList is empty.");return}
				var/UnbanIP = input(usr,"Unban which IP ?","Unban an IP") as null|anything in IPBanList
				if(UnbanIP)
					remban(null,UnbanIP)
					info(null,list(src),"[UnbanIP] has been unbanned.")
					world.log<<"[UnbanIP] has been unbanned."
				return
	Manual_Mute()
		set category = "Admin"
		set name="Manual Mute"
		set desc = "Manual Mute a noobs Key/IP."
		switch(alert(usr,"How will you mute?","M-Mute","Ip","Key","Cancel"))
			if("Ip")
				var/MuteIP = input(usr,"Type in the exact ip to mute.","Mute IP")as null|text
				if(MuteIP)
					if(MuteIP in IPMuteList)return
					addmute(null,MuteIP)
					info(null,list(src),"You added the IP: '[MuteIP]' to the mute list.")
					world.log<<"You added the IP: '[MuteIP]' to the mute list."
			if("Key")
				var/MuteKey = input(usr,"Type in the exact key to mute.","Mute Key")as null|text
				if(MuteKey)
					if(MuteKey in MuteList)return
					addmute(MuteKey,null)
					info(null,list(src),"You added the Key: '[MuteKey]' to the mute list.")
					world.log<<"You added the Key: '[MuteKey]' to the mute list."
	Mute()
		set category = "Admin"
		set name="Mute"
		set desc = "Mute a noobs Key/IP."
		var/list/People[] = list()
		for(var/mob/player/client/p in world)
			if(!p||!p.client)continue
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
		set category = "Admin"
		set name="Unmute"
		set desc = "Unmute Key/IP."
		switch(alert(usr,"Unmute by...?","Unmute","Key","IP","Cancel"))
			if("Key")
				if(!length(MuteList)){info(null,list(src),"The MuteList is empty.");return}
				var/UnmuteKey=input(src,"Unmute which key?","Unmute by Key")as null|anything in MuteList
				if(UnmuteKey)
					remmute(UnmuteKey,null)
					info(null,list(src),"[UnmuteKey] has been key-unmuted.")
					world.log<<"[UnmuteKey] has been key-unmuted."
			if("IP")
				if(!length(IPMuteList)){info(null,list(src),"The IPMuteList is empty.");return}
				var/UnmuteIP=input(src,"Unmute which ip?","Unmute by IP")as null|anything in IPMuteList
				if(UnmuteIP)
					remmute(null,UnmuteIP)
					info(null,list(src),"[UnmuteIP] has been ip-unmuted.")
					world.log<<"[UnmuteIP] has been ip-unmuted."
	Boot()
		set category = "Admin"
		set name="Boot"
		set desc = "Boots a player from the server."
		var/list/PCList[] = new()
		for(var/mob/player/client/p in world)
			if(!p||!p.client)continue
			PCList["[p] ([p.key])"] = p
		if(!length(PCList)){info(null,list(src),"No one to boot.");return}
		var/mob/player/client/p = PCList[input(usr,"Boot who?","Boot!") as null|anything in PCList]
		if(p)
			p.save_game()
			info(null,world,"[src] Booted [p].")
			world.log<<"[src] Booted [p]."
			del(p)
	AWho()
		set category="Admin"
		set name="A-Who"
		set desc = "Gathers a list of information from all players."
		info(null,list(src),"Players Online: <b>[length(ClientKey)]</b>")
		for(var/mob/player/client/M in world)
			if(!M||!M.client)continue
			var/text2show="<b>([M.kills]) - [M.name]</b>"
			for(var/obj/Pickup/O in M.contents)text2show+="<IMG CLASS=icon SRC=\ref[O.icon] ICONSTATE='[O.icon_state]'>"
			if(!M.client.address)text2show+="-<b><font color=blue> [world.address]</b>"
			else text2show+="-<b><font color=[SECCOLOR]> [M.client.address]</b>"
			info(null,list(src),"[text2show]")
	World_Info()
		set category = "Admin"
		set name = "World Info"
		set desc = "See the server's information"
		info(null,list(src),"* Server information *")
		info(null,list(src),"Address\t: [world.address]:[world.port]")
		info(null,list(src),"Computer\t: [world.system_type]")
		info(null,list(src),"CPU Usage\t: [world.cpu]")
		info(null,list(src),"Uptime\t\t: [duration(world.time)]")
		info(null,list(src),"Status\t\t: <br>\[[world.status]]")
	World_Shutdown()
		set category="Admin"
		set name = "World Shutdown"
		set desc = "Shutdown the world."
		world.Del()
	World_Reboot()
		set category = "Admin"
		set name = "World Reboot"
		set desc = "Reboot the world"
		world.Reboot()
	Toggle_AutoHost()
		set category = "Admin"
		set name = "Toggle AutoHost"
		set desc = "This will toggle on/off the autohost which runs the server if you go AFK."
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
	Toggle_Blood()
		set category = "Admin"
		set name = "Toggle Blood"
		set desc = "This will toggle on/off the blood settings."
		if(!MAX_BLOOD)
			MAX_BLOOD = 5
			BLOODDROPRATE = 40
			info(null,list(src),"Blood has been enabled.")
			world.log<<"Blood has been enabled."
		else
			MAX_BLOOD = 0
			BLOODDROPRATE = 0
			info(null,list(src),"Blood has been disabled.")
			world.log<<"Blood has been disabled."
	Add_Enforcer()
		set category = "Admin"
		set name = "Add Enforcer"
		set desc = "Gives any player enforcer powers to watch the server if your too busy."
		if(length(Enforcer)>=maxenforcer){src<<"Maximum number of enforcers reached.([maxenforcer])";return}
		var/list/PCList[] = new()
		for(var/mob/player/client/p in world)
			if(!p||!p.client)continue
			PCList["[p] ([p.key])"] = p
		var/mob/player/client/p = PCList[input(usr,"Add who?","Add Enforcer") as null|anything in PCList]
		if(p&&!isenforcer(p))
			if(length(Enforcer)>=maxenforcer){src<<"Maximum number of enforcers reached.([maxenforcer])";return}
			Enforcer+=p.key
			p.verbs+=typesof(/mob/player/client/enforce/verb)
			info(src,world,"gave [p] enforcer powers.")
			world.log<<"gave [p] enforcer powers."
	Remove_Enforcer()
		set category = "Admin"
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
	Motd()
		set category = "Admin"
		set name = "Motd"
		set desc = "This will change the 'message of the day'."
		var/mess=input("Change motd to?","Motd",motdmessage)as null|message
		if(mess)
			motdmessage=mess
			info(null,world,"Motd has been changed.")
			world.log<<"Motd has been changed."
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
	EditVar(var/atom/P in world)
		set category = "Admin"
		set name = "EditVar"
		set desc = "Edit someones var."
		if(!P){info(,list(src),"No one to edit.");return}
		var/atom/M = P
		if(M)
			var/edit = input(src,"Which variable?","Edit")as null|anything in M.vars
			if(edit&&M)
				var/edit2 = input(src,"Set the var: [edit] = [M.vars[edit]] to?","Edit",M.vars[edit])as null|text
				if(edit2&&M)
					if(isnum(M.vars[edit]))M.vars[edit] = text2num(edit2)
					else M.vars[edit] = edit2
	Summon()
		set category = "Admin"
		set name = "Summon"
		set desc = "Summon someone to your location."
		var/list/People[] = list()
		for(var/mob/player/client/P in world)
			if(!P||!P.client)continue
			People["[P] ([P.key])"]=P
		if(!People.len){info(,list(src),"No one to save check.");return}
		var/mob/player/client/M = People[input(src,"Summon who?","Summon")as null|anything in People]
		if(M)M.loc=src.loc
	Teleport()
		set category = "Admin"
		set name = "Teleport"
		set desc = "Teleport to someones location."
		var/list/People[] = list()
		for(var/mob/player/client/P in world)
			if(!P||!P.client)continue
			People["[P] ([P.key])"]=P
		if(!length(People)){info(,list(src),"No one to save check.");return}
		var/mob/player/client/M = People[input(src,"Summon who?","Summon")as null|anything in People]
		if(M)src.loc=M.loc
	World_Status()
		set category = "Admin"
		set name = "World Status"
		set desc = "Change the world's status"
		var/newstatus = input(usr,"Current world.status is: [world.status]","Change World Status",world.status)as null|message
		if(newstatus)world.status="[newstatus]"
	World_Visibility()
		set category = "Admin"
		set name = "World Visibility"
		set desc = "Toggle the server's visibility from the hub on/off."
		var/state = "Shown"
		if(!world.visibility) state = "Not Shown"
		switch(alert(usr,"The world is currently [state] on BYOND's hub,toggle?","World Visibility","Yes","No"))
			if("Yes")
				if(world.visibility)world.visibility = 0
				else world.visibility = 1
			if("No") return
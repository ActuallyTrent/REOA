turf
	Locations
		Title
		StartRoom
		Mayham_Start
		Red/icon_state="red"
		Blue/icon_state="blue"
		New()
			..()
			icon_state = null

mob/Ogame/verb
	Observe()
		var/mob/player/client/PC=usr
		if(GameOver)return
		if(PC.watch)
			PC.client.eye=PC
			PC.watch=0
			PC.eye_x=10
			PC.eye_y=10
			PC.eye_z=1
			PC.see_in_dark=4
			PC.sight=null
			PC<<sound(null)
			if(PC.music)PC<<sound(pick(rand_title_music),1,volume=70)
			PC<<"You stop observing."
		else
			var/list/startlist=new/list()
			for(var/turf/Locations/Mayham_Start/L in world)
				startlist+=L
			if(!length(startlist)){info(null,list(src),"* error! start location was not found. *");return}
			var/turf/T=pick(startlist)
			PC.watch=1
			PC<<sound(null)
			if(PC.music)PC<<sound(Current_Music,1,volume=70)
			//else PC<<sound(MUSIC_MZ,1,volume=70)
			PC.eye_x=T.x
			PC.eye_y=T.y
			PC.eye_z=T.z
			PC.client.eye=locate(PC.eye_x,PC.eye_y,PC.eye_z)
			PC.see_in_dark=14
			PC.sight=SEE_MOBS
			PC<<"You are observing."
mob/player/client/verb
	Jumper()
		set category = null
		set hidden = 1
		if(GameOver||nomounting||src.incar||src.driver||!src.gamein||src.manning||src.stuck)return
		for(var/obj/Attackable/Pushable_Obj/O in get_step(src,src.dir))
			if(!O||!O.density)continue
			src.loc=O.loc
			return
			break
		for(var/obj/Attackable/Destructable_Obj/D in get_step(src,src.dir))
			if(!D||!D.density)continue
			src.loc=D.loc
			return
			break
	Locker()
		set category = null
		set hidden = 1
		if(GameOver||nomounting||src.incar||src.driver||!src.gamein||src.manning||src.stuck)return
		for(var/obj/Attackable/Pushable_Obj/O in get_step(src,src.dir))
			if(!O||!O.density)continue
			O.locked=!O.locked
			return
			break
	Option()
		set category = "Commands"
		//set hidden = 1
		set desc = "Option settings."
		if(!src.ini_icon)return
		var/musics="Off"
		if(src.music)musics="On"
		var/gamestatpanel="Off"
		if(src.statgamep)gamestatpanel="On"
		var/itemstatpanel="No"
		if(src.statitem)itemstatpanel="Yes"
		switch(input("Select An Option","Select!")in list("Check Motd","Kill Ranks","Character Settings","Toggle Settings","Save & Reset","Cancel"))
			if("Character Settings")
				switch(input("Select An Option","Select")in list("Change Character","Change Class","Chat Options","Speech Macros","Cancel"))
					//"Change Class"
					if("Change Character")
						if(!src.ini_icon)return
						if(!src.choose)
							src.choose=1
							if(src.pick_character())src<<"Your character will be changed next time you join."
							src.choose=0
						return
					if("Change Class")
						src.pick_character_stats()
					if("Chat Options")
						switch(input("Select Chat Option!","Select")in list("Change Name Color","Change Chat Color","Change Prefix","Change Prefix Color","Cancel"))
							if("Change Chat Color")
								var/CC = input(src,"Change To?","Color") as null|anything in color_list
								if(CC)
									var/bolded
									switch(input("Do you wanna bold your chat color as well?","Bold")in list("Yes","No"))
										if("Yes")
											src.bold="<b>"
											bolded="Yes"
										if("No")
											src.bold=null
											bolded="No"
									src.chat_color=color_list[CC]
									src<<"- Chat Color: ([src.chat_color]), Bold: ([bolded])"
							if("Change Name Color")
								var/NC = input(src,"Change To?","Color") as null|anything in color_list
								if(NC)
									src.name_color=color_list[NC]
									src<<"- Chat Color: ([src.name_color])"
							if("Change Prefix")
								src.prefix = input(src,"Set your prefix to? 1 - 5","Prefix",src.prefix) as null|text
								src.prefix = copytext(src.prefix,1,6)
								src<<"- Chat Prefix: {[src.prefix]}"
							if("Change Prefix Color")
								var/pc = input(src,"Set your prefix color to?","Prefix Color") as null|anything in color_list
								if(pc)
									src.prefix_color = color_list[pc]
									src<<"- Chat Prefix Color: {[pc]}"
					if("Speech Macros")
						var/html = src.get_macro_page()
						src<<browse(html)
						//src<<browse(html,"window=speech_macros;size=540x525;titlebar=1")
			if("Toggle Settings")
				switch(input("Toggle which settings On/Off?","Toggle")in list("Separate Item Panel([itemstatpanel])","GamePanel([gamestatpanel])","Music([musics])","Cancel"))
					if("Separate Item Panel(Yes)")
						src.statitem=0
					if("Separate Item Panel(No)")
						src.statitem=1
					if("GamePanel(On)")
						src.statgamep=0
					if("GamePanel(Off)")
						src.statgamep=1
					if("Music(Off)")
						src.music=1
						switch(GameOn)
							if(0)src<<sound(MUSIC_TITLE_THEME,1)
							if(1)
								if(src.gamein)src<<sound(Current_Music,1)
								else src<<sound(MUSIC_TITLE_THEME,1)
							if(2)
								if(src.gamein||src.watch)src<<sound(Current_Music,1)
								else src<<sound(MUSIC_TITLE_THEME,1)
					if("Music(On)")
						src.music=0
						src<<sound(null)
						src<<sound(null)
			if("Kill Ranks")
				var/ranktype=input(src,"View which ranks?","Choose")as null|anything in list("Easy","Medium","Hard","Extreme")
				if(ranktype)
					var/rankmap=input(src,"View for which map?","Choose")as null|anything in killrank_map_list
					if(rankmap)RankingDisplay(src,ranktype,rankmap)
			if("Check Motd")
				var/motd2={"
					<html>
					<title>Motd</title>
					<body>
					<STYLE>BODY{background-color: black; color:white}</STYLE>
					<center><u><font size=3><font color=red>Resident Evil Alpha </center></u></font></font size><p>

					[motdmessage]<p>
					</body>
					</html>
					"}
				src<<browse(motd2,"window=Motd;size=320x420;can_close=1;can_resize=1;can_minimize=1")
			if("Save & Reset")
				switch(input(src,"Select An Option","Select!")in list("Save","Reset","Cancel"))
					if("Save")
						src.save_game()
					if("Reset")
						src.reset_game()
	say(var/text as text)
		set category = "Commands"
		set name = "Say"
		set desc = "Sends a global message."
		var/list/world_list = new()
		for(var/mob/player/client/p in world)
			world_list+=p
		if(text)chat(src,world_list,text)
	Who()
		set category = "Commands"
		set desc = "See whos online."
		var/whom_list
		var/counter=0
		var/counter2=0
		for(var/mob/player/client/M in world)
			if(!M||!M.client)continue
			var/vstatus="Dead"
			if(M.gamein){vstatus="Alive";counter++}
			else counter2++
			if(!M.name_color)whom_list+="<font color=#FFFFFF><font size=3>- <font color=[M.prefix_color]>{[M.prefix]}</font color>[M.key]([M.kills]) - [vstatus]"+"</font>"+"<br>"
			else whom_list+="<font color=[M.name_color]><font size=3>- <font color=[M.prefix_color]>{[M.prefix]}</font color>[M.key]([M.kills]) - [vstatus]"+"</font>"+"<br>"
		var/updates = {"<html>
		<head>
		<title>Who</title>
		</head>
		<body bgcolor="black" text="white">
		<center><u><font size=4><font color=silver>..::[world.name]::..</font></font></u></center><br>
		<br><br>
		[whom_list]</center><br>
		<font color = silver><font size=3><b><u>Players Alive: [counter]</b></u></font><br>
		<font color = silver><font size=3><u><b>Players Dead: [counter2]</u></b></font><br>
		<font color = silver><font size=3><b><u>Total Players: [(counter+counter2)]</u></b></font><br>
		<font color = #8B0000><font size=3><b>Zombie's: [tzombies] / [zombies]</b></font><br>
		<font color = #8B0000><font size=3><b>Zombie's killed: [killed] / Total Zombie's to kill: [maxzombies]</font><br>
		<font color = #00008B><font size=3><b>World Address: byond://[world.address]:[world.port]</b></b></font><br>
		<hr>
		<center><marquee direction=left><font color=#8B0000><b>Resident Evil Alpha   © Nutty Games</b></marquee></font></center>
		</body>
		</html>
		"}
		usr<<browse(updates,"window=Who;size=454x444")
	Join_game()
		set category = "Commands"
		set desc = "Join the current round."
		if(src.gamein||GameOver||!src.ini_icon||latejoiner_list.Find("[src.key]"))return
		if(GameOn == 2 && !lj)
			src.verbs -= /mob/player/client/verb/Join_game
			src<<"Latejoining is disabled"
			return
		if(GameOn == 1)
			src.gamein = 1
			src.verbs -= /mob/player/client/verb/Join_game
			remember_list += "[src.key]"
			src.load()
			src.loc=locate(/turf/Locations/StartRoom)
			if(src.music){src<<sound(null);src<<sound(Current_Music,1,volume=70)}
			for(var/obj/classes/O in src.overlays)
				if(O)
					del(O)
			var/obj/i=new /obj/classes(src.overlays)
			i.icon_state=src.class
			src.overlays+=i
		else if(GameOn == 2)
			var/list/startlist = new/list()
			for(var/turf/Locations/Mayham_Start/L in world)
				startlist += L
			if(!length(startlist)){src<<"* error! start location was not found.";src.verbs-=/mob/player/client/verb/Join_game;return}
			src.gamein=1
			src.verbs-=/mob/player/client/verb/Join_game
			remember_list += "[src.key]"
			latejoiner_list += "[src.key]"
			src.load()
			for(var/obj/classes/O in src.overlays)
				if(O)
					del(O)
			var/obj/i=new /obj/classes(src.overlays)
			i.icon_state=src.class
			src.overlays+=i
			if(gamemode=="Team Survival")
				if(blueadd>redadd){redadd++;src.team="Red"}
				else {blueadd++;src.team="Blue"}
				src.create_tag(src.team)
			if(src.team=="Red")src.loc=locate(/turf/Locations/Red)
			else if(src.team=="Blue")src.loc=locate(/turf/Locations/Blue)
			else src.loc=pick(startlist)
			if(src.music){src<<sound(null);src<<sound(Current_Music,1,volume=70)}
			if(gamemode=="Protect The Teammate")src<<"*<b><font color=#00008B> Protect: [protect]. *"
			if(gamemode=="Fire Fight"){src.grenade=0;src.molotov=7;src.mine=0}
	ReloadGun()
		set hidden=1
		if(GameOver||src.reloading||!src.gamein)return
		if(src.weapon)
			if(src.weapon&&src.weapon2)
				if(src.weapon.clip<src.weapon.mclip&&src.weapon2.clip<src.weapon2.mclip)
					if(src.weapon.ammo>=1){src.reloading=1;src.reload();src.reloading=0}
					else src<<"Your out of ammo."
			else if(src.weapon.clip<src.weapon.mclip)
				if(src.weapon.ammo>=1){src.reloading=1;src.reload();src.reloading=0}
				else src<<"Your out of ammo."
	Door()
		set hidden=1
		if(src.door||GameOver||!src.gamein)return
		src.door=1
		spawn(doortime)if(src!=null)src.door=0
		for(var/obj/Attackable/Door/D in get_step(src,src.dir))
			if(D.broken){src<<"This door is broken.";return}
			else
				if(D.icon_state=="[D.name]_Open")
					D.density=1
					D.opacity=1
					D.icon_state="[D.name]_Closed"
					range(D,2)<<sound(SOUND_DOOR_CLOSE,0,volume=70)
				else
					D.density=0
					D.opacity=0
					D.icon_state="[D.name]_Open"
					range(D,2)<<sound(SOUND_DOOR,0,volume=70)
	Default()
		set hidden=1
	speechmacro1()
		set hidden=1
		if(!src.scommand["F1"])return
		if(!src.gamein||GameOn!=2)
			if(prob(20))src<<"<i>* you can only use speech macros during a game. *"
			return
		speechchat(src,src.scommand["F1"])
	speechmacro2()
		set hidden=1
		if(!src.scommand["F2"])return
		if(!src.gamein||GameOn!=2)
			if(prob(20))src<<"<i>* you can only use speech macros during a game. *"
			return
		speechchat(src,src.scommand["F2"])
	speechmacro3()
		set hidden=1
		if(!src.scommand["F3"])return
		if(!src.gamein||GameOn!=2)
			if(prob(20))src<<"<i>* you can only use speech macros during a game. *"
			return
		speechchat(src,src.scommand["F3"])
	speechmacro4()
		set hidden=1
		if(!src.scommand["F4"])return
		if(!src.gamein||GameOn!=2)
			if(prob(20))src<<"<i>* you can only use speech macros during a game. *"
			return
		speechchat(src,src.scommand["F4"])
	speechmacro5()
		set hidden=1
		if(!src.scommand["F5"])return
		if(!src.gamein||GameOn!=2)
			if(prob(20))src<<"<i>* you can only use speech macros during a game. *"
			return
		speechchat(src,src.scommand["F5"])
	speechmacro6()
		set hidden=1
		if(!src.scommand["F6"])return
		if(!src.gamein||GameOn!=2)
			if(prob(20))src<<"<i>* you can only use speech macros during a game. *"
			return
		speechchat(src,src.scommand["F6"])
	speechmacro7()
		set hidden=1
		if(!src.scommand["F7"])return
		if(!src.gamein||GameOn!=2)
			if(prob(20))src<<"<i>* you can only use speech macros during a game. *"
			return
		speechchat(src,src.scommand["F7"])
	speechmacro8()
		set hidden=1
		if(!src.scommand["F8"])return
		if(!src.gamein||GameOn!=2)
			if(prob(20))src<<"<i>* you can only use speech macros during a game. *"
			return
		speechchat(src,src.scommand["F8"])


turf
	MouseDown(location,control,params)
		var/list/plist = params2list(params)
		var/px=text2num(plist["icon-x"])
		var/py=text2num(plist["icon-y"])
		var/mob/player/client/M=usr
		if(!M.gamein||GameOver||M.loc == src||M.stuck)return ..()
		if(M.command)
			if(length(M.under_command))
				for(var/mob/player/NPC/Mob/N in M.under_command)
					if(!N){M.under_command-=N;continue}
					N.walk_here(location)
		if(!M.weapon||M.fired||M.reloading||M.stuck)return ..()
		if(M.weapon&&M.weapon2)
			if(M.weapon.clip<=0&&M.weapon2.clip<=0)
				if(M.weapon.ammo>=1){M.reloading=1;M.reload();M.reloading=0}
				return
		else if(M.weapon.clip<=0)
			if(M.weapon.ammo>=1){M.reloading=1;M.reload();M.reloading=0}
			return
		M.fired=1
		var/power=0
		var/obj/Pickup/Guns/G = M.weapon
		var/flickinge = G.flicker
		if(M.weapon2)
			flickinge="ShootingDualL"
			if(M.weapon.clip<=0&&M.weapon2.clip>0){M.dualturn=1;G=M.weapon2;flickinge="ShootingDualR"}
			else if(!M.dualturn&&M.weapon2.clip>0){M.dualturn=1;G=M.weapon2;flickinge="ShootingDualR"}
			else M.dualturn=0
		switch(G.stype)
			if(1)
				spawn(7)if(M)M.fired=0
				G.clip--
				G.suffix="[G.clip]/[G.mclip]"
				range(7,M)<<sound(G.fire_sound,0,volume=(G.sound_wav-master_vol))
				if(!M.weapon2&&!M.flicking){M.flicking=1;flick(flickinge,M);spawn(2)if(M)M.flicking=0}
				power=round(rand(G.fire_power*1.4,G.fire_power*2.5))
			if(2)
				spawn(10)if(M)M.fired=0
				var/bullet=G.clip
				if(bullet>=3)bullet=3
				power=round((G.fire_power*bullet))
				if(M.weapon2)flick(flickinge,M)
				else if(!M.flicking){M.flicking=1;flick(flickinge,M);spawn(2)if(M)M.flicking=0}
				for(var/i=1,i<=bullet,i++)
					G.clip--
					G.suffix="[G.clip]/[G.mclip]"
					range(7,M)<<sound(G.fire_sound,0,volume=(G.sound_wav-master_vol))
					sleep(1)
			if(3)
				var/time=G.firerate
				if(prob(30))time++
				if(M.weapon2&&!G.fshoot){time=(time/2);if(time<=6)time=6}
				spawn(time)if(M)M.fired=0
				G.clip--
				G.suffix="[G.clip]/[G.mclip]"
				range(7,M)<<sound(G.fire_sound,0,volume=(G.sound_wav-master_vol))
				if(M.weapon2)flick(flickinge,M)
				else if(!M.flicking){M.flicking=1;flick(flickinge,M);spawn(2)if(M)M.flicking=0}
				power=(G.fire_power-rand(0,8))
			if(4)
				spawn(G.firerate)if(M)M.fired=0
				G.clip--
				G.suffix="[G.clip]/[G.mclip]"
				range(7,M)<<sound(G.fire_sound,0,volume=(G.sound_wav-master_vol))
				flick(flickinge,M)
				power=round(G.fire_power*rand(6,8))
			if(5)
				spawn(G.firerate)if(M)M.fired=0
				var/bullet=G.clip
				if(bullet>=2)bullet=2
				power=round((G.fire_power*bullet)*rand(6,8))
				if(!M.weapon2&&!M.flicking){M.flicking=1;flick(flickinge,M);spawn(2)if(M)M.flicking=0}
				for(var/i=1,i<=bullet,i++)
					G.clip--
					G.suffix="[G.clip]/[G.mclip]"
					range(7,M)<<sound(G.fire_sound,0,volume=(G.sound_wav-master_vol))
					sleep(2)
		if(G.projectile)
			var/obj/projectiles/O = new G.projectile
			O.owner = M
			O.density = 1
			O.loc = M.loc
			O.dir = get_dir(M,src)
			spawn()O.projectile_loop()
		else
			var/shots=1
			var/snipe_active=0
			if(G.at == 6)
				snipe_active = 1
				shots=rand(8,12)
			else if(G.at == 3)
				shots=rand(1,2)
			else if(G.at == 2)
				shots=3
			if(!M.sniper_mode)
				M.dir = get_dir(M,src)
			else
				var/T2M = get_dir(M,src)
				if(M.dir == NORTH)
					if(T2M == SOUTHEAST||T2M == SOUTHWEST||T2M == SOUTH)
						M.dir = SOUTH
				else if(M.dir == SOUTH)
					if(T2M == NORTHEAST||T2M == NORTHWEST||T2M == NORTH)
						M.dir = NORTH
				else if(M.dir == WEST)
					if(T2M == NORTHEAST||T2M == SOUTHEAST||T2M == EAST)
						M.dir = EAST
				else if(M.dir == EAST)
					if(T2M == NORTHWEST||T2M == SOUTHWEST||T2M == WEST)
						M.dir = WEST
			var/list/LL=new/list()
			for(var/obj/Pickup/Items/gastanker/A in (locate(src.x,src.y,src.z)))
				if(A)
					LL+=A
			if(LL.len>=3)
				for(var/obj/Pickup/Items/gastanker/A in LL)
					A.BlowUp(2,675,usr)
			else
				if(LL.len<=2)
					for(var/obj/Pickup/Items/gastanker/A in LL)
						A.CreateFire(usr,1,1)
						range(A)<<sound('Audio/Sound/burn.wav',0,volume=(80-master_vol))
						del(A)
			var/check=0
			var/list/L=new/list()
			var/obj/effects/bullet/B=new/obj/effects/bullet(M.loc,px,py)
			B.bulletime(src,L)
			if(!length(L))return..()
			var/count=0
			for(var/mob/Z in L)
				if(!Z||!Z.alignment)continue
				if(Z.loc == location && Z.isHS)
					var/hsh=100
					if(!snipe_active)
						hsh=(100-(get_dist(M,Z)*12))
					if(hsh <= 0) hsh = 0
					if(prob(hsh) && px >= 13 && py >= 21 && px <= 20 && py <= 30)
						//new/obj/blood_effects/splatter(Z.loc)
						if(prob(BLOODDROPRATE) && length(Z.loc.overlays) < MAX_BLOOD)Z.loc.overlays += new/obj/blood_effects/blood
						M.kills++
						death_zombie(M.team,Z)
					else
						//new/obj/blood_effects/splatter(Z.loc)
						if(prob(BLOODDROPRATE) && length(Z.loc.overlays) < MAX_BLOOD)Z.loc.overlays += new/obj/blood_effects/blood
						Z.health-=power
						if(Z.health<=0)
							M.kills++
							death_zombie(M.team,Z)
				else
					//new/obj/blood_effects/splatter(Z.loc)
					if(prob(BLOODDROPRATE) && length(Z.loc.overlays) < MAX_BLOOD)Z.loc.overlays += new/obj/blood_effects/blood
					Z.health-=power
					if(Z.health<=0)
						M.kills++
						death_zombie(M.team,Z)
				check=1
				count++
				if(count >= shots)break
				continue
			if(!check)
			//	var/icon/I = new(src.icon)
			//	I.DrawBox(rgb(0,0,0),px,py,(px+1),(py+1))
			//	src.icon = I
				new/obj/effects/bullet_hole(src,px,py)
		..()

proc/auto_host()
	sleep(20)
	world<<"<font color=[SECCOLOR]><b><u><i>AutoHost Activated"
	world.log<<"<font color=[SECCOLOR]><b><u><i>AutoHost Activated"
	sleep(15)
	world<<"<font color=[FIRSTCOLOR]><b>- AutoHost: Setting up....."
	world.log<<"<font color=[FIRSTCOLOR]><b>- AutoHost: Setting up....."
	zombies=rand(300,500)
	lickers=rand(6,8)
	hunters=rand(8,14)
	spiders=rand(200,500)
	bhunters=rand(6,10)
	var/countz=0
	for(var/mob/player/client/p in world)
		if(!p||!p.client)continue
		countz++
	countz+=rand(3,6)
	maxzombies=round(rand(250,350)*countz)
	tryagain
	Speed2=rand(18,26)
	if(Speed1>=Speed2)goto tryagain
	gamemode="Survival"
	vagain
	var/ii=rand(1,4)
	if(ii == 1)
		if(prob(40))
			if(countz>8)Difficulty="Medium"
			else Difficulty="Easy"
		else goto vagain
	else if(ii == 2)
		if(prob(30))
			if(countz>18)Difficulty="Hard"
			else Difficulty="Medium"
		else goto vagain
	else if(ii == 3)
		if(prob(20))
			if(countz>22)Difficulty="Extreme"
			else Difficulty="Hard"
		else goto vagain
	else if(ii == 4)
		if(prob(15))
			if(countz<8)Difficulty="Medium"
			else if(countz<12)Difficulty="Hard"
			else Difficulty="Extreme"
		else goto vagain
	td=pick(1,0)
	lj=1
	pz=pick(1,0)
	sleep(20)
	world<<"<font color=[FIRSTCOLOR]><b>- AutoHost: Done."
	world.log<<"<font color=[FIRSTCOLOR]><b>- AutoHost: Done."
	sleep(10)
	world<<"<font color=[FIRSTCOLOR]><b>- AutoHost: Selecting map....."
	world.log<<"<font color=[FIRSTCOLOR]><b>- AutoHost: Selecting map....."
	var/list/maps_picker=new/list()
	for(var/i=1,i<=length(map_list),i++)
		var/map_file=map_list[i]
		maps_picker+=map_list[map_file]
	/*
	for(var/i in flist("custom_maps/"))
		var/file_extension=copytext(i,length(i)-2,0)
		if(file_extension=="dmp")maps_picker+="custom_maps/[i]"*/
	sleep(10)
	maploading=1
	var/dmp_map=pick(maps_picker)
	if(findtext(dmp_map,"custom_maps"))Custom=1
	ahostm="Off"
	latejm="Off"
	tddm="Off"
	pzm="Off"
	if(autoh)ahostm="On"
	if(lj)latejm="On"
	if(td)tddm="On"
	if(pz)pzm="On"
	var/text=copytext("[dmp_map]",7,0)
	var/file_name=copytext(text,1,length(text)-3)
	current_map="[file_name]"
	world<<"<b><i><font color=[FIRSTCOLOR]>- AutoHost: Loading the Map: <font color=[LOADERCOLOR]>'[file_name]'</font>, please wait..."
	world.log<<"<b><i><font color=[FIRSTCOLOR]>- AutoHost: Loading the Map: <font color=[LOADERCOLOR]>'[file_name]'</font>, please wait..."
	var/dmp_reader/new_reader=new()
	new_reader.load_map(dmp_map)
	checkmap()
	//sortai()
	world<<"<font color=[FIRSTCOLOR]><b>- AutoHost: Map is loaded..."
	world.log<<"<font color=[FIRSTCOLOR]><b>- AutoHost: Map is loaded..."
	sleep(10)
	world<<"<font color=[FIRSTCOLOR]><b>- AutoHost: You have 2 min to load up and get ready."
	world.log<<"<font color=[FIRSTCOLOR]><b>- AutoHost: You have 2 min to load up and get ready."
	Current_Music=pick(rand_save_room_music)
	GameOn=1
	spawn(1200)starting()
	updates()
	maploading=0

proc/starting()
	if(GameOn==1)
		qhacker_check()
		var/count=0
		for(var/mob/player/client/M in world)
			if(!M||!M.client)continue
			if(M.gamein)count++
		if(!count)
			info(null,world,"<font color=[FIRSTCOLOR]><b>- AutoHost: Theres no players to start the game, will wait another 2 mins.")
			world.log<<"<font color=[FIRSTCOLOR]><b>- AutoHost: Theres no players to start the game, will wait another 2 mins."
			spawn(1200)starting()
			return
		var/list/startlist=new/list()
		for(var/turf/Locations/Mayham_Start/L in world)
			startlist+=L
		if(!length(startlist)){world<<"<font color=[FIRSTCOLOR]><b>- AutoHost:  error! start location was not found. reseting round.";world.log<<"<font color=[FIRSTCOLOR]><b>- AutoHost:  error! start location was not found. reseting round.";spawn()boot_up(80);return}
		GameOn=2
		game_status="Game In Progress"
		Current_Music=pick(rand_map_music)
		for(var/mob/player/client/M in world)
			if(!M||!M.client)continue
			if(M.gamein)
				if(M.music){M<<sound(null);M<<sound(Current_Music,1,volume=80)}
				M.loc=pick(startlist)
				latejoiner_list+="[M.key]"
			else
				if(!lj)M.verbs-=/mob/player/client/verb/Join_game
				M.verbs+=/mob/Ogame/verb/Observe
		spawn()
			nomounting=0
			explosive=1
			if(!timespawn(60))return
			var/C_MUSIC=MUSIC_MZ
			var/volumes = 70
			if(Difficulty=="Medium")C_MUSIC=pick(rand_battle_music_medium)
			else if(Difficulty=="Hard")C_MUSIC=pick(rand_battle_music_hard)
			else if(Difficulty=="Extreme")
				C_MUSIC=pick(rand_battle_music_expert)
			Current_Music=C_MUSIC
			for(var/mob/player/client/M in world)
				if(!M||!M.client)continue
				if(M.gamein||M.watch)
					if(M.music){M<<sound(null);M<<sound(Current_Music,1,volume=volumes)}
					if(gamemode=="Fire Fight")
						M.grenade=0
						M.mine=0
						M.molotov=10
					//else {M<<sound(null);M<<sound(MUSIC_MZ,1,volume=60)}
			if(gamemode=="Eight Legged Freaks")
				if(!timespawn(1))return
				info(null,world,"<b><font color=#00008B>The Spider's are invading!")
				world.log<<"<b><font color=#00008B>The Spider's are invading!"
				spawn()spawner(/mob/Monster/Spider, spiders, spiders, rand(5,20), spawn_zone)
				spawn()timer()
			else if(gamemode=="Tongue Twister")
				if(!timespawn(1))return
				info(null,world,"<b><font color=#8B0000>The Licker's are invading!")
				world.log<<"<b><font color=#8B0000>The Licker's are invading!"
				spawn()spawner(/mob/Monster/Licker, lickers, lickers, rand(5,20), spawn_zone)
				spawn()timer()
			else
				info(null,world,"<b><font color=#[FIRSTCOLOR]>The dead Walk!")
				world.log<<"<b><font color=#[FIRSTCOLOR]>The dead Walk!"
				spawn()spawner(/mob/Monster/Zombie, zombies, zombies, rand(5,20), spawn_zone)
				spawn()timer()
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
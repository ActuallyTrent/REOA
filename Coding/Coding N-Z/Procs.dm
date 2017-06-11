proc
	qhacker_check()
		for(var/mob/player/client/p in world)
			if(!p||!p.gamein||!p.client)continue
			if(p.cc() == 1)
				p.reset_game()
				p<<"<b><font color=red>Hacking..."
				del(p)
	timer()
		timer = 0
		spawn()while(!GameOver)
			timer++
			sleep(10)
	treturn()
		if(!timer)return
		var/count_dupe
		var/list/total_time = list("hours" = 0,"minutes" = 0,"seconds" = 0)
		count_dupe = timer
		while(count_dupe>=60)
			total_time["minutes"]++
			if(total_time["minutes"] >= 60)
				total_time["hours"]++
				total_time["minutes"] = 0
			count_dupe -= 60
		if(count_dupe)total_time["seconds"] += count_dupe
		if(gamemode=="Survival"){world<<"<b><font color=[FIRSTCOLOR]>You managed to survive for [total_time["hours"]] hour\s, [total_time["minutes"]] minute\s, and [total_time["seconds"]] second\s.";world.log<<"<b><font color=[FIRSTCOLOR]>You managed to survive for [total_time["hours"]] hour\s, [total_time["minutes"]] minute\s, and [total_time["seconds"]] second\s."}
		else if(gamemode=="Protect The Teammate"){world<<"<b><font color=[FIRSTCOLOR]>You managed to keep [protect] alive for [total_time["hours"]] hour\s, [total_time["minutes"]] minute\s, and [total_time["seconds"]] second\s.";world.log<<"<b><font color=[FIRSTCOLOR]>You managed to keep [protect] alive for [total_time["hours"]] hour\s, [total_time["minutes"]] minute\s, and [total_time["seconds"]] second\s."}
	timespawn(time=0)
		var/time_check=Round
		sleep((time*10))
		if(time_check == Round && !GameOver) return 1
	total_money()
		if(!length(remember_list))return
		var/cashearned=0
		if(Difficulty=="Easy")
			cashearned+=round(killed/3)
			cashearned+=length(remember_list)*10
		else if(Difficulty=="Medium")
			cashearned+=round(killed/2)
			cashearned+=length(remember_list)*12
		else if(Difficulty=="Hard")
			cashearned+=round(killed/1)
			cashearned+=length(remember_list)*14
		else if(Difficulty=="Extreme")
			cashearned+=round(killed)
			cashearned+=length(remember_list)*16
		for(var/mob/player/client/p in world)
			if(!p||!p.client)continue
			if(p.gamein){cashearned+=5;break}
		for(var/mob/player/client/p in world)
			if(!p||!p.client)continue
			if(length(remember_list)&&remember_list.Find(p.key))
				var/cashe=cashearned
				if(p.kills<50)cashe=(cashe/4)
				if(Difficulty=="Easy")cashe+=round(0.40*(p.kills*(p.points/3)))
				else if(Difficulty=="Medium")cashe+=round(0.50*(p.kills*(p.points/3)))
				else if(Difficulty=="Hard")cashe+=round(0.60*(p.kills*(p.points/3)))
				else if(Difficulty=="Extreme")cashe+=round(0.80*(p.kills*(p.points/3)))
				if(Custom)
					if(cashe>2000)cashe=2000
				else if(cashe>5000)cashe=5000
				if(cashe>0)
					p.cash+=cashe
					if(p.cash>=maxcash)p.cash=maxcash
					p<<"<b><font color=[FIRSTCOLOR]>* You earned [cashe]$."

proc
	checkmap()
		for(var/turf/T in world)
			if(!T||!length(T.contents))continue
			for(var/obj/O in T.contents)
				if(istype(O,/obj/Pickup/Guns))
					var/obj/O2 = new O.type
					O2.loc = O.loc
					del(O)
	boot_up(var/time)
		Round++
		if(Round>=9999)
			Round=1
		sleep(time)
		clean_up()
		clean_up_the_rest()
		delitems()
		if(!autoh)find_host()
		else spawn()auto_host()
		GameOver=0
		world.Repop()
		updates()
	clean_up()
		GameOn=0
		Current_Music=pick(rand_title_music)
		spawn_zone=new/list()
		remember_list=new/list()
		latejoiner_list=new/list()
		blueadd=0
		redadd=0
		killed=0
		Custom=0
		explosive=0
		tzombies=0
		maploading=0
		tlickers=0
		thunters=0
		nomounting=1
		protect=0
		bluekills=0
		bosssa=0
		game_status="Starting"
		redkills=0
		timer=0
		bossspawned=0
		for(var/mob/player/client/p in world)
			if(!p||!p.client)continue
			if(istype(p.weapon,/obj/Pickup/Guns/M249)&&p.stand)
				p.weapon:removestand(p)
			if(istype(p.weapon,/obj/Pickup/Guns)&&p.weapon.projectile&&p.weapon.combined)
				p.weapon.removegl(p.weapon.clip,p.weapon.mclip,p.weapon.maxammo,p.weapon.ammo_type,p)
			p.reset_var()
			p<<sound(null)
			p<<sound(null)
			if(p.music)p<<sound(Current_Music,1)
			p.loc=locate(/turf/Locations/Title)
			p.verbs-=typesof(/mob/Ogame/verb)
			p.verbs+=/mob/player/client/verb/Join_game
			p.verbs-=/mob/player/client/Host/verb/Spawn_Boss
	clean_up_the_rest()
		for(var/turf/T in world)
			if(T.z==2)
				for(var/atom/movable/O in T)
					if(!O)continue
					del(O)
			else if(T.z>=3)
				T.icon=null
				T.icon_state=null
				for(var/atom/movable/O in T)
					if(!O)continue
					del(O)
		for(var/obj/effects/bullet_hole/b in world)
			del(b)
		world.maxx=50
		world.maxy=60
		world.maxz=2
	delitems()
		for(var/mob/player/client/p in world)
			if(!p||!p.client||!length(p.contents))continue
			for(var/obj/Pickup/Items/I in p.contents)
				del(I)
	find_host()
		var/list/tmplist=new/list()
		for(var/mob/player/client/P in world)
			if(!P||!P.client)continue
			tmplist+=P
			if(!P.client.address||P.client.address==world.address)
				if(Host!=P.key)Host=P.key
				P.verbs-=/mob/player/client/Host/verb/Game_Start
				P.verbs-=/mob/player/client/Host/verb/Spawn_Boss
				var/option=get_settings(P)
				P<<browse(option,"window=Options;size=540x525;can_close=0;can_resize=1;can_minimize=1")
				return
		if(tmplist.len>=1 && !autoh)
			for(var/mob/player/client/M in tmplist)
				if(M.key in Enforcer)
					return
			var/mob/player/client/M = tmplist[1]
			M.verbs-=/mob/player/client/Host/verb/Game_Start
			M.verbs-=/mob/player/client/Host/verb/Spawn_Boss
			var/option=get_settings(M)
			M<<browse(option,"window=Options;size=540x525;can_close=0;can_resize=1;can_minimize=1")
			return


mob/player/client/proc/reset_var()
	src.islicker=0
	src.iscyborg=0
	src.ismrx=0
	src.isnemesis=0
	src.istyrant=0
	src.istyrant2=0
	src.isspider=0
	src.transformed = 0
	src.hasammo = 1
	src.zreloading = 0
	src.tentical = 1
	src.transforming=0
	src.wrapping = 0
	src.licks=0
	src.moblist=new/list()
	src.tentical=1
	src.linehealth=5
	src.tongue=1
	src.web=3
	src.webbing=0
	src.eggsack=1
	src.manning=0
	src.turret=null
	src.stuck=0
	src.licking=0
	src.stand=0
	src.gamein=0
	src.alignment=0
	src.incar=0
	src.driver=0
	src.tlspot=new/list()
	src.trspot=new/list()
	src.blspot=new/list()
	src.brspot=new/list()
	src.under_command=new/list()
	if(src.client)src.client.eye=src
	src.watch=0
	src.eye_x=10
	src.eye_y=10
	src.eye_z=1
	src.team=null
	src.sight=null
	src.walkdelay=2
	src.sniper_mode=0
	src.isBoss=0
	src.overlays=new/list()
	src.team=null
	src.on_fire=0
	src.grenade=3
	src.molotov=3
	//src.maxgrenade=6
	src.mine=3
	//src.maxmine=5
	src.reloading=0
	src.kills=0
	src.points=0
	src.tm_inmenu=0
	src.see_in_dark=5
	src.invisibility=1
	src.icon=null
	src.icon_state=null
	src.lastinfn=1000
	src.lastkilln=100000
	src.lastcashn=100000
	src.lastclipn=100000
	src.lastclipn2=100000
	src.frozen = 0
	src.lastvital="Fines"
	src.ammo = list("9mm Parabellum Rounds" = 90,".357 Magnum Rounds" = 30,"12 Gauge Shells" = 80,".45 ACP Rounds" = 500, "5.56mm NatO Rounds" = 700, "7.62x54mmR Rounds" = 28, ".50 CC Rounds" = 16, "Rockets" = 2, "Flame Rounds" = 4, "Freeze Rounds" = 4, "Acid Rounds" = 4, "Explosive Rounds" = 4)
	src.otherammo = list("Acid" = 4, "Flame" = 4, "Freeze" = 4, "Explosive" = 4)
	if(src.enemy_marker)del(src.enemy_marker)
	src.hideunhide_hud(2,1,null)
	if(src.inventory)
		src.inventory=0
		src.updateihud(2)
		src.inventoryo(2)
	src.reset_hud()
	src.weapon=null
	src.weapon2=null
	src.speechmacuses=0
/*
proc/spawner(var/atom/mtype = null, nts = 0, sat = 1, sd = 0, list/floc, matl = 0)
	set background = 1
	if(GameOver||!mtype||!nts)return
	var/obj/dantum/D = new
	var{ms = 0;trig = 0;kt = 0}
	if(length(floc))trig = 1
	if(matl)kt = 1
	while(ms < nts)
		if(kt)
			while(D.counter >= matl)
				sleep(10)
		var/m2s = sat
		if(m2s >= (nts - ms))
			m2s = (nts - ms)
		if(kt)
			if(m2s >= (matl - D.counter))
				m2s = (matl - D.counter)
		for(var/i = 1, i<=m2s, i++)
			D.counter++
			ms++
			var/mob/Monster/M = new mtype
			if(trig)M.loc = pick(floc)
			else M.loc = pick(spawn_zone)
			if(kt)M.dt = D
		sleep(sd)
	if(D)del(D)*/

proc/spawner(var/atom/mtype = null, nts = 0, sat = 1, sd = 0, list/floc)
	if(GameOver||!mtype||!nts||!length(floc))return
	var/ms = 0
	var/round_check = Round
	while(ms < nts)
		if(round_check != Round||GameOver)break
		var/m2s = sat
		if(m2s >= (nts - ms))
			m2s = (nts - ms)
		for(var/i = 1, i<=m2s, i++)
			ms++
			var/mob/Monster/M = new mtype
			M.loc = pick(floc)
		sleep(sd)

//REBOOT STUFF
proc
	check_killr()
		if(GameOver)return
		var/message="<b><font color=[FIRSTCOLOR]>Quarantine complete... restarting round."
		if(protect)message="<b><font color=[FIRSTCOLOR]>Mission complete, [protect] survived long enough for evacuation... restarting round."
		if(bluekills>maxzombies)
			GameOver=1
			world<<"<b><font color=[FIRSTCOLOR]><font color=#00008B>Blue Team</font> defeated <font color=#8B0000>Red Team</font>... restarting round."
			world.log << "<b><font color=[FIRSTCOLOR]><font color=#00008B>Blue Team</font> defeated <font color=#8B0000>Red Team</font>... restarting round."
		else if(redkills>maxzombies)
			GameOver=1
			world<<"<b><font color=[FIRSTCOLOR]><font color=#8B0000>Red Team</font> defeated <font color=#00008B>Blue Team</font>... restarting round."
			world.log << "<b><font color=[FIRSTCOLOR]><font color=#8B0000>Red Team</font> defeated <font color=#00008B>Blue Team</font>... restarting round."
		else if(killed>=maxzombies)
			GameOver=1
			world<<"[message]"
			world.log<<"[message]"
		if(GameOver)
			treturn()
			total_money()
			rank_players()
			if(autos)
				autosave()
			else
				world<<"<b><font color=[FIRSTCOLOR]>Autosave is disabled, please manually save"
				world.log<<"<b><font color=[FIRSTCOLOR]>Autosave is disabled, please manually save"
			boot_up(60)
	check_r(var/t)
		if(GameOver)return
		spawn()
			var/reboot_world_check=0
			var/message="<b><font color=[FIRSTCOLOR]>All survivors are dead... restarting round."
			if(!protect)
				if(gamemode=="Team Survival")
					message="<b><font color=[FIRSTCOLOR]><font color=#00008B>Blue Team</font> defeated <font color=#8B0000>Red Team</font>... restarting round."
					if(t=="Blue")message="<b><font color=[FIRSTCOLOR]><font color=#8B0000>Red Team</font> defeated <font color=#00008B>Blue Team</font>... restarting round."
					for(var/mob/player/client/p in world)
						if(!p||!p.client)continue
						if(p.gamein&&p.team==t)reboot_world_check++
				else
					for(var/mob/player/client/p in world)
						if(!p||!p.client)continue
						if(p.gamein)reboot_world_check++
			else
				message="<b><font color=[FIRSTCOLOR]>You have failed to protect: [protect]... restarting round."
				for(var/mob/player/client/p in world)
					if(!p||!p.client)continue
					if(p.gamein&&protect==p.key)reboot_world_check++
			if(!reboot_world_check)
				GameOver=1
				if(timer)
					world<<"[message]"
					world.log<<"[message]"
					treturn()
					total_money()
					rank_players()
					if(autos)
						autosave()
					else
						world<<"<b><font color=[FIRSTCOLOR]>Autosave is disabled, please manually save"
						world.log<<"<b><font color=[FIRSTCOLOR]>Autosave is disabled, please manually save"
				else
					world<<"<b><font color=[FIRSTCOLOR]>No players to continue this round... reseting....."
					world.log<<"<b><font color=[FIRSTCOLOR]>No players to continue this round... reseting....."
				boot_up(60)
	check_logr(var/t)
		if(GameOver||GameOn!=2)return
		spawn()
			var/reboot_world_check=0
			var/message="<b><font color=[FIRSTCOLOR]>All survivors are dead... restarting round."
			if(!protect)
				if(gamemode=="Team Survival")
					message="<b><font color=[FIRSTCOLOR]><font color=#00008B>Blue Team</font> defeated <font color=#8B0000>Red Team</font>... restarting round."
					if(t=="Blue")message="<b><font color=[FIRSTCOLOR]><font color=#8B0000>Red Team</font> defeated <font color=#00008B>Blue Team</font>... restarting round."
					for(var/mob/player/client/p in world)
						if(!p||!p.client)continue
						if(p.gamein&&p.team==t)reboot_world_check++
				else
					for(var/mob/player/client/p in world)
						if(!p||!p.client)continue
						if(p.gamein)reboot_world_check++
			else
				message="<b><font color=[FIRSTCOLOR]>You have failed to protect: [protect]... restarting round."
				for(var/mob/player/client/p in world)
					if(!p||!p.client)continue
					if(p.gamein&&protect==p.key)reboot_world_check++
			if(!reboot_world_check)
				GameOver=1
				if(timer)
					world<<"[message]"
					world.log<<"[message]"
					treturn()
					total_money()
					rank_players()
					if(autos)
						autosave()
					else
						world<<"<b><font color=[FIRSTCOLOR]>Autosave is disabled, please manually save"
						world.log<<"<b><font color=[FIRSTCOLOR]>Autosave is disabled, please manually save"
				else
					world<<"<b><font color=[FIRSTCOLOR]>No players to continue this round... reseting....."
					world.log<<"<b><font color=[FIRSTCOLOR]>No players to continue this round... reseting....."
				boot_up(60)
//OTHER CRAP
proc
	steploop(atom/movable/A,atom/T,delay=5)
		var/counter=get_dist(A,T)
		while(A&&counter)
			var/turf/TL=get_step(A,get_dir(A,T))
			if(TL&&TL.density)break
			step_towards(A,T)
			counter--
			sleep(delay)

proc/rank_players()
	if(Custom)return
	var/count=0
	for(var/mob/player/client/p in world)
		if(!p.client||!p.kills)continue
		if(Ranking(p,Difficulty,current_map))
			count++
	if(count){world<<"<b><font color=[FIRSTCOLOR]>Kill Ranks have been updated.";world.log<<"<b><font color=[FIRSTCOLOR]>Kill Ranks have been updated."}

/*
	compass_thing()
		var/ROUNDS = Round
		var/pvpt=0
		if(gamemode=="Team Pvp")pvpt=1
		while(!GameOver && ROUNDS == Round)
			for(var/mob/player/client/M in world)
				if(!M||!M.client||!M.gamein)continue
				var/atom/movable/ct=null
				for(var/mob/player/client/M2 in world)
					if(!M2||!M2.client||!M.gamein||M2 == M)continue
					if(pvpt && M2.team == M.team)continue
					if(get_dist(M,M2)<get_dist(M,ct))
						ct=M2
				if(ct && M.CDir)M.CDir.dir=get_adir(M,ct)
			sleep(20)
	get_adir(atom/a, atom/a2)
		var/A = Arctan(a.x - a2.x, a.y - a2.y)
		var/B = round(A, 45)
		switch(B)
			if(-90) return NORTH
			if(90) return SOUTH
			if(180, -180) return EAST
			if(0) return WEST
			if(-135) return NORTHEAST
			if(135) return SOUTHEAST
			if(-45) return NORTHWEST
			if(45) return SOUTHWEST
	Arctan(x,y)
		if(!x && !y) return 0
		var/a=arccos(x/sqrt(x*x+y*y))
		return (y>=0)?(a):(-a)*/
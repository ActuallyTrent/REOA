mob/player/client/proc
	get_macro_page()
		var/html={"
			<html>
			<head>
			<title>Speech Macros</title>
			</head>
			<body>
			<form method=get action=''>
			<input type=hidden name=src value=\ref[src]>
			<style type="text/css">
				body{background-color: black; color: white}
				input{background-color: white ;color: black; border-color: grey}
				select{background-color: white ;color: black}
				radio{background-color: black; color: black}
			</style>
			<center><big><b><u>Speech Macros</u></b></big></center>
			<br>
			<table cellpadding="3" cellspacing="6" border="1" align="center">
			<td>
			<table cellpadding="3" cellspacing="0" border="0" align="center">
			"}
		for(var/i=1,i<=8,i++)
			var/direc = "F[i]"
			html+={"
				<tr>
					<td>F[i]:</td><td><input type="text" name="f[i]" value="[src.scommand[direc]]" maxlength="30" size="38"></td>
				</tr>
				"}
		html+={"
			</td>
			</table>
			<input type="hidden" name="action" value="speech_macros">
			<center><input type="submit" value="Submit"> - <input type="reset" value="Reset"></center>
			</table>
			</form>
			</body>
			</html>
			"}
		return html
	cc()
		if(!src)return null
		if(src.cash>(maxcash+1)||src.maxitems>=13)return 1
		for(var/obj/Pickup/Guns/G in src.contents)
			if(!G)continue
			if(G.check_upgrades())
				return 1
	schecker()
		if(!src)return null
		if(src.cash>(maxcash+1)||src.maxitems>=13||src.chest_capacity>=7)return 1
		if(length(src.item_save))
			for(var/obj/Pickup/Guns/G in src.item_save)
				if(!G)continue
				if(G.check_upgrades())
					return 1
		if(length(src.chest))
			for(var/obj/Pickup/Guns/G in src.chest)
				if(!G)continue
				if(G.check_upgrades())
					return 1
	target(atom/M)
		if(src.enemy_marker)del(src.enemy_marker)
		src.enemy_marker=image(src.tcc,M)
		src<<src.enemy_marker
	check_items()
		var/count=(length(src.contents)-1)
		if(count>=src.maxitems)
			return 0
		else return 1
	update_items(itype=0)
		src.items=(length(src.contents)-1)
		if(!itype&&src.inventory)src.updateihud(1,1)
	healthbar()
		src.overlays -= src.hpbar
		src.hpbar.icon_state = "[src.lastvital]"
		if(src.infection)
			src.hpbar.icon_state = "[src.lastvital]_I"
		src.overlays += src.hpbar
	reload()
		if(src.weapon&&src.weapon2)
			var/i=src.weapon
			var/i2=src.weapon2
			src<<"<i>Reloading..."
			if(src.weapon.spread&&!src.weapon.clip_round)
				var/take=src.weapon.mclip
				take-=src.weapon.clip
				if(src.weapon.ammo<take)take=src.weapon.ammo
				for(var/r=1,r<=take, r++)
					if(!src.weapon||i != src.weapon)break
					src.weapon.clip++
					src.weapon.suffix="[src.weapon.clip]/[src.weapon.mclip]"
					view(src)<<sound(src.weapon.shell_reload_sound,0,volume=(80-master_vol))
					src.weapon.ammo--
					sleep(round(src.weapon.reload_time/3))
				spawn(2)
					if(src.weapon && i == src.weapon)
						view(src)<<sound(src.weapon.reload_sound,0,volume=(80-master_vol))
				if(src.weapon.ammo)
					take=src.weapon2.mclip
					take-=src.weapon2.clip
					if(src.weapon.ammo<take)take=src.weapon.ammo
					for(var/r2=1,r2<=take, r2++)
						if(!src.weapon||i != src.weapon||!src.weapon2||i2 != src.weapon2)break
						src.weapon2.clip++
						src.weapon2.suffix="[src.weapon2.clip]/[src.weapon2.mclip]"
						view(src)<<sound(src.weapon2.shell_reload_sound,0,volume=(80-master_vol))
						src.weapon.ammo--
						sleep(round(src.weapon2.reload_time/3))
					sleep(2)
					if(src.weapon2 && i2 == src.weapon2)
						view(src)<<sound(src.weapon2.reload_sound,0,volume=(80-master_vol))
				else sleep(2)
				src<<"<i>...Reloaded"
			else
				sleep((src.weapon.reload_time+src.weapon2.reload_time))
				if(i==src.weapon&&i2==src.weapon2)
					view(src)<<sound(src.weapon.reload_sound,0,volume=(80-master_vol))
					var/take=src.weapon.mclip
					take-=src.weapon.clip
					if(src.weapon.ammo<take)take=src.weapon.ammo
					src.weapon.clip+=take
					src.weapon.suffix="[src.weapon.clip]/[src.weapon.mclip]"
					src.weapon.ammo-=take
					if(src.weapon.ammo)
						view(src)<<sound(src.weapon2.reload_sound,0,volume=(80-master_vol))
						take=src.weapon2.mclip
						take-=src.weapon2.clip
						if(src.weapon.ammo<take)take=src.weapon.ammo
						src.weapon2.clip+=take
						src.weapon2.suffix="[src.weapon2.clip]/[src.weapon2.mclip]"
						src.weapon.ammo-=take
				src<<"<i>...Reloaded"
		else if(src.weapon)
			var/i=src.weapon
			src<<"<i>Reloading..."
			if(src.weapon.spread&&!src.weapon.clip_round)
				var/take=src.weapon.mclip
				take-=src.weapon.clip
				if(src.weapon.ammo<take)take=src.weapon.ammo
				for(var/r=1,r<=take, r++)
					if(!src.weapon||i != src.weapon)break
					src.weapon.clip++
					src.weapon.suffix="[src.weapon.clip]/[src.weapon.mclip]"
					view(src)<<sound(src.weapon.shell_reload_sound,0,volume=(80-master_vol))
					src.weapon.ammo--
					sleep(round(src.weapon.reload_time/3))
				sleep(2)
				if(src.weapon && i == src.weapon)
					view(src)<<sound(src.weapon.reload_sound,0,volume=(80-master_vol))
				src<<"<i>...Reloaded"
			else
				sleep(src.weapon.reload_time)
				if(i==src.weapon&&!src.weapon2)
					view(src)<<sound(src.weapon.reload_sound,0,volume=(80-master_vol))
					var/take=src.weapon.mclip
					take-=src.weapon.clip
					if(src.weapon.ammo<take)take=src.weapon.ammo
					src.weapon.clip+=take
					src.weapon.suffix="[src.weapon.clip]/[src.weapon.mclip]"
					src.weapon.ammo-=take
					src<<"<i>...Reloaded"
		sleep(10)
	create_tag(var/t)
		var/obj/O=new/obj
		O.icon='teamtags.dmi'
		O.icon_state="[t]"
		O.pixel_y=17
		O.layer=6
		src.overlays+=O
	spec_eye(var/dire)
		if(!dire)return
		switch(dire)
			if(1)
				if((src.eye_y+1)<=world.maxy)
					src.eye_y++
			if(2)
				if((src.eye_y-1)>0)
					src.eye_y--
			if(3)
				if((src.eye_x+1)<=world.maxx)
					src.eye_x++
			if(4)
				if((src.eye_x-1)>0)
					src.eye_x--
		src.client.eye=locate(src.eye_x,src.eye_y,src.eye_z)
	addname(var/text)
		var/text_len=length(text)
		text_len=round(length(text)/2)
		var/leftspot=round(text_len*-3.65)
		for(var/i=1,i<=length(text),i++)
			var/T=copytext(text,i,i+1)
			if(T==" "){leftspot+=4;continue}
			else
				var/obj/N=new/obj/name
				N.pixel_x=leftspot
				N.icon_state="[T]"
				src.overlays+=N
				leftspot+=4
	screen_update()
		if(src.gamein && !GameOver)
			if(src.infection!=src.lastinfn)
				src.lastinfn=src.infection
				src.update_hud(1)
			if(src.kills != src.lastkilln)
				src.lastkilln=src.kills
				src.update_hud(2)
			if(src.cash != src.lastcashn)
				src.lastcashn=src.cash
				src.update_hud(3)
			if(src.LS_Icon)
				var/message="Fine"
				if(src.health<=round(src.maxhealth/2.5))
					message="Danger"
				else if(src.health<=round(src.maxhealth/1.5))
					message="Caution"
				if(src.lastvital != message)
					src.lastvital = "[message]"
					src.healthbar()
					switch(message)
						if("Fine")src.LS_Icon.icon='lifespan(1).dmi'
						if("Caution")src.LS_Icon.icon='lifespan(2).dmi'
						if("Danger")src.LS_Icon.icon='lifespan(3).dmi'
			if(src.weapon)
				if(src.weapon.clip != src.lastclipn)
					src.lastclipn = src.weapon.clip
					src.update_hud(4)
				if(src.weapon2)
					if(src.weapon2.clip != src.lastclipn2)
						src.lastclipn2 = src.weapon2.clip
						src.update_hud(5)
		spawn(20) src.screen_update()
mob/player/client
	see_in_dark=4
	Death(var/varstone = 0)
		if(!src.gamein)return
		src.gamein=0
		if(istype(src.weapon,/obj/Pickup/Guns/M249)&&src.stand)
			src.weapon:removestand(src)
		if(istype(src.weapon,/obj/Pickup/Guns)&&src.weapon.projectile&&src.weapon.combined)
			src.weapon.removegl(src.weapon.clip,src.weapon.mclip,src.weapon.maxammo,src.weapon.ammo_type,src)
		src.weapon=null
		src.weapon2=null
		src.stuck=0
		src.fixing=0
		for(var/mob/player/NPC/Obj/sentry_turret/S in src.contents)
			if(S)
				del(S)
		for(var/obj/effects/Hazards/oil/O in world)
			if(O.owner==src)
				O.owner_dead=1
		if(!locate(/obj/blood_effects/corpse) in src.loc)
			var/icon/I = src.inis_icon
			new/obj/blood_effects/corpse(src.loc,I)
		if(src.manning)
			src.turret.man=null
			src.turret.manned=0
		src.manning = 0
		if(src.stuck)
			for(var/line/line)
				if(line.reftarg==src)
					if(istype(line.owner,/mob/Monster/Boss/Tyrant)||istype(line.owner,/mob/Monster/Boss/Tyrant_T700))
						line.owner:moblist-=src
						line.owner:licks--
						line.reftarg:overlays-=/obj/playerlays/wrap2
						if(line.owner:licks<=0)
							line.owner:wrapping=0
					else
						line.owner:licking=0
						line.reftarg:overlays-=/obj/playerlays/wrap
					del(line)
					break
		if(src.incar)
			if(src.incar.main.topright.topright==src)
				src.incar.main.topright.topright=0
				if(src.incar.main.driver)
					if(src in src.incar.main.driver.trspot)
						src.incar.main.driver.trspot-=src
			else if(src.incar.main.bottomright.bottomright==src)
				src.incar.main.bottomright.bottomright=0
				if(src.incar.main.driver)
					if(src in src.incar.main.driver.brspot)
						src.incar.main.driver.brspot-=src
			else if(src.incar.main.bottomleft.bottomleft==src)
				src.incar.main.bottomleft.bottomleft=0
				if(src.incar.main.driver)
					if(src in src.incar.main.driver.blspot)
						src.incar.main.driver.blspot-=src
			src.invisibility=0
			src.incar=0
		else if(src.driver)
			src.driver.main.driver=0
			src.driver=0
			src.tlspot=new/list()
			src.trspot=new/list()
			src.blspot=new/list()
			src.brspot=new/list()
			src.invisibility = 0
		if(src.sniper_mode)
			src.sniper_mode = 0
			src.client.eye = src
			src.eye_x=10
			src.eye_y=10
			src.eye_z=1
		src.hideunhide_hud(2,1,null)
		if(src.inventory)
			src.inventory=0
			src.updateihud(2)
			src.inventoryo(2)
		if(src.enemy_marker)del(src.enemy_marker)
		if(length(src.under_command))src.under_command=new/list()
		if(src.gender=="female"){world<<"<b>*([src]) Screams for her life! ([src.kills] Kills)*";world.log<<"<b>*([src]) Screams for her life! ([src.kills] Kills)*"}
		else {world<<"<b>*([src]) Screams for his life! ([src.kills] Kills)*";world.log<<"<b>*([src]) Screams for his life! ([src.kills] Kills)*"}
		check_r("[src.team]")
		src.mouse_over_pointer=null
		if(!pz||gamemode=="Team Survival"||varstone)
			if(varstone)
				src<<"You were turned to stone!"
			src.icon=null
			src.icon_state=null
			src.invisibility=1
			src.watch=1
			src.eye_x=src.x
			src.eye_y=src.y
			src.eye_z=src.z
			src.see_in_dark=14
			src.sight=SEE_MOBS
			src.client.eye=locate(src.eye_x,src.eye_y,src.eye_z)
			src.loc=locate(/turf/Locations/Title)
			src.verbs+=/mob/Ogame/verb/Observe
		else
			if(src.kills<=149&&gamemode!="Tongue Twister"&&gamemode!="Eight Legged Freaks")
				src.isHS=1
				src.walkdelay=2
				if(Difficulty=="Easy")src.maxhealth=rand(260,300)
				else if(Difficulty=="Medium")src.maxhealth=rand(300,400)
				else if(Difficulty=="Hard")src.maxhealth=rand(460,610)
				else if(Difficulty=="Extreme"){src.maxhealth=rand(720,945);src.isHS=0}
				var/randomer=rand(1,19)
				switch(randomer)
					if(1){src.icon='Zombie.dmi';src.icon_state="normal[rand(1,2)]"}
					if(2){src.icon='Zombie_1.dmi';src.icon_state="normal[rand(1,2)]"}
					if(3){src.icon='Zombie_2.dmi';src.icon_state="normal[rand(1,2)]"}
					if(4){src.icon='Zombie_3.dmi';src.icon_state="normal[rand(1,2)]"}
					if(5){src.icon='Zombie_4.dmi';src.icon_state="normal"}
					if(6){src.icon='Zombie_5.dmi';src.icon_state="normal"}
					if(7){src.icon='Zombie_6.dmi';src.icon_state="normal"}
					if(8){src.icon='Zombie_7.dmi';src.icon_state="normal"}
					if(9){src.icon='Zombie_8.dmi';src.icon_state="normal"}
					if(10){src.icon='Zombie_9.dmi';src.icon_state="normal"}
					if(11){src.icon='Zombie_10.dmi';src.icon_state="normal"}
					if(12){src.icon='Zombie_11.dmi';src.icon_state="normal"}
					if(13){src.icon='New_Zombie.dmi';src.icon_state="normal"}
					if(14){src.icon='New_Zombie2.dmi';src.icon_state="normal"}
					if(15){src.icon='New_Zombie3.dmi';src.icon_state="normal"}
					if(16){src.icon='New_Zombie4.dmi';src.icon_state="normal"}
					if(17){src.icon='New_Zombie5.dmi';src.icon_state="normal"}
					if(18){src.icon='New_Zombie6.dmi';src.icon_state="normal"}
					if(19){src.icon='New_Zombie7.dmi';src.icon_state="normal"}
			else if(src.kills<=299&&gamemode!="Eight Legged Freaks"||(src.kills<=1000&&gamemode=="Tongue Twister"))
				src.islicker=1
				src.isHS=0
				if(Difficulty=="Easy")src.maxhealth=rand(285,495)
				else if(Difficulty=="Medium")src.maxhealth=rand(360,485)
				else if(Difficulty=="Hard")src.maxhealth=rand(485,535)
				else if(Difficulty=="Extreme")src.maxhealth=rand(485,635)
				src.icon='licker.dmi'
				src.icon_state="normal"
				src.deadspec="Tongue Grab"
				src.walkdelay=1
			else if(src.kills<=499&&gamemode!="Tongue Twister"&&gamemode!="Eight Legged Freaks")
				src.isHS=0
				src.resistance = list("fire" = 240, "acid" = 320)
				if(Difficulty=="Easy")src.maxhealth=rand(500,550)
				else if(Difficulty=="Medium")src.maxhealth=rand(575,650)
				else if(Difficulty=="Hard")src.maxhealth=rand(675,775)
				else if(Difficulty=="Extreme")src.maxhealth=rand(700,850)
				src.icon='Hunter.dmi'
				src.icon_state="normal"
			else if(src.kills<=699&&gamemode!="Tongue Twister"||(src.kills<=600&&gamemode=="Eight Legged Freaks"))
				src.isHS=0
				src.resistance = list("fire" = 240, "acid" = 320)
				if(Difficulty=="Easy")src.maxhealth=rand(500,550)
				else if(Difficulty=="Medium")src.maxhealth=rand(575,650)
				else if(Difficulty=="Hard")src.maxhealth=rand(675,775)
				else if(Difficulty=="Extreme")src.maxhealth=rand(700,850)
				src.icon='Spider.dmi'
				src.icon_state="normal"
				src.deadspec="Web Grab"
				src.isspider=1
			else if(src.kills<=999)
				src.isHS=0
				src.icon='Mr.X.dmi'
				src.maxhealth=15000
				src.walkdelay=3
				src.ismrx=1
				src.deadspec="Transform"
				src.icon_state="normal"
				src.isBoss = 1
			else if(src.kills<=1499)
				src.isHS=0
				var/i=rand(1,2)
				if(i==1)
					src.icon='Tyrant.dmi'
				else
					src.icon='Tyrant2.dmi'
				src.istyrant=1
				src.maxhealth=20000
				src.walkdelay=1
				src.deadspec="Tentical Grab"
				src.icon_state="normal"
				src.isBoss = 1
			else if(src.kills<=1999)
				src.isHS=0
				src.icon='Nemises.dmi'
				src.isnemesis=1
				src.maxhealth=30000
				src.walkdelay=2
				src.deadspec="Rocket Launcher"
				src.icon_state="normal"
				src.isBoss = 1
			else
				src.isHS=0
				src.icon='Cyborg.dmi'
				src.iscyborg=1
				src.maxhealth=35000
				src.walkdelay=2
				src.deadspec="Transform"
				src.icon_state="normal"
				src.isBoss = 1
			src.overlays=new/list()
			src.health=src.maxhealth
			if(length(spawn_zone))
				src.loc=pick(spawn_zone)
			src.alignment=1
			src.see_in_dark=12
			src.sight=SEE_MOBS

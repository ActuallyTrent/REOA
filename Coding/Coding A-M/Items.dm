area/top
	icon = 'blank.dmi'
	layer=11
obj/Special
	Item
		Detonator
			var/clicked=0
			icon = 'Other.dmi'
			icon_state="Detonator"
			DblClick()
				var/mob/player/client/p=usr
				if(!p.gamein||GameOver||clicked)return
				src.clicked=1;spawn(20)if(src)src.clicked=0
				for(var/obj/Pickup/Items/C4/C in world)
					if(GameOver)break
					if(C.armed&&C.owner==p.key)
						C.BlowUp(2,675,p)
						sleep(10)

obj/Pickup
	tmp
		icon
		icon_state
	var/tmp
		cost = 100
	Guns
		var
			accuracy_level = 0
			clip_level = 0
			firerate_level = 0
			gunpower_level = 0
			reloadtime_level = 0
			accuracy_level_cost = 100
			clip_level_cost = 100
			firerate_level_cost = 100
			gunpower_level_cost = 100
			reloadtime_level_cost = 100
			accuracy = 50
			firerate = 10
			reload_time = 0
			fire_power = 0
			mclip = 0
			combined = 0
			cancombine = 0
			tmp
				//*****************************************
				clip = 0
				ammo = 0					//dont mess with this.
				maxammo = 0				//dont mess with this.
				otherclip = 1
				othermclip = 1
				othermaxammo = MAXNADEAMMO
				otherammo_type = "Explosive Rounds"
				otherprojectile = /obj/projectiles/explosive
				//the above is not to be messed with
				//*****************************************
				can_upgrade_fr = 1 			//can we upgrade the guns fire-rate?         0 - No ** 1 - Yes
				can_upgrade_rs = 1			//can we upgrade the guns reload speed?      0 - No ** 1 - Yes
				can_upgrade_fp = 1			//can we upgrade the guns fire power?        0 - No ** 1 - Yes
				can_upgrade_cc = 1			//can we upgrade the guns clip capacity?     0 - No ** 1 - Yes
				can_upgrade_ac = 1			//can we upgrade the guns accuracy?    		 0 - No ** 1 - Yes
				overlay_add = null			//the weapon icon to add over our character.
				flicker = null				//the flick state for when we fore the gun.(ex: he moves a little bit when he fires a gun)
				reload_sound = null			//what does the gun sound liek when we reload it?
				shell_reload_sound = null			//what does the gun sound liek when we reload it?
				fire_sound = null			//what does the gun sound liek when we fire it?
				ammo_type = null			//what type of ammo does this gun use?
				sound_wav = 60				//how loud should it be?
				//*****************************************
				at = null/* what is the weapons ammo type?
					1 - 9mm Parabellum Rounds
					2 - .357 Magnum Rounds
					3 - 12 Gauge Shells
					4 - .45 ACP Rounds
					5 - 5.56mm NatO Rounds*/
				//*****************************************
				stype = 3/*what shooting type is the weapon?
					1 - single fire
					2 - 3 - burst fire
					3 - full-auto
					4 - shotgun blast*/
				//*****************************************
				fshoot = 0					//no description.
				duableg = 0					//can we dualwield this gun?                    0 - No ** 1 - Yes
				spread = 0					//does it spread and hit more than 1 target?    0 - No ** 1 - Yes
				clip_round = 0				//does it reload in clips (shotguns)
				ammo_path = null			//ammo it uses again but more defind.
				range = 16
				sniper = 0
				projectile = null
				laser = null
				laserlength = 0
				grenade_launcher = null
				is_discard = 0
				list
					upgrade_fp=list(1=12,2=14,3=16,4=18,5=20)
					upgrade_rs=list(1=12,2=14,3=16,4=18,5=20)
					upgrade_mc=list(1=12,2=14,3=16,4=18,5=20)
					upgrade_fr=list(1=12,2=14,3=16,4=18,5=20)
					upgrade_ac=list(1=12,2=14,3=16,4=18,5=20)
		proc
			identify_ammo(var/mob/player/client/M, rload_type)
				if(!rload_type)
					if(src.grenade_launcher)
						switch(src.projectile)
							if(/obj/projectiles/acid)
								src.clip = M.otherammo["Acid"]
								src.ammo = M.ammo["Acid Rounds"]
							if(/obj/projectiles/flame)
								src.clip = M.otherammo["Flame"]
								src.ammo = M.ammo["Flame Rounds"]
							if(/obj/projectiles/freeze)
								src.clip = M.otherammo["Freeze"]
								src.ammo = M.ammo["Freeze Rounds"]
							if(/obj/projectiles/explosive)
								src.clip = M.otherammo["Explosive"]
								src.ammo = M.ammo["Explosive Rounds"]
					else
						if(src.sniper)
							M.sniper_range = src.range
						src.ammo = M.ammo["[src.ammo_type]"]
				else
					if(src.grenade_launcher)
						switch(src.projectile)
							if(/obj/projectiles/acid)
								M.otherammo["Acid"] = src.clip
								M.ammo["Acid Rounds"] = src.ammo
							if(/obj/projectiles/flame)
								M.otherammo["Flame"] = src.clip
								M.ammo["Flame Rounds"] = src.ammo
							if(/obj/projectiles/freeze)
								M.otherammo["Freeze"] = src.clip
								M.ammo["Freeze Rounds"] = src.ammo
							if(/obj/projectiles/explosive)
								M.otherammo["Explosive"] = src.clip
								M.ammo["Explosive Rounds"] = src.ammo
					else
						if(src.sniper)
							if(M.sniper_mode)
								M.sniper_range=16
								M.sniper_mode=0
								M.client.eye=M
								M.eye_x=10
								M.eye_y=10
								M.eye_z=1
						M.ammo["[src.ammo_type]"] = src.ammo
			/*	switch(src.at)
					if(1)
						if(!rload_type){src.ammo = M.ammo["9mm Parabellum Rounds"];src.maxammo = MAXLHAMMO}
						else M.ammo["9mm Parabellum Rounds"] = src.ammo
					if(2)
						if(!rload_type){src.ammo = M.ammo[".357 Magnum Rounds"];src.maxammo = MAXHHAMMO}
						else M.ammo[".357 Magnum Rounds"] = src.ammo
					if(3)
						if(!rload_type){src.ammo = M.ammo["12 Gauge Shells"];src.maxammo = MAXSGAMMO}
						else M.ammo["12 Gauge Shells"] = src.ammo
					if(4)
						if(!rload_type){src.ammo = M.ammo[".45 ACP Rounds"];src.maxammo = MAXACPAMMO}
						else M.ammo[".45 ACP Rounds"] = src.ammo
					if(5)
						if(!rload_type){src.ammo = M.ammo["5.56mm NatO Rounds"];src.maxammo = MAXNATOAMMO}
						else M.ammo["5.56mm NatO Rounds"] = src.ammo
					if(6)
						if(!rload_type){src.ammo = M.ammo["7.62x54mmR Rounds"];src.maxammo = MAXMMRAMMO}
						else M.ammo["7.62x54mmR Rounds"] = src.ammo
					if(7)
						if(!rload_type){src.ammo = M.ammo["Rockets"];src.maxammo = MAXROCKETAMMO}
						else M.ammo["Rockets"] = src.ammo*/
			check_upgrades()
				//if(src.can_upgrade_fr)
				if(src.firerate<src.upgrade_fr[length(src.upgrade_fr)])return 1
				//if(src.can_upgrade_rs)
				if(src.reload_time<src.upgrade_rs[length(src.upgrade_rs)])return 1
				//if(src.can_upgrade_fp)
				if(src.fire_power>src.upgrade_fp[length(src.upgrade_fp)])return 1
				//if(src.can_upgrade_cc)
				if(src.mclip>src.upgrade_mc[length(src.upgrade_mc)])return 1
				if(src.clip>(src.mclip+1))return 1
			check_reset()
				if(src.reload_time!=initial(src.reload_time)||src.mclip!=initial(src.mclip)||src.firerate!=initial(src.firerate)||src.fire_power!=initial(src.fire_power)||src.clip!=initial(src.clip))
					src.clip_level=initial(src.clip_level)
					src.firerate_level=initial(src.firerate_level)
					src.gunpower_level=initial(src.gunpower_level)
					src.reloadtime_level=initial(src.reloadtime_level)
					src.clip_level_cost=initial(src.clip_level_cost)
					src.firerate_level_cost=initial(src.firerate_level_cost)
					src.gunpower_level_cost=initial(src.gunpower_level_cost)
					src.reloadtime_level_cost=initial(src.reloadtime_level_cost)
					src.firerate=initial(src.firerate)
					src.reload_time=initial(src.reload_time)
					src.fire_power=initial(src.fire_power)
					src.mclip=initial(src.mclip)
					if(src.clip>src.mclip)src.clip=src.mclip
					return 1
			Equip_Proc(var/mob/player/client/M)
				if(!M||!M.client)return
				if(!M.weapon&&!M.weapon2)
					src.identify_ammo(M)
					src.suffix="[src.clip]/[src.mclip]"
					M.overlays+=src.overlay_add
					M.weapon=src
					M.lastclipn=10000
					M.hideunhide_hud(1,2,"Clip")
					if(M.inventory)M.updateihud(1,1)
					M<<sound(SOUND_CLICK,0,0,0,volume=(40-master_vol))
				else if(M.weapon&&!M.weapon2)
					if(src==M.weapon)
						if(istype(M.weapon,/obj/Pickup/Guns/M249))
							if(M.stand)
								M.weapon:removestand(M)
						if(istype(M.weapon,/obj/Pickup/Guns)&&M.weapon.projectile&&M.weapon.combined)
							M.weapon.removegl(M.weapon.clip,M.weapon.mclip,M.weapon.maxammo,M.weapon.ammo_type,M)
						src.identify_ammo(M,1)
						src.suffix=null
						M.overlays-=src.overlay_add
						M.weapon=null
						M.lastclipn=10000
						M.hideunhide_hud(2,2,"Clip")
						M.reset_shud("Clip")
						if(M.inventory)M.updateihud(1,1)
						M<<sound(SOUND_CLICK,0,0,0,volume=(40-master_vol))
					else if(src.type==M.weapon.type&&src.duableg)
						src.suffix="[src.clip]/[src.mclip]"
						M.overlays+=src.overlay_add
						M.weapon2=src
						M.lastclipn2=10000
						M.hideunhide_hud(1,2,"Clip2")
						if(M.inventory)M.updateihud(1,1)
						M<<sound(SOUND_CLICK,0,0,0,volume=(40-master_vol))
					else
						if(istype(M.weapon,/obj/Pickup/Guns/M249))
							if(M.stand)
								M.weapon:removestand(M)
						if(istype(M.weapon,/obj/Pickup/Guns)&&M.weapon.projectile&&M.weapon.combined)
							M.weapon.removegl(M.weapon.clip,M.weapon.mclip,M.weapon.maxammo,M.weapon.ammo_type,M)
						M.weapon.identify_ammo(M,1)
						M.weapon.suffix=null
						M.overlays-=M.weapon.overlay_add
						M.weapon=null
						src.identify_ammo(M)
						src.suffix="[src.clip]/[src.mclip]"
						M.overlays+=src.overlay_add
						M.weapon=src
						M.lastclipn=10000
						if(M.inventory)M.updateihud(1,1)
						M<<sound(SOUND_CLICK,0,0,0,volume=(40-master_vol))
				else if(M.weapon&&M.weapon2)
					if(src==M.weapon)
						if(istype(M.weapon,/obj/Pickup/Guns/M249))
							if(M.stand)
								M.weapon:removestand(M)
						if(istype(M.weapon,/obj/Pickup/Guns)&&M.weapon.projectile&&M.weapon.combined)
							M.weapon.removegl(M.weapon.clip,M.weapon.mclip,M.weapon.maxammo,M.weapon.ammo_type,M)
						src.identify_ammo(M,1)
						src.suffix=null
						M.overlays-=src.overlay_add
						M.weapon=null
						for(var/obj/Pickup/Guns/G in M.contents)
							if(G==M.weapon2){M.weapon2=null;M.weapon=G;break}
						M.weapon.identify_ammo(M)
						M.lastclipn=10000
						M.lastclipn2=10000
						M.hideunhide_hud(2,2,"Clip2")
						M.reset_shud("Clip2")
						if(M.inventory)M.updateihud(1,1)
						M<<sound(SOUND_CLICK,0,0,0,volume=(40-master_vol))
					else if(src==M.weapon2)
						src.suffix=null
						M.overlays-=src.overlay_add
						M.weapon2=null
						M.lastclipn2=10000
						M.hideunhide_hud(2,2,"Clip2")
						M.reset_shud("Clip2")
						if(M.inventory)M.updateihud(1,1)
						M<<sound(SOUND_CLICK,0,0,0,volume=(40-master_vol))
					else if(src.type!=M.weapon.type)
						if(istype(M.weapon,/obj/Pickup/Guns/M249))
							if(M.stand)
								M.weapon:removestand(M)
						if(istype(M.weapon,/obj/Pickup/Guns)&&M.weapon.projectile&&M.weapon.combined)
							M.weapon.removegl(M.weapon.clip,M.weapon.mclip,M.weapon.maxammo,M.weapon.ammo_type,M)
						M.weapon.identify_ammo(M,1)
						M.weapon.suffix=null
						M.overlays-=M.weapon.overlay_add
						M.weapon=null
						if(M.weapon2){M.weapon2.suffix=null;M.overlays-=M.weapon2.overlay_add;M.weapon2=null;M.hideunhide_hud(2,2,"Clip2");M.lastclipn2=10000;M.reset_shud("Clip2")}
						src.identify_ammo(M)
						src.suffix="[src.clip]/[src.mclip]"
						M.overlays+=src.overlay_add
						M.weapon=src
						M.lastclipn=10000
						if(M.inventory)M.updateihud(1,1)
						M<<sound(SOUND_CLICK,0,0,0,volume=(40-master_vol))
					else M<<"Unequip your current weapons."
		proc/addgl(var/Gclip,var/Gmclip,var/Gmaxammo,var/Gammo_type,var/firerate_add,var/reloadspeed_add,var/mob/player/client/M)
			src.ammo = M.ammo["[src.otherammo_type]"]
			src.clip = src.otherclip
			src.mclip = src.othermclip
			src.maxammo = src.othermaxammo
			src.ammo_type = src.otherammo_type
			src.ammo_path = src.otherprojectile

			src.otherclip = Gclip
			src.othermclip = Gmclip
			src.othermaxammo = Gmaxammo
			src.otherammo_type = Gammo_type

			src.firerate+=firerate_add
			src.reload_time+=reloadspeed_add

			src.projectile = /obj/projectiles/explosive
		proc/removegl(var/Gclip,var/Gmclip,var/Gmaxammo,var/Gammo_type,var/mob/player/client/M)
			src.ammo = M.ammo["[src.otherammo_type]"]
			src.clip = src.otherclip
			src.mclip = src.othermclip
			src.maxammo = src.othermaxammo
			src.ammo_type = src.otherammo_type
			src.ammo_path = src.otherprojectile

			src.otherclip = Gclip
			src.othermclip = Gmclip
			src.othermaxammo = Gmaxammo
			src.otherammo_type = Gammo_type

			src.firerate=1
			src.reload_time=26

			src.projectile = null
			if(src.reloadtime_level)
				src.reload_time=src.upgrade_rs[src.reloadtime_level]
			if(src.clip_level)
				src.mclip=src.upgrade_mc[src.clip_level]
		Click()
			var/mob/player/client/M=usr
			if(!M.gamein||GameOver)return
			if(length(M.contents)&&M.contents.Find(src))src.Equip_Proc(M)
		verb
			Drop()
				set category = "Commands"
				set src in usr
				set category = null
				var/mob/player/client/M=usr
				if(!(src in M))return
				if(!M.gamein||GameOver)return
				if(!src.suffix)
					src.layer=initial(src.layer)
					src.loc=M.loc
					M.update_items()
					if(src.is_discard)del(src)
				else
					if(M.weapon&&M.weapon==src)
						if(M.weapon2)
							src.identify_ammo(M,1)
							src.suffix=null
							M.overlays-=src.overlay_add
							M.weapon=null
							for(var/obj/Pickup/Guns/G2 in M.contents)
								if(G2==M.weapon2){M.weapon2=null;M.weapon=G2;break}
							M.weapon.identify_ammo(M)
							M.lastclipn=10000
							M.lastclipn2=10000
							M.hideunhide_hud(2,2,"Clip2")
							M.reset_shud("Clip2")
						else
							src.identify_ammo(M,1)
							src.suffix=null
							M.overlays-=src.overlay_add
							M.weapon=null
							M.lastclipn=10000
							M.hideunhide_hud(2,2,"Clip")
							M.reset_shud("Clip")
					else if(M.weapon2&&M.weapon2==src)
						src.suffix=null
						M.overlays-=src.overlay_add
						M.weapon2=null
						M.lastclipn=10000
						M.hideunhide_hud(2,2,"Clip2")
						M.reset_shud("Clip2")
					src.layer=initial(src.layer)
					src.loc=M.loc
					M.update_items()
					if(src.is_discard)del(src)
			Get()
				set src in oview(1)
				set category = null
				var/mob/player/client/M=usr
				if(!(src in oview(1)))return
				if(!M.gamein||GameOver)return
				if(M.check_items())
					M.contents+=src
					M.update_items()
			Check()
				set category = "Commands"
				set src in usr
				set category = null
				var/mob/player/client/M=usr
				var/html={"
					<html>
					<head><title>Check</title></head>
					<body>
					<style type="text/css">
						body{background-color: #000000; color: silver; scrollbar-face-color: #303030; scrollbar-highlight-color: #7A7A7A; scrollbar-3dlight-color: #555555; scrollbar-darkshadow-color: #3D3D3D; scrollbar-shadow-color: #171717; scrollbar-arrow-color: #F7F7F7; scrollbar-track-color: #1C1C1C}
					</style>
					<table cellpadding="11" cellspacing="0" border="1" width="100%">
					<td>
					"}
				html+="<b><u><font size=5>[src.name]</font size=5></u></b>"
				html+="<br>"
				html+="<br>"
				html+="<br>"
				html+="<br>"
				html+="<br>"
				html+="<br>"
				html+="<br>"
				if(src.at!=3)html+="Lv.([src.clip_level]) <b>Magizine Capacity</b>: [src.mclip]"
				else html+="Lv.([src.clip_level]) <b>Chamber Capacity</b>: [src.mclip]"
				html+="<br>"
				html+="Lv.([src.firerate_level]) <b>Firing Speed</b>: [src.firerate]"
				html+="<br>"
				html+="Lv.([src.gunpower_level]) <b>FirePower</b>: [src.fire_power]"
				html+="<br>"
				html+="Lv.([src.reloadtime_level]) <b>Reload Speed</b>: [src.reload_time]"
				html+="<br>"
				html+="Lv.([src.accuracy_level]) <b>Accuracy</b>: [src.accuracy]"
				html+="</td></table>"
				M<<browse(html,"window=Information;size=370x340")
	Items
		var
			tmp
				upgrade=0
				ammotogive
				max_grouped_item=2
			ammount=1
		verb/Drop()
			set category = "Commands"
			set src in usr
			set category = null
			var/mob/player/client/M=usr
			if(!(src in M))return
			if(!M.gamein||GameOver)return
			src.ammount--
			if(src.ammount<=1)src.suffix=null
			else src.suffix="x[src.ammount]"
			var/O= src.type
			new O(M.loc)
			if(src.ammount<=0)M.contents-=src
			M.update_items()
			if(src.ammount<=0)del(src)
		verb/Get()
			set category = "Commands"
			set src in oview(1)
			set category = null
			var/mob/player/client/M=usr
			if(!(src in oview(1))) return
			if(!M.gamein||GameOver)return
			if(!M.ammolimits["[src.name]"])
				if(prob(40))src<<"You cant carry that item."
				return
			switch(src.type)
				if(/obj/Pickup/Items/TripWire)
					var/obj/Pickup/Items/TripWire/C=src
					if(C.armed)return
					var/obj/Pickup/Items/O=locate(src.type) in M.contents
					if(O)
						if(O.ammount>=M.ammolimits["[src.name]"]){M<<"Cant carry anymore [src.name].";return}
						else{O.ammount++;O.suffix="x[O.ammount]";M.update_items();del(src)}
					else
						if(!M.check_items()){M<<"Cant carry anymore items";return}
						M.contents+=src
						M.update_items()
				if(/obj/Pickup/Items/C4)
					var/obj/Pickup/Items/C4/C=src
					if(C.armed&&C.owner!=M.key){M<<"This bomb is armed. only [C.owner] can pick it up.";return}
					var/obj/Pickup/Items/O=locate(src.type) in M.contents
					if(O)
						if(O.ammount>=M.ammolimits["[src.name]"]){M<<"Cant carry anymore [src.name].";return}
						else{O.ammount++;O.suffix="x[O.ammount]";M.update_items();del(src)}
					else
						if(!M.check_items()){M<<"Cant carry anymore items";return}
						C.armed=0
						C.owner=0
						C.icon_state="C4"
						M.contents+=src
						M.update_items()
				if(/obj/Pickup/Items/TCure)
					var/obj/Pickup/Items/TCure/C=locate(src.type) in M.contents
					if(C)
						if(C.ammount>=M.ammolimits["[src.name]"]){M<<"Cant carry anymore [src.name].";return}
						else{C.ammount++;C.suffix="x[C.ammount]";M.update_items();del(src)}
					if(!M.check_items()){M<<"Cant carry anymore items";return}
					M.contents+=src
					M.update_items()
				if(/obj/Pickup/Items/Grenade)
					if(M.grenade>=M.ammolimits["[src.name]"]){M<<"Full";return}
					else {M.grenade++;del(src)}
				if(/obj/Pickup/Items/Molotov)
					if(M.molotov>=M.ammolimits["[src.name]"]){M<<"Full";return}
					else {M.molotov++;del(src)}
				if(/obj/Pickup/Items/Land_Mine)
					var/obj/Pickup/Items/Land_Mine/C=src
					if(M.mine>=M.ammolimits["[src.name]"]){M<<"Full";return}
					else if(C.armed&&C.owner!=M){M<<"This mine is armed. only [C.owner] can pick it up.";return}
					else {M.mine++;del(src)}
				else
					for(var/obj/Pickup/Items/O in M.contents)
						if(O.type == src.type)
							if(O.ammount < M.ammolimits["[src.name]"])
								O.ammount++
								O.suffix="x[O.ammount]"
								M.update_items()
								del(src)
					if(!M.check_items()){M<<"Cant carry anymore items";return}
					M.contents+=src
					M.update_items()
	Spawn_Items
		var
			i_type
			i_name
		item_perm_spawner
			density=1
			New()
				..()
				if(!i_type)del(src)
				var/obj/o=new i_type
				src.icon=o.icon
				src.icon_state=o.icon_state
				src.name=o.name
				del(o)
		verb/Get()
			set category = "Commands"
			set src in oview(1)
			set category = null
			var/mob/player/client/M=usr
			if(!(src in oview(1))) return
			if(!M.gamein||GameOver)return
			if(!M.ammolimits["[src.name]"])
				if(prob(40))src<<"You cant carry that item."
				return
			if(!ispath(i_type))
				i_type=text2path(i_type)
				if(!ispath(i_type))return
			switch(src.i_type)
				if(/obj/Pickup/Items/TripWire)
					var/obj/Pickup/Items/O=locate(src.i_type) in M.contents
					if(O)
						if(O.ammount>=M.ammolimits["[src.name]"]){M<<"Cant carry anymore [src.name].";return}
						else{O.ammount++;O.suffix="x[O.ammount]";M.update_items()}
					else
						if(!M.check_items()){M<<"Cant carry anymore items";return}
						var/obj/o = new i_type
						M.contents+=o
						M.update_items()
				if(/obj/Pickup/Items/C4)
					var/obj/Pickup/Items/O=locate(src.i_type) in M.contents
					if(O)
						if(O.ammount>=M.ammolimits["[src.name]"]){M<<"Cant carry anymore [src.name].";return}
						else{O.ammount++;O.suffix="x[O.ammount]";M.update_items()}
					else
						if(!M.check_items()){M<<"Cant carry anymore items";return}
						var/obj/o = new i_type
						M.contents+=o
						M.update_items()
				if(/obj/Pickup/Items/TCure)
					var/obj/Pickup/Items/TCure/C=locate(src.i_type) in M.contents
					if(C)
						if(C.ammount>=M.ammolimits["[src.name]"]){M<<"Cant carry anymore [src.name].";return}
						else{C.ammount++;C.suffix="x[C.ammount]";M.update_items()}
					if(!M.check_items()){M<<"Cant carry anymore items";return}
					var/obj/o = new i_type
					M.contents+=o
					M.update_items()
				if(/obj/Pickup/Items/Grenade)
					if(M.grenade>=M.ammolimits["[src.name]"]){M<<"Full";return}
					else {M.grenade++}
				if(/obj/Pickup/Items/Molotov)
					if(M.molotov>=M.ammolimits["[src.name]"]){M<<"Full";return}
					else {M.molotov++}
				if(/obj/Pickup/Items/Land_Mine)
					if(M.mine>=M.ammolimits["[src.name]"]){M<<"Full";return}
					else {M.mine++}
				else
					for(var/obj/Pickup/Items/O in M.contents)
						if(O.type == src.i_type)
							if(O.ammount < M.ammolimits["[src.name]"])
								O.ammount++
								O.suffix="x[O.ammount]"
								M.update_items()
								return
					if(!M.check_items()){M<<"Cant carry anymore items";return}
					var/obj/o = new i_type
					M.contents+=o
					M.update_items()
obj/effects
	slash
		icon='effects.dmi'
		icon_state="slash"
		layer=4
		New(loc,dir)
			src.dir=dir
			..()
			var/x=rand(1,2)
			var/xp=rand(1,3)
			var/y=rand(1,2)
			var/yp=rand(1,3)
			switch(x)
				if(1)src.pixel_x+=xp
				if(2)src.pixel_x-=xp
			switch(y)
				if(1)src.pixel_y+=yp
				if(2)src.pixel_y-=yp
			spawn(2)
				del(src)


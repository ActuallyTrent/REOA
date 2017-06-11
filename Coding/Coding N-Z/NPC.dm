mob/player/NPC
	Bump(atom/A)
		if(istype(A,/obj/Attackable/Pushable_Obj))
			src.loc=A.loc
		else ..()
	New()
		..()
		spawn(20)
			..()
			if(gamemode=="Team Survival")del(src)
	gamein=1
	alignment=0
	proc
		NPC()
	var
		maxupgrade = 0
		upgrade_level = 0
		need_backup = 0
		ammo=0
		mammo=0
		clip
		aimfire=0
		mclip
		firepower
		gun_power
		gun
		mob/Monster/target
		weapon_sound
		fire_speed
		flick_state
		weapon_volume=40
		manned=0
		mob/player/client/man=null
		firetype
		projectile=null
		varheat=0
		mob/player/client/owner
		ownervar=null
		fire_type=1
		varheatmax=100
		laser=null
		laserlength=3
	Obj
		MANNED_TURRET
			MAN_1
				name=".50 Cal Mounted Rifle Unit"
				icon='turret.dmi'
				icon_state="MG"
				health=30
				weapon_sound=SOUND_AK47
				maxhealth=30
				see_in_dark=6
				firepower=50
				firetype=1
				flick_state="MGfire"
				fire_speed=1
				projectile=null
				Death()
					if(src.manned)
						src.man.manning=0
						src.man.turret=null
						src.man=null
						src.manned=0
					del(src)
				verb
					Man()
						set src in view(1)
						var/mob/player/client/M=usr
						if(src.manned)return
						if(M.manning||M.stuck)return
						usr.loc=src.loc
						src.manned=1
						M.turret=src
						src.man=M
						M.manning=1
						src.layer=M.layer+1
					Unman()
						set src in view(1)
						var/mob/player/client/M=usr
						if(!src.manned)return
						if(!M.manning)return
						if(src.man!=M)return
						src.manned=0
						M.turret=null
						src.man=null
						M.manning=0
						src.layer=initial(src.layer)
				New()
					spawn()src.cooldown()
					spawn()
						src.icon_state="MG"
						if(prob(5))
							new/mob/player/NPC/Obj/MANNED_TURRET/MAN_2(src.loc)
							del(src)
						else if(prob(5))
							new/mob/player/NPC/Obj/MANNED_TURRET/MAN_3(src.loc)
							del(src)
						else if(prob(5))
							new/mob/player/NPC/Obj/MANNED_TURRET/MAN_4(src.loc)
							del(src)
					..()
			MAN_2
				name="Fam0s Manned Rocket Unit"
				icon='turret.dmi'
				icon_state="Manturret"
				health=10
				maxhealth=10
				see_in_dark=6
				firetype=2
				flick_state="Manturretfire"
				fire_speed=15
				projectile=/obj/projectiles/rocket
				Death()
					if(src.manned)
						src.man.manning=0
						src.man.turret=null
						src.man=null
						src.manned=0
					del(src)
				verb
					Man()
						set src in view(1)
						var/mob/player/client/M=usr
						if(src.manned)return
						if(M.manning||(M.class!="Commander"&&M.class!="Demolitions")||M.stuck)return
						usr.loc=src.loc
						src.manned=1
						M.turret=src
						src.man=M
						M.manning=1
						src.layer=M.layer+1
					Unman()
						set src in view(1)
						var/mob/player/client/M=usr
						if(!src.manned)return
						if(!M.manning)return
						if(src.man!=M)return
						src.manned=0
						M.turret=null
						src.man=null
						M.manning=0
						src.layer=initial(src.layer)
				New()
					..()
					spawn()src.cooldown()
			MAN_4
				name="M0ltex Manned Unit"
				icon='turret.dmi'
				icon_state="Flameturret"
				health=10
				maxhealth=10
				see_in_dark=6
				firetype=4
				flick_state="Flameturretfire"
				fire_speed=1
				laser=/obj/projectiles/fire
				laserlength=7
				varheatmax = 400
				Death()
					if(src.manned)
						src.man.manning=0
						src.man.turret=null
						src.man=null
						src.manned=0
					del(src)
				verb
					Man()
						set src in view(1)
						var/mob/player/client/M=usr
						if(src.manned)return
						if(M.manning||(M.class!="Pyromaniac")||M.stuck)return
						usr.loc=src.loc
						src.manned=1
						M.turret=src
						src.man=M
						M.manning=1
						src.layer=M.layer+1
					Unman()
						set src in view(1)
						var/mob/player/client/M=usr
						if(!src.manned)return
						if(!M.manning)return
						if(src.man!=M)return
						src.manned=0
						M.turret=null
						src.man=null
						M.manning=0
						src.layer=initial(src.layer)
				New()
					..()
					spawn()src.cooldown()
			MAN_3
				name="XvX \"Flak Master\" Cannon"
				icon='turret.dmi'
				icon_state="MG"
				health=10
				weapon_sound=SOUND_MATILDA
				maxhealth=10
				see_in_dark=6
				firetype=3
				flick_state="MGfire"
				fire_speed=10
				firepower=20
				Death()
					if(src.manned)
						src.man.manning=0
						src.man.turret=null
						src.man=null
						src.manned=0
					del(src)
				verb
					Man()
						set src in view(1)
						var/mob/player/client/M=usr
						if(src.manned)return
						if(M.manning||(M.class!="Engineer"&&M.class!="Infiltraitor")||M.stuck)return
						usr.loc=src.loc
						src.manned=1
						M.turret=src
						src.man=M
						M.manning=1
						src.layer=M.layer+1
					Unman()
						set src in view(1)
						var/mob/player/client/M=usr
						if(!src.manned)return
						if(!M.manning)return
						if(src.man!=M)return
						src.manned=0
						M.turret=null
						src.man=null
						M.manning=0
						src.layer=initial(src.layer)
				New()
					..()
					spawn()src.cooldown()
			proc/cooldown()
				while(src)
					var/varnum=(src.varheat/3)
					sleep(rand(1,varnum))
					if(src.varheat)src.varheat-=(rand(1,varnum/(rand(1,3))))
		personal_sentry_turret
			name="Sentry Turret"
			icon='turret.dmi'
			icon_state="normal"
			health=15
			maxhealth=15
			see_in_dark=6
			New(loc)
				..()
				src.flick_state="normalfire"
				src.weapon_sound=SOUND_UMP45_1
				fire_speed=1
				gun_power=30
				clip=60
				mclip=60
				spawn()src.NPC()
			Death()
				del(src)
			verb/get()
				set src in oview(1)
				set category = null
				var/mob/player/client/M=usr
				if(!(src in oview(1)))return
				if(!M.gamein||GameOver||!src.owner||usr!=src.owner)return
				if(M.check_items())
					var/obj/Pickup/Items/Turret/T = new/obj/Pickup/Items/Turret
					T.ammount = 1
					T.upgrade=src.upgrade_level
					M.contents+=T
					M.update_items(1)
					del(src)
		sentry_turret
			name="Sentry Turret"
			icon='turret.dmi'
			icon_state="normal"
			health=8
			maxhealth=8
			see_in_dark=6
			New(loc)
				..()
				src.flick_state="normalfire"
				src.weapon_sound=SOUND_AUG_1
				fire_speed=1
				gun_power=28
				clip=42
				mclip=42
				spawn()src.NPC()
			Death()
				del(src)
		nod_sentry_turret
			name="Nod Cannon"
			icon='turret.dmi'
			icon_state="Nodcannon"
			health=20
			maxhealth=20
			fire_type=2
			projectile=/obj/projectiles/explosive
			see_in_dark=6
			New(loc)
				..()
				src.flick_state="Nodcannonfire"
				src.weapon_sound=SOUND_ROCKET
				fire_speed=100
				gun_power=100
				clip=1
				mclip=1
				spawn()src.NPC()
			Death()
				del(src)
		GDI_sentry_turret
			name="GDI Vulcan Turret"
			icon='turret.dmi'
			icon_state="GDI"
			health=20
			maxhealth=20
			see_in_dark=6
			fire_type=3
			New(loc)
				..()
				src.flick_state="GDIfire"
				src.weapon_sound=SOUND_UMP45_1
				fire_speed=1
				gun_power=15
				clip=100000
				mclip=100000
				spawn()src.NPC()
			Death()
				del(src)
		pillbox
			name="Pillbox"
			icon='turret.dmi'
			icon_state="Pillbox"
			health=38
			maxhealth=38
			see_in_dark=6
			New(loc)
				..()
				src.flick_state="Pillboxfire"
				src.weapon_sound=SOUND_UMP45_1
				fire_speed=0.1
				gun_power=10
				clip=100
				mclip=100
				spawn()src.NPC()
			Death()
				del(src)
		NPC()
			if(GameOver)return
			if(!src.target)
				for(var/mob/Z in oview(rand(4,6),src))
					if(!Z.alignment||Z.isdead)continue
					src.target=Z
				spawn(1)src.NPC()
				return
			else
				var/targetdist=get_dist(src.target,src)
				if(targetdist>6)
					src.target=null
					spawn(rand(3,6))src.NPC()
					return
				else if(targetdist<=6)
					if(src.clip>0)
						src.clip--
						src.dir=get_dir(src,src.target)
						orange(7,src)<<sound(src.weapon_sound,0,0,0,volume=(src.weapon_volume-master_vol))
						flick(src.flick_state,src)
						switch(src.fire_type)
							if(1)
								var/chancehit=100
								chancehit-=(10*targetdist)
								chancehit-=rand(1,8)
								if(prob(chancehit))
									//new/obj/blood_effects/splatter(src.target.loc)
									var/damage=src.gun_power
									if(prob(BLOODDROPRATE) && length(src.target.loc.overlays) < MAX_BLOOD)src.target.loc.overlays += new/obj/blood_effects/blood
									src.target.health-=damage
									if(src.target.health<=0)
										if(src.owner)
											src.owner.kills++
											death_zombie(src.owner.team,src.target)
										else
											death_zombie(null,src.target)
								spawn(src.fire_speed)src.NPC()
								return
							if(2)
								var/obj/projectiles/O = new src.projectile
								O.owner = null
								if(src.owner)
									O.owner=src.owner
								O.density = 1
								O.loc = src.loc
								O.dir = src.dir
								O.target = src.target
								spawn()O.projectile_loop_2(src.target)
								spawn(src.fire_speed)src.NPC()
								return
							if(3)
								var/dir_2=turn(src.dir,-45)
								var/dir_3=turn(src.dir,45)
								var/count=rand(2,3)
								var/damage=src.gun_power
								for(var/mob/Z in oview(7,src))
									if(!Z.alignment)continue
									else if(!count)break
									if(get_dir(src,Z)==src.dir||get_dir(src,Z)==dir_2||get_dir(src,Z)==dir_3)
										if(get_dist(src,Z)<=1)
											Z.health-=(damage*2.5)
										else if(get_dist(src,Z)<=2)
											Z.health-=damage*1.5
										else if(get_dist(src,Z)<=3)
											Z.health-=damage
										else if(get_dist(src,Z)<=4)
											Z.health-=(damage/4)
										else
											Z.health-=(damage/5)
										if(prob(BLOODDROPRATE) && length(Z.loc.overlays) < MAX_BLOOD)Z.loc.overlays += new/obj/blood_effects/blood
										if(Z.health<=0)
											if(src.owner)
												src.owner.kills++
												death_zombie(src.owner.team,Z)
											else
												death_zombie(null,src.target)
											if(prob(10))range(7,src)<<sound(SOUND_ENEMYDOWN,volume=(100-master_vol))
										count--
								var/time=src.fire_speed
								if(prob(30))time++
								spawn(time)src.NPC()
								return
					else
						sleep(70)
						src.clip=mclip
						spawn()src.NPC()
						return
				else
					spawn(rand(7,12))src.NPC()
					return
	Mob
		var/chance=0
		proc/walk_here(atom/T)
			var/step_num=get_dist(src,T)
			spawn()
				for(var/i=1,i<=step_num,i++)
					step_to(src,T)
					sleep(10)
		proc/cut_here(atom/T,B)
			var/step_num=get_dist(src,T)
			spawn()
				for(var/i=1,i<=step_num,i++)
					if(B)
						step_to(src,T)
						sleep(10)
		Death()
			range(src)<<sound(SOUND_NPCDEATH,volume=(rand(70,100)-master_vol))
			if(src.stuck)
				for(var/line/line)
					if(line.reftarg==src)
						if(istype(line.owner,/mob/Monster/Boss/Tyrant)||istype(line.owner,/mob/Monster/Boss/Tyrant_T700))
							line.owner:moblist-=src
							line.owner:licks--
							if(line.owner:licks<=0)
								line.owner:wrapping=0
						else if(istype(line.owner,/mob/Monster/Spider)||(istype(line.owner,/mob/player/client)&&line.owner:isspider))
							line.owner:webbing=0
						else
							line.owner:licking=0
						del(line)
						break
			del(src)
		UCM
			DblClick()
				var/mob/player/client/M=usr
				if(M.command&&!M.alignment)
					if(src.owner==M)
						M.under_command-=src
						src.owner=null
						M<<"You stop commanding this UCM"
						return
					if(!(src in M.under_command)&&length(M.under_command)<M.commandmax&&!src.owner)
						M.under_command+=src
						M<<"You can command this UCM"
						src.owner=M
			name="U.C.M"
			icon='Hunk.dmi'
			icon_state="normal"
			health=16
			maxhealth=16
			see_in_dark=4
			New()
				switch(rand(1,3))
					if(1){src.gun='G3SG1.dmi';src.flick_state="ShootingMachineH";src.weapon_sound=SOUND_G3SG1_1;fire_speed=1;gun_power=29;clip=20;mclip=20;mammo=500}
					if(2){src.gun='AUG.dmi';src.flick_state="ShootingMachineH";src.weapon_sound=SOUND_AUG_1;fire_speed=1;gun_power=27;clip=36;mclip=36;mammo=500}
					if(3){src.gun='CustomH.dmi';src.flick_state="ShootingHandgun";src.weapon_sound=SOUND_M92F_CUSTOM_HANDGUN_FIRE;fire_speed=7;gun_power=40;clip=12;mclip=12;mammo=140}
				src.overlays+=gun
				src.grenade=3
				src.ammo=(src.mammo-rand(20,40))
				..()
				spawn(100)
					if(prob(10))
						new/mob/player/NPC/Mob/SWAT(src.loc)
						del(src)
					src.NPC()
		SWAT
			DblClick()
				var/mob/player/client/M=usr
				if(M.command&&M.class=="Commander"&&!M.alignment)
					if(src.owner==M)
						M.under_command-=src
						src.owner=null
						M<<"You stop commanding this SWAT"
						return
					if(!(src in M.under_command)&&length(M.under_command)<M.commandmax&&!src.owner&&M.class=="Commander"&&!M.alignment)
						M.under_command+=src
						M<<"You can command this SWAT"
						src.owner=M
			name="S.W.A.T"
			icon='Swat.dmi'
			icon_state="normal"
			health=20
			maxhealth=20
			see_in_dark=4
			New()
				switch(rand(1,2))
					if(1){src.gun='UMP45.dmi';src.flick_state="ShootingMachineL";src.weapon_sound=SOUND_UMP45_1;fire_speed=0.5;gun_power=30;clip=26;mclip=26;mammo=900}
					if(2){src.gun='AUG.dmi';src.flick_state="ShootingMachineH";src.weapon_sound=SOUND_AUG_1;fire_speed=1;gun_power=27;clip=36;mclip=36;mammo=500}
				src.overlays+=gun
				src.grenade=7
				src.ammo=(src.mammo-rand(20,40))
				..()
				spawn()src.NPC()
		Scientist_1
			DblClick()
				var/mob/player/client/M=usr
				if(M.command&&M.class=="Commander"&&!M.alignment)
					if(src.owner==M)
						M.under_command-=src
						src.owner=null
						M<<"You stop commanding this Scientist"
						return
					if(!(src in M.under_command)&&length(M.under_command)<M.commandmax&&!src.owner&&M.class=="Commander"&&!M.alignment)
						M.under_command+=src
						M<<"You can command this Scientist"
						src.owner=M
			name="Scientist"
			icon='Scientists (1).dmi'
			icon_state="normal"
			health=20
			maxhealth=20
			see_in_dark=4
			New()
				switch(rand(1,2))
					if(1){src.gun='CustomH.dmi';src.flick_state="ShootingHandgun";src.weapon_sound=SOUND_M92F_CUSTOM_HANDGUN_FIRE;fire_speed=7;gun_power=21;clip=12;mclip=12;mammo=5200}
					if(2){src.gun='CustomH.dmi';src.flick_state="ShootingHandgun";src.weapon_sound=SOUND_M92F_CUSTOM_HANDGUN_FIRE;fire_speed=7;gun_power=21;clip=12;mclip=12;mammo=5200}
				src.overlays+=gun
				src.grenade=7
				src.ammo=(src.mammo-rand(20,40))
				..()
				spawn()src.NPC()
		Scientist_2
			DblClick()
				var/mob/player/client/M=usr
				if(M.command&&M.class=="Commander"&&!M.alignment)
					if(src.owner==M)
						M.under_command-=src
						src.owner=null
						M<<"You stop commanding this Scientist"
						return
					if(!(src in M.under_command)&&length(M.under_command)<M.commandmax&&!src.owner&&M.class=="Commander"&&!M.alignment)
						M.under_command+=src
						M<<"You can command this Scientist"
						src.owner=M
			name="Scientist"
			icon='Scientists (2).dmi'
			icon_state="normal"
			health=20
			maxhealth=20
			see_in_dark=4
			New()
				switch(rand(1,2))
					if(1){src.gun='CustomH.dmi';src.flick_state="ShootingHandgun";src.weapon_sound=SOUND_M92F_CUSTOM_HANDGUN_FIRE;fire_speed=7;gun_power=21;clip=12;mclip=12;mammo=5200}
					if(2){src.gun='CustomH.dmi';src.flick_state="ShootingHandgun";src.weapon_sound=SOUND_M92F_CUSTOM_HANDGUN_FIRE;fire_speed=7;gun_power=21;clip=12;mclip=12;mammo=5200}
				src.overlays+=gun
				src.grenade=7
				src.ammo=(src.mammo-rand(20,40))
				..()
				spawn()src.NPC()
		Scientist_3
			DblClick()
				var/mob/player/client/M=usr
				if(M.command&&M.class=="Commander"&&!M.alignment)
					if(src.owner==M)
						M.under_command-=src
						src.owner=null
						M<<"You stop commanding this Scientist"
						return
					if(!(src in M.under_command)&&length(M.under_command)<M.commandmax&&!src.owner&&M.class=="Commander"&&!M.alignment)
						M.under_command+=src
						M<<"You can command this Scientist"
						src.owner=M
			name="Scientist"
			icon='Scientists (3).dmi'
			icon_state="normal"
			health=20
			maxhealth=20
			see_in_dark=4
			New()
				switch(rand(1,2))
					if(1){src.gun='CustomH.dmi';src.flick_state="ShootingHandgun";src.weapon_sound=SOUND_M92F_CUSTOM_HANDGUN_FIRE;fire_speed=7;gun_power=21;clip=12;mclip=12;mammo=5200}
					if(2){src.gun='CustomH.dmi';src.flick_state="ShootingHandgun";src.weapon_sound=SOUND_M92F_CUSTOM_HANDGUN_FIRE;fire_speed=7;gun_power=21;clip=12;mclip=12;mammo=5200}
				src.overlays+=gun
				src.grenade=7
				src.ammo=(src.mammo-rand(20,40))
				..()
				spawn()src.NPC()
		Nod_Captain
			DblClick()
				var/mob/player/client/M=usr
				if(M.command&&M.class=="Commander"&&!M.alignment)
					if(src.owner==M)
						M.under_command-=src
						src.owner=null
						M<<"You stop commanding this Nod Soldier"
						return
					if(!(src in M.under_command)&&length(M.under_command)<M.commandmax&&!src.owner&&M.class=="Commander"&&!M.alignment)
						M.under_command+=src
						M<<"You can command this Nod Soldier"
						src.owner=M
			name="Nod Captain"
			icon='Nod Captain.dmi'
			icon_state="normal"
			health=20
			maxhealth=20
			see_in_dark=4
			New()
				switch(rand(1,2))
					if(1){src.gun='MP5N.dmi';src.flick_state="ShootingMachineL";src.weapon_sound=SOUND_G3SG1_1;fire_speed=1;gun_power=70;clip=46;mclip=46;mammo=1000}
					if(2){src.gun='MP5N.dmi';src.flick_state="ShootingMachineL";src.weapon_sound=SOUND_G3SG1_1;fire_speed=1;gun_power=70;clip=46;mclip=46;mammo=1000}
				src.overlays+=gun
				src.grenade=7
				src.ammo=(src.mammo-rand(20,40))
				..()
				spawn()src.NPC()
		Nod_Commando
			DblClick()
				var/mob/player/client/M=usr
				if(M.command&&M.class=="Commander"&&!M.alignment)
					if(src.owner==M)
						M.under_command-=src
						src.owner=null
						M<<"You stop commanding this Nod Soldier"
						return
					if(!(src in M.under_command)&&length(M.under_command)<M.commandmax&&!src.owner&&M.class=="Commander"&&!M.alignment)
						M.under_command+=src
						M<<"You can command this Nod Soldier"
						src.owner=M
			name="Nod Commando"
			icon='Nod Commando.dmi'
			icon_state="normal"
			health=20
			maxhealth=20
			see_in_dark=4
			New()
				switch(rand(1,2))
					if(1){src.gun='MP5N.dmi';src.flick_state="ShootingMachineL";src.weapon_sound=SOUND_G3SG1_1;fire_speed=1;gun_power=70;clip=46;mclip=46;mammo=1000}
					if(2){src.gun='MP5N.dmi';src.flick_state="ShootingMachineL";src.weapon_sound=SOUND_G3SG1_1;fire_speed=1;gun_power=70;clip=46;mclip=46;mammo=1000}
				src.overlays+=gun
				src.grenade=7
				src.ammo=(src.mammo-rand(20,40))
				..()
				spawn()src.NPC()
		Nod_Infiltrator
			DblClick()
				var/mob/player/client/M=usr
				if(M.command&&M.class=="Commander"&&!M.alignment)
					if(src.owner==M)
						M.under_command-=src
						src.owner=null
						M<<"You stop commanding this Nod Soldier"
						return
					if(!(src in M.under_command)&&length(M.under_command)<M.commandmax&&!src.owner&&M.class=="Commander"&&!M.alignment)
						M.under_command+=src
						M<<"You can command this Nod Soldier"
						src.owner=M
			name="Nod Infiltrator"
			icon='Nod Infiltrator.dmi'
			icon_state="normal"
			health=20
			maxhealth=20
			see_in_dark=4
			New()
				switch(rand(1,2))
					if(1){src.gun='MP5N.dmi';src.flick_state="ShootingMachineL";src.weapon_sound=SOUND_G3SG1_1;fire_speed=1;gun_power=70;clip=46;mclip=46;mammo=1000}
					if(2){src.gun='MP5N.dmi';src.flick_state="ShootingMachineL";src.weapon_sound=SOUND_G3SG1_1;fire_speed=1;gun_power=70;clip=46;mclip=46;mammo=1000}
				src.overlays+=gun
				src.grenade=7
				src.ammo=(src.mammo-rand(20,40))
				..()
				spawn()src.NPC()
		Nod_Seargent
			DblClick()
				var/mob/player/client/M=usr
				if(M.command&&M.class=="Commander"&&!M.alignment)
					if(src.owner==M)
						M.under_command-=src
						src.owner=null
						M<<"You stop commanding this Nod Soldier"
						return
					if(!(src in M.under_command)&&length(M.under_command)<M.commandmax&&!src.owner&&M.class=="Commander"&&!M.alignment)
						M.under_command+=src
						M<<"You can command this Nod Soldier"
						src.owner=M
			name="Nod Seargent"
			icon='Nod Seargent.dmi'
			icon_state="normal"
			health=20
			maxhealth=20
			see_in_dark=4
			New()
				switch(rand(1,2))
					if(1){src.gun='MP5N.dmi';src.flick_state="ShootingMachineL";src.weapon_sound=SOUND_G3SG1_1;fire_speed=1;gun_power=70;clip=46;mclip=46;mammo=1000}
					if(2){src.gun='MP5N.dmi';src.flick_state="ShootingMachineL";src.weapon_sound=SOUND_G3SG1_1;fire_speed=1;gun_power=70;clip=46;mclip=46;mammo=1000}
				src.overlays+=gun
				src.grenade=7
				src.ammo=(src.mammo-rand(20,40))
				..()
				spawn()src.NPC()
		Nod_Soldier
			DblClick()
				var/mob/player/client/M=usr
				if(M.command&&M.class=="Commander"&&!M.alignment)
					if(src.owner==M)
						M.under_command-=src
						src.owner=null
						M<<"You stop commanding this Nod Soldier"
						return
					if(!(src in M.under_command)&&length(M.under_command)<M.commandmax&&!src.owner&&M.class=="Commander"&&!M.alignment)
						M.under_command+=src
						M<<"You can command this Nod Soldier"
						src.owner=M
			name="Nod Soldier"
			icon='Nod Soldier.dmi'
			icon_state="normal"
			health=20
			maxhealth=20
			see_in_dark=4
			New()
				switch(rand(1,2))
					if(1){src.gun='MP5N.dmi';src.flick_state="ShootingMachineL";src.weapon_sound=SOUND_G3SG1_1;fire_speed=1;gun_power=70;clip=46;mclip=46;mammo=1000}
					if(2){src.gun='MP5N.dmi';src.flick_state="ShootingMachineL";src.weapon_sound=SOUND_G3SG1_1;fire_speed=1;gun_power=70;clip=46;mclip=46;mammo=1000}
				src.overlays+=gun
				src.grenade=7
				src.ammo=(src.mammo-rand(20,40))
				..()
				spawn()src.NPC()
		Nod_Winter_Soldier
			DblClick()
				var/mob/player/client/M=usr
				if(M.command&&M.class=="Commander"&&!M.alignment)
					if(src.owner==M)
						M.under_command-=src
						src.owner=null
						M<<"You stop commanding this Nod Soldier"
						return
					if(!(src in M.under_command)&&length(M.under_command)<M.commandmax&&!src.owner&&M.class=="Commander"&&!M.alignment)
						M.under_command+=src
						M<<"You can command this Nod Soldier"
						src.owner=M
			name="Nod Winter Soldier"
			icon='Nod Winter Soldier.dmi'
			icon_state="normal"
			health=20
			maxhealth=20
			see_in_dark=4
			New()
				switch(rand(1,2))
					if(1){src.gun='MP5N.dmi';src.flick_state="ShootingMachineL";src.weapon_sound=SOUND_G3SG1_1;fire_speed=1;gun_power=70;clip=46;mclip=46;mammo=1000}
					if(2){src.gun='MP5N.dmi';src.flick_state="ShootingMachineL";src.weapon_sound=SOUND_G3SG1_1;fire_speed=1;gun_power=70;clip=46;mclip=46;mammo=1000}
				src.overlays+=gun
				src.grenade=7
				src.ammo=(src.mammo-rand(20,40))
				..()
				spawn()src.NPC()
		Black_Hand
			DblClick()
				var/mob/player/client/M=usr
				if(M.command&&M.class=="Commander"&&!M.alignment)
					if(src.owner==M)
						M.under_command-=src
						src.owner=null
						M<<"You stop commanding this Black Hand Soldier"
						return
					if(!(src in M.under_command)&&length(M.under_command)<M.commandmax&&!src.owner&&M.class=="Commander"&&!M.alignment)
						M.under_command+=src
						M<<"You can command this Black Hand Soldier"
						src.owner=M
			name="Black Hand"
			icon='Black Hand.dmi'
			icon_state="normal"
			health=20
			maxhealth=20
			see_in_dark=4
			New()
				switch(rand(1,2))
					if(1){src.gun='M4A1CarbineN.dmi';src.flick_state="ShootingMachineH";src.weapon_sound=SOUND_G3SG1_1;fire_speed=1;gun_power=300;clip=500;mclip=500;mammo=100000000}
					if(2){src.gun='M4A1CarbineN.dmi';src.flick_state="ShootingMachineH";src.weapon_sound=SOUND_G3SG1_1;fire_speed=1;gun_power=300;clip=500;mclip=500;mammo=100000000}
				src.overlays+=gun
				src.grenade=7
				src.ammo=(src.mammo-rand(20,40))
				..()
				spawn()src.NPC()
		Black_Hand_Legionare
			DblClick()
				var/mob/player/client/M=usr
				if(M.command&&M.class=="Commander"&&!M.alignment)
					if(src.owner==M)
						M.under_command-=src
						src.owner=null
						M<<"You stop commanding this Black Hand Soldier"
						return
					if(!(src in M.under_command)&&length(M.under_command)<M.commandmax&&!src.owner&&M.class=="Commander"&&!M.alignment)
						M.under_command+=src
						M<<"You can command this Black Hand Soldier"
						src.owner=M
			name="Black Hand Legionare"
			icon='Blackhand Legionare.dmi'
			icon_state="normal"
			health=20
			maxhealth=20
			see_in_dark=4
			New()
				switch(rand(1,2))
					if(1){src.gun='M4A1CarbineN.dmi';src.flick_state="ShootingMachineH";src.weapon_sound=SOUND_G3SG1_1;fire_speed=1;gun_power=300;clip=500;mclip=500;mammo=100000000}
					if(2){src.gun='M4A1CarbineN.dmi';src.flick_state="ShootingMachineH";src.weapon_sound=SOUND_G3SG1_1;fire_speed=1;gun_power=300;clip=500;mclip=500;mammo=100000000}
				src.overlays+=gun
				src.grenade=7
				src.ammo=(src.mammo-rand(20,40))
				..()
				spawn()src.NPC()
		Black_Hand_Sniper_Commander
			DblClick()
				var/mob/player/client/M=usr
				if(M.command&&M.class=="Commander"&&!M.alignment)
					if(src.owner==M)
						M.under_command-=src
						src.owner=null
						M<<"You stop commanding this Black Hand Soldier"
						return
					if(!(src in M.under_command)&&length(M.under_command)<M.commandmax&&!src.owner&&M.class=="Commander"&&!M.alignment)
						M.under_command+=src
						M<<"You can command this Black Hand Soldier"
						src.owner=M
			name="Black Hand Sniper Commander"
			icon='Blackhand Sniper Commander.dmi'
			icon_state="normal"
			health=20
			maxhealth=20
			see_in_dark=4
			New()
				switch(rand(1,2))
					if(1){src.gun='M4A1CarbineN.dmi';src.flick_state="ShootingMachineH";src.weapon_sound=SOUND_G3SG1_1;fire_speed=1;gun_power=300;clip=500;mclip=500;mammo=100000000}
					if(2){src.gun='M4A1CarbineN.dmi';src.flick_state="ShootingMachineH";src.weapon_sound=SOUND_G3SG1_1;fire_speed=1;gun_power=300;clip=500;mclip=500;mammo=100000000}
				src.overlays+=gun
				src.grenade=7
				src.ammo=(src.mammo-rand(20,40))
				..()
				spawn()src.NPC()
		Black_Hand_Sniper
			DblClick()
				var/mob/player/client/M=usr
				if(M.command&&M.class=="Commander"&&!M.alignment)
					if(src.owner==M)
						M.under_command-=src
						src.owner=null
						M<<"You stop commanding this Black Hand Soldier"
						return
					if(!(src in M.under_command)&&length(M.under_command)<M.commandmax&&!src.owner&&M.class=="Commander"&&!M.alignment)
						M.under_command+=src
						M<<"You can command this Black Hand Soldier"
						src.owner=M
			name="Black Hand Sniper"
			icon='Blackhand Sniper.dmi'
			icon_state="normal"
			health=20
			maxhealth=20
			see_in_dark=4
			New()
				switch(rand(1,2))
					if(1){src.gun='M4A1CarbineN.dmi';src.flick_state="ShootingMachineH";src.weapon_sound=SOUND_G3SG1_1;fire_speed=1;gun_power=300;clip=500;mclip=500;mammo=100000000}
					if(2){src.gun='M4A1CarbineN.dmi';src.flick_state="ShootingMachineH";src.weapon_sound=SOUND_G3SG1_1;fire_speed=1;gun_power=300;clip=500;mclip=500;mammo=100000000}
				src.overlays+=gun
				src.grenade=7
				src.ammo=(src.mammo-rand(20,40))
				..()
				spawn()src.NPC()
		Black_Hand_Soldier
			DblClick()
				var/mob/player/client/M=usr
				if(M.command&&M.class=="Commander"&&!M.alignment)
					if(src.owner==M)
						M.under_command-=src
						src.owner=null
						M<<"You stop commanding this Black Hand Soldier"
						return
					if(!(src in M.under_command)&&length(M.under_command)<M.commandmax&&!src.owner&&M.class=="Commander"&&!M.alignment)
						M.under_command+=src
						M<<"You can command this Black Hand Soldier"
						src.owner=M
			name="Black Hand Soldier"
			icon='Blackhand Soldier.dmi'
			icon_state="normal"
			health=20
			maxhealth=20
			see_in_dark=4
			New()
				switch(rand(1,2))
					if(1){src.gun='M4A1CarbineN.dmi';src.flick_state="ShootingMachineH";src.weapon_sound=SOUND_G3SG1_1;fire_speed=1;gun_power=300;clip=500;mclip=500;mammo=100000000}
					if(2){src.gun='M4A1CarbineN.dmi';src.flick_state="ShootingMachineH";src.weapon_sound=SOUND_G3SG1_1;fire_speed=1;gun_power=300;clip=500;mclip=500;mammo=100000000}
				src.overlays+=gun
				src.grenade=7
				src.ammo=(src.mammo-rand(20,40))
				..()
				spawn()src.NPC()
		GDI_Army_Branch
			DblClick()
				var/mob/player/client/M=usr
				if(M.command&&M.class=="Commander"&&!M.alignment)
					if(src.owner==M)
						M.under_command-=src
						src.owner=null
						M<<"You stop commanding this GDI Soldier"
						return
					if(!(src in M.under_command)&&length(M.under_command)<M.commandmax&&!src.owner&&M.class=="Commander"&&!M.alignment)
						M.under_command+=src
						M<<"You can command this GDI Soldier"
						src.owner=M
			name="GDI Army Branch"
			icon='GDI Army Branch.dmi'
			icon_state="normal"
			health=20
			maxhealth=20
			see_in_dark=4
			New()
				switch(rand(1,2))
					if(1){src.gun='M4A1CarbineG.dmi';src.flick_state="ShootingMachineH";src.weapon_sound=SOUND_G3SG1_1;fire_speed=1;gun_power=60;clip=60;mclip=60;mammo=6000}
					if(2){src.gun='M4A1CarbineG.dmi';src.flick_state="ShootingMachineH";src.weapon_sound=SOUND_G3SG1_1;fire_speed=1;gun_power=60;clip=60;mclip=60;mammo=6000}
				src.overlays+=gun
				src.grenade=7
				src.ammo=(src.mammo-rand(20,40))
				..()
				spawn()src.NPC()
		GDI_Captain
			DblClick()
				var/mob/player/client/M=usr
				if(M.command&&M.class=="Commander"&&!M.alignment)
					if(src.owner==M)
						M.under_command-=src
						src.owner=null
						M<<"You stop commanding this GDI Soldier"
						return
					if(!(src in M.under_command)&&length(M.under_command)<M.commandmax&&!src.owner&&M.class=="Commander"&&!M.alignment)
						M.under_command+=src
						M<<"You can command this GDI Soldier"
						src.owner=M
			name="GDI Captain"
			icon='GDI Captain.dmi'
			icon_state="normal"
			health=20
			maxhealth=20
			see_in_dark=4
			New()
				switch(rand(1,2))
					if(1){src.gun='M4A1CarbineG.dmi';src.flick_state="ShootingMachineH";src.weapon_sound=SOUND_G3SG1_1;fire_speed=1;gun_power=60;clip=60;mclip=60;mammo=6000}
					if(2){src.gun='M4A1CarbineG.dmi';src.flick_state="ShootingMachineH";src.weapon_sound=SOUND_G3SG1_1;fire_speed=1;gun_power=60;clip=60;mclip=60;mammo=6000}
				src.overlays+=gun
				src.grenade=7
				src.ammo=(src.mammo-rand(20,40))
				..()
				spawn()src.NPC()
		GDI_Commando
			DblClick()
				var/mob/player/client/M=usr
				if(M.command&&M.class=="Commander"&&!M.alignment)
					if(src.owner==M)
						M.under_command-=src
						src.owner=null
						M<<"You stop commanding this GDI Soldier"
						return
					if(!(src in M.under_command)&&length(M.under_command)<M.commandmax&&!src.owner&&M.class=="Commander"&&!M.alignment)
						M.under_command+=src
						M<<"You can command this GDI Soldier"
						src.owner=M
			name="GDI Commando"
			icon='GDI Commando.dmi'
			icon_state="normal"
			health=20
			maxhealth=20
			see_in_dark=4
			New()
				switch(rand(1,2))
					if(1){src.gun='M4A1CarbineG.dmi';src.flick_state="ShootingMachineH";src.weapon_sound=SOUND_G3SG1_1;fire_speed=1;gun_power=60;clip=60;mclip=60;mammo=6000}
					if(2){src.gun='M4A1CarbineG.dmi';src.flick_state="ShootingMachineH";src.weapon_sound=SOUND_G3SG1_1;fire_speed=1;gun_power=60;clip=60;mclip=60;mammo=6000}
				src.overlays+=gun
				src.grenade=7
				src.ammo=(src.mammo-rand(20,40))
				..()
				spawn()src.NPC()
		GDI_Gold_Staff
			DblClick()
				var/mob/player/client/M=usr
				if(M.command&&M.class=="Commander"&&!M.alignment)
					if(src.owner==M)
						M.under_command-=src
						src.owner=null
						M<<"You stop commanding this GDI Soldier"
						return
					if(!(src in M.under_command)&&length(M.under_command)<M.commandmax&&!src.owner&&M.class=="Commander"&&!M.alignment)
						M.under_command+=src
						M<<"You can command this GDI Soldier"
						src.owner=M
			name="GDI Gold Staff"
			icon='GDI Gold Staff.dmi'
			icon_state="normal"
			health=20
			maxhealth=20
			see_in_dark=4
			New()
				switch(rand(1,2))
					if(1){src.gun='M4A1CarbineG.dmi';src.flick_state="ShootingMachineH";src.weapon_sound=SOUND_G3SG1_1;fire_speed=1;gun_power=60;clip=60;mclip=60;mammo=6000}
					if(2){src.gun='M4A1CarbineG.dmi';src.flick_state="ShootingMachineH";src.weapon_sound=SOUND_G3SG1_1;fire_speed=1;gun_power=60;clip=60;mclip=60;mammo=6000}
				src.overlays+=gun
				src.grenade=7
				src.ammo=(src.mammo-rand(20,40))
				..()
				spawn()src.NPC()
		GDI_Silver_Staff
			DblClick()
				var/mob/player/client/M=usr
				if(M.command&&M.class=="Commander"&&!M.alignment)
					if(src.owner==M)
						M.under_command-=src
						src.owner=null
						M<<"You stop commanding this GDI Soldier"
						return
					if(!(src in M.under_command)&&length(M.under_command)<M.commandmax&&!src.owner&&M.class=="Commander"&&!M.alignment)
						M.under_command+=src
						M<<"You can command this GDI Soldier"
						src.owner=M
			name="GDI Silver Staff"
			icon='GDI Silver Staff.dmi'
			icon_state="normal"
			health=20
			maxhealth=20
			see_in_dark=4
			New()
				switch(rand(1,2))
					if(1){src.gun='M4A1CarbineG.dmi';src.flick_state="ShootingMachineH";src.weapon_sound=SOUND_G3SG1_1;fire_speed=1;gun_power=60;clip=60;mclip=60;mammo=6000}
					if(2){src.gun='M4A1CarbineG.dmi';src.flick_state="ShootingMachineH";src.weapon_sound=SOUND_G3SG1_1;fire_speed=1;gun_power=60;clip=60;mclip=60;mammo=6000}
				src.overlays+=gun
				src.grenade=7
				src.ammo=(src.mammo-rand(20,40))
				..()
				spawn()src.NPC()
		Army_Mercernary_Female
			DblClick()
				var/mob/player/client/M=usr
				if(M.command&&M.class=="Commander"&&!M.alignment)
					if(src.owner==M)
						M.under_command-=src
						src.owner=null
						M<<"You stop commanding this Army Soldier"
						return
					if(!(src in M.under_command)&&length(M.under_command)<M.commandmax&&!src.owner&&M.class=="Commander"&&!M.alignment)
						M.under_command+=src
						M<<"You can command this Army Soldier"
						src.owner=M
			name="Army Mercernary Female"
			icon='Army Mercernary Female.dmi'
			icon_state="normal"
			health=20
			maxhealth=20
			see_in_dark=4
			New()
				switch(rand(1,2))
					if(1){src.gun='M16.dmi';src.flick_state="ShootingMachineH";src.weapon_sound=SOUND_G3SG1_1;fire_speed=1;gun_power=30;clip=31;mclip=31;mammo=6000}
					if(2){src.gun='M16.dmi';src.flick_state="ShootingMachineH";src.weapon_sound=SOUND_G3SG1_1;fire_speed=1;gun_power=30;clip=31;mclip=31;mammo=6000}
				src.overlays+=gun
				src.grenade=7
				src.ammo=(src.mammo-rand(20,40))
				..()
				spawn()src.NPC()
		Army_Mercernary
			DblClick()
				var/mob/player/client/M=usr
				if(M.command&&M.class=="Commander"&&!M.alignment)
					if(src.owner==M)
						M.under_command-=src
						src.owner=null
						M<<"You stop commanding this Army Soldier"
						return
					if(!(src in M.under_command)&&length(M.under_command)<M.commandmax&&!src.owner&&M.class=="Commander"&&!M.alignment)
						M.under_command+=src
						M<<"You can command this Army Soldier"
						src.owner=M
			name="Army Mercernary"
			icon='Army Mercernary.dmi'
			icon_state="normal"
			health=20
			maxhealth=20
			see_in_dark=4
			New()
				switch(rand(1,2))
					if(1){src.gun='M16.dmi';src.flick_state="ShootingMachineH";src.weapon_sound=SOUND_G3SG1_1;fire_speed=1;gun_power=30;clip=31;mclip=31;mammo=6000}
					if(2){src.gun='M16.dmi';src.flick_state="ShootingMachineH";src.weapon_sound=SOUND_G3SG1_1;fire_speed=1;gun_power=30;clip=31;mclip=31;mammo=6000}
				src.overlays+=gun
				src.grenade=7
				src.ammo=(src.mammo-rand(20,40))
				..()
				spawn()src.NPC()
		Army_Soldier
			DblClick()
				var/mob/player/client/M=usr
				if(M.command&&M.class=="Commander"&&!M.alignment)
					if(src.owner==M)
						M.under_command-=src
						src.owner=null
						M<<"You stop commanding this Army Soldier"
						return
					if(!(src in M.under_command)&&length(M.under_command)<M.commandmax&&!src.owner&&M.class=="Commander"&&!M.alignment)
						M.under_command+=src
						M<<"You can command this Army Soldier"
						src.owner=M
			name="Army Soldier"
			icon='Army Soldier.dmi'
			icon_state="normal"
			health=20
			maxhealth=20
			see_in_dark=4
			New()
				switch(rand(1,2))
					if(1){src.gun='M16.dmi';src.flick_state="ShootingMachineH";src.weapon_sound=SOUND_G3SG1_1;fire_speed=1;gun_power=30;clip=31;mclip=31;mammo=6000}
					if(2){src.gun='M16.dmi';src.flick_state="ShootingMachineH";src.weapon_sound=SOUND_G3SG1_1;fire_speed=1;gun_power=30;clip=31;mclip=31;mammo=6000}
				src.overlays+=gun
				src.grenade=7
				src.ammo=(src.mammo-rand(20,40))
				..()
				spawn()src.NPC()
		Army_Winter_Soldier
			DblClick()
				var/mob/player/client/M=usr
				if(M.command&&M.class=="Commander"&&!M.alignment)
					if(src.owner==M)
						M.under_command-=src
						src.owner=null
						M<<"You stop commanding this Army Soldier"
						return
					if(!(src in M.under_command)&&length(M.under_command)<M.commandmax&&!src.owner&&M.class=="Commander"&&!M.alignment)
						M.under_command+=src
						M<<"You can command this Army Soldier"
						src.owner=M
			name="Army Winter Soldier"
			icon='Army Winter Soldier.dmi'
			icon_state="normal"
			health=20
			maxhealth=20
			see_in_dark=4
			New()
				switch(rand(1,2))
					if(1){src.gun='M16.dmi';src.flick_state="ShootingMachineH";src.weapon_sound=SOUND_G3SG1_1;fire_speed=1;gun_power=30;clip=31;mclip=31;mammo=6000}
					if(2){src.gun='M16.dmi';src.flick_state="ShootingMachineH";src.weapon_sound=SOUND_G3SG1_1;fire_speed=1;gun_power=30;clip=31;mclip=31;mammo=6000}
				src.overlays+=gun
				src.grenade=7
				src.ammo=(src.mammo-rand(20,40))
				..()
				spawn()src.NPC()
		NPC()
			if(GameOver)return
			if(prob(10)&&src.chance>0)
				src.chance--
			var/lineseg/line = locate()in view(src,9)
			if(line)
				src.chance++
				if(!src.stuck&&prob(src.chance))
					src.cut_here(line.loc,line)
					while((get_dist(src,line))>1&&line&&!src.stuck)
						sleep(1)
					if((get_dist(src,line))<=1)
						new/obj/effects/slash(get_step(src,src.dir),src.dir)
						oview(7,src)<<sound(SOUND_SLASH,0,0,0,volume=(60-master_vol))
						if(istype(line.parentLine.owner,/mob/Monster/Licker)||(istype(line.parentLine.owner,/mob/player/client)&&line.parentLine.owner:islicker))
							line.parentLine.owner:licking=0
							line.parentLine.reftarg:stuck=0
							line.parentLine.reftarg.overlays-=/obj/playerlays/wrap
							del(line.parentLine)
						else if(istype(line.parentLine.owner,/mob/Monster/Spider)||(istype(line.parentLine.owner,/mob/player/client)&&line.parentLine.owner:isspider))
							line.parentLine.owner:linehealth--
							if(line.parentLine.owner:linehealth<=0)
								line.parentLine.owner:webbing=0
								line.parentLine.reftarg:stuck=0
								line.parentLine.reftarg.overlays-=/obj/playerlays/wrap3
								line.parentLine.owner:linehealth=5
								del(line.parentLine)
						else if(istype(line.parentLine.owner,/mob/Monster/Boss/Tyrant)||istype(line.parentLine.owner,/mob/Monster/Boss/Tyrant_T700)||(istype(line.parentLine.owner,/mob/player/client)&&(line.parentLine.owner:istyrant||line.parentLine.owner:istyrant2)))
							line.parentLine.owner:licks--
							line.parentLine.reftarg:stuck=0
							line.parentLine.owner:moblist-=line.parentLine.reftarg
							line.parentLine.reftarg.overlays-=/obj/playerlays/wrap2
							if(line.parentLine.owner:licks<=0)
								line.parentLine.owner:wrapping=0
								line.parentLine.owner:moblist=new
							del(line.parentLine)
					else
						spawn(5)src.NPC()
						return
			if(!src.target)
				for(var/mob/Z in oview(6,src))
					if(!Z.alignment||Z.isdead)continue
					src.target=Z
				spawn(5)src.NPC()
				return
			else if(!(src.target in oview(src)))
				for(var/mob/Z in oview(6,src))
					if(!Z.alignment||Z.isdead)continue
					src.target=Z
				spawn(5)src.NPC()
				return
			else
				var/targetdist=get_dist(src.target,src)
				if(src.stuck)
					spawn(5)src.NPC()
					return
				if(targetdist>7)
					src.target=null
					spawn(5)src.NPC()
					return
				if(targetdist>=2&&!td&&prob(2)&&!src.throwed&&src.grenade)
					src.throwed=1
					spawn(40)src.throwed=0
					var/turf/T=get_step(src,get_dir(src,src.target))
					if(T&&T.density){spawn(5)src.NPC();return}
					if(!src.target){spawn(5)src.NPC();return}
					var/turf/gtarget=src.target.loc
					src.grenade--
					var/obj/effects/Grenade/X = new(src.loc,src.dir,null,null)
					src.dir=get_dir(src,src.target)
					spawn()steploop(X,gtarget,2)
					spawn((targetdist*2))if(X)X.density=0
					spawn((targetdist*4))
						if(prob(30))range(7,src)<<sound(SOUND_BLOW,volume=(100-master_vol))
						if(X&&src.owner)X.BlowUp(2,675,src.owner)
						else if(X)X.BlowUp(2,675)
					spawn(5)src.NPC()
					return
				else if(targetdist<2)
					src.dir=get_dir(src,src.target)
					new/obj/effects/slash(get_step(src,src.dir),src.dir)
					oview(7,src)<<sound(SOUND_SLASH,0,0,0,volume=(60-master_vol))
					src.target.health-=rand(20,28)
					if(src.target.health<=0)death_zombie(null,src.target)
					if(src.health<(src.maxhealth/3))step_away(src,src.target)
					spawn(5)src.NPC()
					return
				else if(targetdist<=7)
					if(src.clip>0)
						if(targetdist<=3&&src.health<(src.maxhealth/2))
							if(!src.need_backup)
								src.need_backup = 1
								range(7,src)<<sound(SOUND_INEEDBACKUP,volume=(rand(60,80)-master_vol))
							step_away(src,src.target)
							sleep(4)
						src.clip--
						src.dir=get_dir(src,src.target)
						orange(7,src)<<sound(src.weapon_sound,0,0,0,volume=(src.weapon_volume-master_vol))
						flick(src.flick_state,src)
						switch(src.fire_type)
							if(1)
								var/chancehit=100
								chancehit-=(10*targetdist)
								chancehit-=rand(1,8)
								if(prob(chancehit))
									var/damage=src.gun_power
									if(prob(BLOODDROPRATE) && length(src.target.loc.overlays) < MAX_BLOOD)src.target.loc.overlays += new/obj/blood_effects/blood
									src.target.health-=damage
									if(src.target.health<=0)
										if(prob(10))range(7,src)<<sound(SOUND_ENEMYDOWN,volume=(100-master_vol))
										if(src.owner)
											src.owner.kills++
											death_zombie(src.owner.team,src.target)
										else
											death_zombie(null,src.target)
								var/time=src.fire_speed
								if(prob(30))time++
								spawn(time)src.NPC()
								return
							if(2)
								var/obj/projectiles/O = new src.projectile
								O.owner = null
								if(src.owner)
									O.owner = src.owner
								O.density = 1
								O.loc = src.loc
								O.dir = src.dir
								spawn()O.projectile_loop_2(src.target)
								spawn(src.fire_speed)src.NPC()
								return
							if(3)
								var/dir_2=turn(src.dir,-45)
								var/dir_3=turn(src.dir,45)
								var/count=rand(2,3)
								var/damage=src.gun_power
								for(var/mob/Z in oview(7,src))
									if(!Z.alignment)continue
									else if(!count)break
									if(get_dir(src,Z)==src.dir||get_dir(src,Z)==dir_2||get_dir(src,Z)==dir_3)
										if(get_dist(src,Z)<=1)
											Z.health-=(damage*2.5)
										else if(get_dist(src,Z)<=2)
											Z.health-=damage*1.5
										else if(get_dist(src,Z)<=3)
											Z.health-=damage
										else if(get_dist(src,Z)<=4)
											Z.health-=(damage/4)
										else
											Z.health-=(damage/5)
										if(prob(BLOODDROPRATE) && length(Z.loc.overlays) < MAX_BLOOD)Z.loc.overlays += new/obj/blood_effects/blood
										if(Z.health<=0)
											if(src.owner)
												src.owner.kills++
												death_zombie(src.owner.team,Z)
											else
												death_zombie(null,src.target)
											if(prob(10))range(7,src)<<sound(SOUND_ENEMYDOWN,volume=(100-master_vol))
										count--
								var/time=src.fire_speed
								if(prob(30))time++
								spawn(time)src.NPC()
								return
					else if(src.ammo<0)
						spawn(src.fire_speed)src.NPC()
						return
					else
						if(prob(20))range(7,src)<<sound(SOUND_COVERME,volume=(100-master_vol))
						sleep(rand(20,40))
						var/takeammo=src.mclip
						if(takeammo>src.ammo)takeammo=src.ammo
						src.ammo-=takeammo
						src.clip+=takeammo
						view(7,src)<<sound(SOUND_BOLT_REL,0,volume=(80-master_vol))
						spawn(5)src.NPC()
						return
				else
					spawn(5)src.NPC()
					return

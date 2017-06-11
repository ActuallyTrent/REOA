
obj
	proc/Trigger()
	Zombie_Spawn
		mouse_opacity=0
		icon='B_Obj.dmi'
		icon_state="corpse"
		New()
			src.dir=pick(NORTH,EAST,WEST,SOUTH)
			spawn_zone+=src.loc
			..()
			spawn(10)if(!src.icon_state)del(src)
	effects
		Grenade
			icon='Other.dmi'
			icon_state="grenade"
			density=1
			New(loc,dir,th,mob/p)
				src.dir=dir
				src.loc=loc
				..()
				if(th)spawn()src.Toss(p)
			proc/Toss(var/mob/p)
				walk(src,src.dir,2)
				sleep(10)
				src.density=0
				walk(src,0,0)
				sleep(5)
				src.BlowUp(2,675,p)
			Bump(atom/A)
				if(!A)return ..()
				if(istype(A,/mob))
					var/mob/player/p=A
					if(p.alignment)
						src.density=0
						walk(src,0,0)
					else src.loc=p.loc
				else if(istype(A,/obj/Attackable/Destructable_Obj))
					var/obj/O=A
					src.loc=O.loc
				else if(istype(A,/obj/Attackable/Pushable_Obj))
					var/obj/O=A
					src.loc=O.loc
				else if(istype(A,/obj/effects/Hazards))
					src.loc=A.loc
				else {src.density=0;walk(src,0,0)}
				..()
		Molotov
			icon='Other.dmi'
			icon_state="molotov"
			density=1
			New(loc,dir,th,mob/p)
				src.dir=dir
				src.loc=loc
				..()
				if(th)spawn()src.Toss(p)
			proc/Toss(var/mob/p)
				walk(src,src.dir,2)
				sleep(10)
				src.density=0
				walk(src,0,0)
				sleep(5)
				src.CreateFire(p,2,1)
				range(src)<<sound('Audio/Sound/burn.wav',0,volume=(80-master_vol))
				del(src)
			Bump(atom/A)
				if(!A)return ..()
				if(istype(A,/mob))
					var/mob/player/p=A
					if(p.alignment)
						src.density=0
						walk(src,0,0)
					else src.loc=p.loc
				else if(istype(A,/obj/Attackable/Destructable_Obj))
					var/obj/O=A
					src.loc=O.loc
				else if(istype(A,/obj/Attackable/Pushable_Obj))
					var/obj/O=A
					src.loc=O.loc
				else if(istype(A,/obj/effects/Hazards))
					src.loc=A.loc
				else {src.density=0;walk(src,0,0)}
				..()
		LaserLead
			var
				obj/Pickup/Items/TripWire/owner
			proc/Run()
				if(!src||!src.owner)return
				while(!GameOver&&src.owner)
					var/obj/effects/Laser_Wire/L = new /obj/effects/Laser_Wire(src.loc)
					src.owner.lparts+=L
					L.owner=src.owner
					L.dir=src.dir
					if(src.x<=1||src.x>=world.maxx||src.y<=1||src.y>=world.maxy){src.owner.isSet=1;break}
					step(src,src.dir)
					sleep(1)
				del(src)
			density=1
			Bump(atom/a)
				..()
				if(ismob(a))
					src.loc = a.loc
				else
					src.owner.isSet=1
					del(src)
		Laser_Wire
			var
				obj/Pickup/Items/TripWire/owner
			icon='effects.dmi'
			icon_state="laser"
			mouse_opacity=0
			New()
				..()
			Trigger(var/mob/M)
				if(src.owner && src.owner.owner != M)
					if(src.owner.isSet)
						src.owner.Trigger()
		Target
			icon='target.dmi'
			mouse_opacity=0
			icon_state="tar_green"
			layer=5
		Bit
			icon='effects.dmi'
			mouse_opacity=0
			New()
				..()
				flick("bit",src)
				spawn(10)del(src)
		Hazards
			var/mob/player/client/owner
			Flame
				layer=OBJ_LAYER-0.01
				icon='effects.dmi'
				icon_state="flame"
				mouse_opacity=0
				luminosity=1
				New()
					..()
					spawn(rand(300,600)){new/obj/effects/Hazards/S_Flame(src.loc);del(src)}
					spawn()src.fireloop(src.owner,1)
			S_Flame
				layer=OBJ_LAYER-0.02
				icon='effects.dmi'
				icon_state="s-flame"
				mouse_opacity=0
				luminosity=1
				New()
					var/x=rand(1,10)
					var/y=rand(1,9)
					var/i=rand(1,4)
					switch(i)
						if(1){src.pixel_x-=x;src.pixel_y+=y}
						if(2){src.pixel_x+=x;src.pixel_y+=y}
						if(3){src.pixel_x-=x;src.pixel_y-=y}
						if(4){src.pixel_x+=x;src.pixel_y-=y}
					..()
					spawn(rand(100,300))del(src)
					spawn()src.fireloop(src.owner)
			oil
				var/owner_dead=0
				icon='Other.dmi'
				icon_state="oils"
				name="Oil"
				New()
					..()
					var/obj/Zombie_Spawn/A = locate()in view(src,3)
					if(A)
						del(src)
			proc/fireloop(var/mob/player/owner,var/i=0)
				while(src)
					for(var/mob/Monster/M in view(src,0))
						if(M&&!M.isdead)
							if(i)
								if(!M.on_fire)
									spawn()
										if(M)
											M.on_fire(10, 100,owner)
							else
								if(!M.on_fire)
									spawn()
										if(M)
											M.on_fire(10, 100,owner)
					for(var/obj/effects/Hazards/oil/M in view(src,1))
						if(M)
							if(src.owner==M.owner||M.owner_dead)
								M.CreateFire(M.owner,1,1)
								range(M)<<sound('Audio/Sound/burn.wav',0,volume=(80-master_vol))
								del(M)
								sleep(20)
					for(var/obj/Pickup/Items/gastanker/M in view(src,1))
						if(M)
							if(prob(1))
								M.CreateFire(owner,1,1)
								range(M)<<sound('Audio/Sound/burn.wav',0,volume=(80-master_vol))
								del(M)
								sleep(20)
					sleep(10)
		spurt_acid
			icon = 'spatters.dmi'
			New(loc,dirs)
				spawn()
					src.dir = dirs
					src.loc = get_step(loc,dir)
					flick("spray2",src)
					sleep(6)
					del(src)
		spray_freeze
			icon = 'spatters.dmi'
			New(loc,dirs)
				spawn()
					src.dir = dirs
					src.loc = get_step(loc,dir)
					flick("spray3",src)
					sleep(6)
					del(src)
	blood_effects
		corpse
			mouse_opacity=0
			New(turf/loc,icon/I)
				..()
				src.loc=loc
				src.dir=pick(NORTH,EAST,WEST,SOUTH)
				src.icon=I
				src.icon_state="corpse"
				spawn(rand(240,360))del(src)
		chunks
			mouse_opacity=0
			icon='chunks.dmi'
			New(loc)
				..()
				spawn()
					src.icon_state = "c([rand(1,5)])"
					src.dir = pick(list(EAST,NORTH,SOUTH,WEST,NORTHWEST,NORTHEAST,SOUTHEAST,SOUTHWEST))
					var/count = rand(2,4)
					while(count--)
						var/turf/T = get_step(src,src.dir)
						if(!T||T.density)break
						step_towards(src,T)
						sleep(1)
					spawn(rand(300,400))del(src)
		blood
			icon = 'blooded.dmi'
			layer = TURF_LAYER+1
			New()
				src.pixel_x=rand(-4,4)
				src.pixel_y=rand(-4,4)
				src.icon_state = pick("ul","u","ur","l","c","r","dl","d","dr")
				..()
				spawn()
					spawn(rand(120,200)) del(src)
	/*	splatter
			icon = 'spatters.dmi'
			layer = 4
			New()
				src.pixel_x=rand(-3,3)
				src.pixel_y=rand(-3,3)
				..()
				spawn()
					flick("splat",src)
					sleep(4)
					del(src)*/
	projectiles
		var
			mob/player/client/owner = null
			isblow = 0
			speed = 0
			atom/target = null
			blowmax=0
		density = 1
		Laser
			density=0
			icon='effects.dmi'
			icon_state="laser2"
			var/list/parts=list()
			var/obj/projectiles/Laser/ownerpart = null
			luminosity=3
			proc/Run()
				if(!src||!src.owner)return
				src.owner.stuck=1
				src.owner.icon_state="ShootingMachineL"
				while(!GameOver&&src.owner.gamein)
					var/obj/projectiles/Laser/L = new /obj/projectiles/Laser(src.loc)
					src.parts+=L
					L.owner=src.owner
					L.ownerpart=src
					L.dir=src.dir
					if(!src.owner.gamein||src.x<=1||src.x>=world.maxx||src.y<=1||src.y>=world.maxy||src.isblow>=src.blowmax)break
					step(src,src.dir)
					sleep(1)
				for(var/a in src.parts)
					del(a)
				src.owner.icon_state="normal"
				src.owner.stuck=0
				del(src)
			New()
				..()
				spawn()
					while(src)
						for(var/atom/A in view(src,0))
							if(A.density&&!(istype(A,/mob))&&!(istype(A,/obj/Attackable/Pushable_Obj))&&!(istype(A,/obj/Attackable/Destructable_Obj)))
								if(src.ownerpart)
									src.ownerpart.isblow=src.ownerpart.blowmax
								else
									src.isblow=src.blowmax
						for(var/mob/player/client/M in view(src,0))
							if(!M.gamein&&!M.isdead&&M.alignment)
								M.health-=rand(50,100)
								if(M.health<=0)
									spawn()death_zombie(src.owner.team,M,MAX_BLOOD)
									src.owner.kills++
									if(src.ownerpart)
										src.ownerpart.isblow++
									else
										src.isblow++
						for(var/mob/Monster/M in view(src,0))
							M.health-=rand(50,100)
							if(M.health<=0)
								spawn()death_zombie(src.owner.team,M,MAX_BLOOD)
								src.owner.kills++
								if(src.ownerpart)
									src.ownerpart.isblow++
								else
									src.isblow++
						sleep(1)
		fire
			density=0
			icon='fthrower.dmi'
			icon_state="head"
			var/list/parts=list()
			var/obj/projectiles/fire/ownerpart = null
			luminosity=3
			layer = MOB_LAYER+0.2
			proc/Run()
				if(!src||!src.owner)return
				src.owner.icon_state="ShootingShotgun"
				while(!GameOver&&src.owner.gamein)
					var/obj/projectiles/fire/L = new(src.loc)
					src.parts+=L
					for(var/atom/a in src.parts)
						a.icon_state="body"
					L.owner=src.owner
					L.ownerpart = src
					L.dir=src.dir
					src.icon_state="body"
					var/obj/effects/Hazards/Flame/A = locate()in L.loc
					if(!A)
						var/obj/effects/Hazards/Flame/F = new(L.loc)
						F.owner=src.owner
					L.icon_state="head"
					if(!src.owner.gamein||src.x<=1||src.x>=world.maxx||src.y<=1||src.y>=world.maxy||src.isblow>=src.blowmax)break
					src.isblow++
					step(src,src.dir)
					sleep(1)
				for(var/a in src.parts)
					del(a)
				src.owner.icon_state="normal"
				del(src)
			New()
				..()
				spawn()
					while(src)
						for(var/atom/A in view(src,0))
							if(A.density&&!(istype(A,/mob))&&!(istype(A,/obj/Attackable/Pushable_Obj))&&!(istype(A,/obj/Attackable/Destructable_Obj)))
								if(src.ownerpart)
									src.ownerpart.isblow=src.ownerpart.blowmax
								else
									src.isblow=src.blowmax
						for(var/mob/player/client/M in view(src,0))
							if(!M.gamein&&!M.isdead&&M.alignment)
								M.health-=rand(20,50)
								if(M.health<=0)
									spawn()death_zombie(src.owner.team,M,MAX_BLOOD)
									src.owner.kills++
								if(M&&!M.isdead)
									if(!M.on_fire)
										spawn()
											if(M)
												M.on_fire(10, 100,owner)
						for(var/mob/Monster/M in view(src,0))
							M.health-=rand(20,50)
							if(M.health<=0)
								spawn()death_zombie(src.owner.team,M,MAX_BLOOD)
								src.owner.kills++
							if(M&&!M.isdead)
								if(!M.on_fire)
									spawn()
										if(M)
											M.on_fire(10, 100,owner)
						for(var/obj/effects/Hazards/oil/M in view(src,1))
							if(M)
								if(src.owner==M.owner||M.owner_dead)
									M.CreateFire(M.owner,1,1)
									range(M)<<sound('Audio/Sound/burn.wav',0,volume=(80-master_vol))
									del(M)
									sleep(20)
						for(var/obj/Pickup/Items/gastanker/M in view(src,1))
							if(M)
								if(prob(1))
									M.CreateFire(owner,1,1)
									range(M)<<sound('Audio/Sound/burn.wav',0,volume=(80-master_vol))
									del(M)
									sleep(20)
						sleep(1)
		player_rocket
			icon='projectiles.dmi'
			icon_state="rocket"
			speed = 2
			Bump(atom/A)
				..()
				var/blow = 0
				if(istype(A,/mob/player))
					var/mob/player/p=A
					if(p.gamein)blow = 1
					else src.loc=p.loc
				else if(istype(A,/mob/Monster))
					src.loc=A.loc
				else if(istype(A,/obj/Attackable/Destructable_Obj))
					var/obj/O=A
					src.loc=O.loc
				else if(istype(A,/obj/Attackable/Pushable_Obj))
					var/obj/O=A
					src.loc=O.loc
				else blow = 1
				if(blow && !src.isblow)
					src.isblow = 1
					src.density = 0
					src.BlowUp(2,10,src.owner,1)
		rocket
			icon='projectiles.dmi'
			icon_state="rocket"
			speed = 1
			Bump(atom/A)
				..()
				var/blow = 0
				if(istype(A,/mob/player))
					var/mob/player/p=A
					if(!p.gamein)blow = 1
					else src.loc=p.loc
				else if(istype(A,/obj/Attackable/Destructable_Obj))
					var/obj/O=A
					src.loc=O.loc
				else if(istype(A,/obj/Attackable/Pushable_Obj))
					var/obj/O=A
					src.loc=O.loc
				else blow = 1
				if(blow && !src.isblow)
					src.isblow = 1
					src.density = 0
					src.BlowUp(3,2000,src.owner)
		flame
			icon='projectiles.dmi'
			icon_state="flame"
			speed = 1
			Bump(atom/A)
				..()
				var/blow = 0
				if(istype(A,/mob/player))
					var/mob/player/p=A
					if(!p.gamein)blow = 1
					else src.loc=p.loc
				else if(istype(A,/obj/Attackable/Destructable_Obj))
					var/obj/O=A
					src.loc=O.loc
				else if(istype(A,/obj/Attackable/Pushable_Obj))
					var/obj/O=A
					src.loc=O.loc
				else blow = 1
				if(blow && !src.isblow)
					src.isblow = 1
					src.density = 0
					src.icon_state=null
					var/team
					if(src.owner.team)
						team = src.owner.team
					flick("explosive-e",src)
					src.CreateFire(src.owner)
					if(istype(A,/mob))
						var/mob/M = A
						if(M.alignment)
							var/dmg = (500-M.resistance["fire"])
							if(dmg<0)dmg=0
							M.health-=dmg
							if(M.health<=0)
								if(src.owner)src.owner.kills++
								var/obj/effects/Hazards/Flame/F = new(M.loc)
								F.owner=src.owner
								death_zombie(team,M)
							else spawn()A.on_fire(4, 40,src.owner)
					if(istype(A,/obj/Attackable/Windows))
						A.Death()
					sleep(12)
					del(src)
		freeze
			icon='projectiles.dmi'
			icon_state="freeze"
			speed = 1
			Bump(atom/A)
				..()
				var/blow = 0
				if(istype(A,/mob/player))
					var/mob/player/p=A
					if(!p.gamein)blow = 1
					else src.loc=p.loc
				else if(istype(A,/obj/Attackable/Destructable_Obj))
					var/obj/O=A
					src.loc=O.loc
				else if(istype(A,/obj/Attackable/Pushable_Obj))
					var/obj/O=A
					src.loc=O.loc
				else blow = 1
				if(blow && !src.isblow)
					src.isblow = 1
					src.density = 0
					src.icon_state = null
					flick("freeze-e",src)
					var/dir2 = turn(src.dir,45)
					var/dir3 = turn(src.dir,-45)
					new/obj/effects/spray_freeze(src.loc,src.dir)
					new/obj/effects/spray_freeze(src.loc,dir2)
					new/obj/effects/spray_freeze(src.loc,dir3)
					for(var/atom/movable/N in oview(1,src))
						if(!N||!N.density)continue
						if(get_dir(src,N) == src.dir||get_dir(src,N) == dir2||get_dir(src,N) == dir3)
							if(istype(N,/mob))
								var/mob/M = N
								if(M.alignment&&!M.isdead)
									M.is_frozen(160)
					sleep(12)
					del(src)
		acid
			icon='projectiles.dmi'
			icon_state="acid"
			speed = 1
			Bump(atom/A)
				..()
				var/blow = 0
				if(istype(A,/mob/player))
					var/mob/player/p=A
					if(!p.gamein)blow = 1
					else src.loc=p.loc
				else if(istype(A,/obj/Attackable/Destructable_Obj))
					var/obj/O=A
					src.loc=O.loc
				else if(istype(A,/obj/Attackable/Pushable_Obj))
					var/obj/O=A
					src.loc=O.loc
				else blow = 1
				if(blow && !src.isblow)
					src.isblow = 1
					src.density = 0
					src.icon_state=null
					var/team
					if(src.owner.team)
						team = src.owner.team
					flick("acid-e",src)
					var/dir2 = turn(src.dir,45)
					var/dir3 = turn(src.dir,-45)
					new/obj/effects/spurt_acid(src.loc,src.dir)
					new/obj/effects/spurt_acid(src.loc,dir2)
					new/obj/effects/spurt_acid(src.loc,dir3)
					for(var/atom/movable/N in oview(1,src))
						if(!N||!N.density)continue
						if(get_dir(src,N) == src.dir||get_dir(src,N) == dir2||get_dir(src,N) == dir3)
							if(istype(N,/mob))
								var/mob/M = N
								if(M.alignment&&!M.isdead)
									var/dmg = (500-M.resistance["acid"])
									if(dmg<0)dmg=0
									M.health-=dmg
									if(M.health<=0)
										if(src.owner)src.owner.kills++
										death_zombie(team,M)
							if(istype(N,/obj/Attackable/Windows))
								N.Death()
					sleep(12)
					del(src)
		explosive
			icon='projectiles.dmi'
			icon_state="explosive"
			speed = 1
			Bump(atom/A)
				..()
				var/blow = 0
				if(istype(A,/mob/player))
					var/mob/player/p=A
					if(!p.gamein)blow = 1
					else src.loc=p.loc
				else if(istype(A,/obj/Attackable/Destructable_Obj))
					var/obj/O=A
					src.loc=O.loc
				else if(istype(A,/obj/Attackable/Pushable_Obj))
					var/obj/O=A
					src.loc=O.loc
				else blow = 1
				if(blow && !src.isblow)
					src.isblow = 1
					src.density = 0
					src.BlowUp(2,675,src.owner)
		New(loc)
			..()
		proc/projectile_loop()
			while(!src.isblow)
				if(src.x<=1||src.x>=world.maxx||src.y<=1||src.y>=world.maxy)del(src)
				else {step(src,src.dir);sleep(src.speed)}
		proc/projectile_loop_2(var/targ)
			while(!src.isblow)
				if(!targ)
					src.isblow=1
					src.density = 0
					src.BlowUp(2,675,src.owner)
				if(src.x<=1||src.x>=world.maxx||src.y<=1||src.y>=world.maxy)del(src)
				else {step(src,(get_dir(src,targ)));sleep(src.speed)}
	obj_spawners
		item
			New()
				..()
				var/spawn_num = rand(1,2)
				while(spawn_num--)
					var/rand_chance = rand(1,150)
					switch(rand_chance)
						if(1 to 30)
							for(var/i=1,i<=4,i++)
								new/obj/Pickup/Items/Ammo_Light_Handgun(src.loc)
						if(31 to 38)
							for(var/i=1,i<=4,i++)
								new/obj/Pickup/Items/Ammo_Heavy_Handgun(src.loc)
						if(39 to 58)
							for(var/i=1,i<=3,i++)
								new/obj/Pickup/Items/Ammo_Shotgun(src.loc)
						if(59 to 76)
							for(var/i=1,i<=4,i++)
								new/obj/Pickup/Items/Ammo_Light_Machinegun(src.loc)
						if(77 to 92)
							for(var/i=1,i<=4,i++)
								new/obj/Pickup/Items/Ammo_Heavy_Machinegun(src.loc)
						if(93 to 99)
							for(var/i=1,i<=2,i++)
								new/obj/Pickup/Items/Ammo_Sniper(src.loc)
						if(100 to 104)
							for(var/i=1,i<=2,i++)
								new/obj/Pickup/Items/Ammo_Sniper2(src.loc)
						if(105 to 110)
							for(var/i=1,i<=2,i++)
								new/obj/Pickup/Items/Ammo_Flame(src.loc)
						if(111 to 106)
							for(var/i=1,i<=2,i++)
								new/obj/Pickup/Items/Ammo_Acid(src.loc)
						if(107 to 122)
							for(var/i=1,i<=2,i++)
								new/obj/Pickup/Items/Ammo_Freeze(src.loc)
						if(123 to 127)
							for(var/i=1,i<=2,i++)
								new/obj/Pickup/Items/Ammo_Explosive(src.loc)
						if(128 to 131)
							for(var/i=1,i<=2,i++)
								new/obj/Pickup/Items/Spray(src.loc)
						if(132 to 136)
							for(var/i=1,i<=4,i++)
								new/obj/Pickup/Items/C4(src.loc)
						if(137 to 140)
							for(var/i=1,i<=4,i++)
								new/obj/Pushable_tmp/Barricade2(src.loc)
						if(141 to 143)
							for(var/i=1,i<=4,i++)
								new/obj/Pickup/Items/Hammer(src.loc)
						if(144)
							new/obj/Pickup/Items/Turret(src.loc)
						if(145 to 150)
							for(var/i=1,i<=2,i++)
								new/obj/Pickup/Items/gastanker(src.loc)
		weapon
			New()
				..()
				var/rand_chance = rand(1,64)
				switch(rand_chance)
					if(1 to 23)
						for(var/i=1,i<=2,i++)
							new/obj/Pickup/Guns/M92F_Custom_Handgun(src.loc)
					if(24 to 34)
						for(var/i=1,i<=2,i++)
							new/obj/Pickup/Guns/Sawnoff(src.loc)
					if(35 to 45)
						switch(rand(1,2))
							if(1)
								for(var/i=1,i<=3,i++)
									new/obj/Pickup/Guns/MAC11_SubMachine_Gun(src.loc)
							if(2)
								for(var/i=1,i<=3,i++)
									new/obj/Pickup/Guns/Uzi(src.loc)
					if(46 to 60)
						for(var/i=1,i<=2,i++)
							new/obj/Pickup/Guns/AK_47(src.loc)
					if(61 to 64)
						for(var/i=1,i<=2,i++)
							new/obj/Pickup/Guns/MosinNagant(src.loc)

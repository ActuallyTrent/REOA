mob/player/client/verb
	fire()
		set hidden=1
		if(GameOver||src.fired||!src.density)return
		if(src.alignment)
			if(src.frozen)return
			src.fired=1
			spawn(6)src.fired=0
			range(4,src)<<sound(SOUND_ZATTACK,volume=(60-master_vol))
			flick("[src.icon_state]_attack",src)
			var/turf/T = get_step(src,src.dir)
			if(!T)return
			if(src.isBoss && T.density)
				T.health-=rand(3,6)
				if(T.health<=0)T.Death()
				return
			for(var/atom/movable/A in T)
				if(!A||!A.density)continue
				if(istype(A,/obj/Attackable))
					if(A.density)
						var/obj/Attackable/B = A
						if(src.isBoss)
							B.Bumped(rand(2,5))
						else
							B.Bumped(rand(1,2))
				else if(istype(A,/obj/Vehicle))
					var/obj/Vehicle/V=A
					if(A.density&&prob(80))
						V.main.health-=rand(0,4)
						if(V.main.health<=0){V.main.Death()}
						return
				else if(istype(A,/mob/player))
					var/mob/player/p=A
					if(!p.gamein)continue
					if(p.client)spawn()p.infection()
					p.health-=rand(1,2)
					if(p.health<=0)p.Death()
					return
		else if(src.manning)
			if(!src.gamein||src.fired||src.stuck)return
			var/SPECZM=src.turret.firetype
			var/mob/c_target=null
			var/flickinge = src.turret.flick_state
			if(src.turret.varheat>=src.turret.varheatmax){src<<"Your turret is overheated";return}
			switch(SPECZM)
				if(1)
					range(7,src)<<sound(src.turret.weapon_sound,0,volume=(rand(30,50)))
					for(var/mob/M in oview(src))
						if(!M.alignment)continue
						c_target=M
						break
					if(c_target)
						if(prob(BLOODDROPRATE) && length(c_target.loc.overlays) < MAX_BLOOD)c_target.loc.overlays += new/obj/blood_effects/blood
						var/num=round(rand(src.turret.firepower*0.4,src.turret.firepower*2.5))
						c_target.health-=num
						nums(c_target,num,"lightgreen")
						if(c_target.health<=0)
							src.kills++
							death_zombie(src.team,c_target)
					flick(flickinge,src.turret)
					if(src.class=="Engineer")
						src.turret.varheat+=rand(1,3)
					else
						src.turret.varheat+=rand(1,7)
				if(2)
					var/obj/projectiles/O = new src.turret.projectile
					O.owner = src
					O.density = 1
					O.loc = src.loc
					O.dir = src.dir
					spawn()O.projectile_loop()
					flick(flickinge,src.turret)
				if(3)
					range(7,src)<<sound(src.turret.weapon_sound,0,volume=(rand(30,50)))
					flick(flickinge,src.turret)
					var/count=rand(2,3)
					src.turret.varheat+=rand(5,10)
					for(var/mob/M in oview(src))
						if(!M.alignment)continue
						c_target=M
						break
					src.dir = get_dir(src,c_target)
					src.turret.dir = get_dir(src.turret,c_target)
					var/dir_2=turn(src.dir,-45)
					var/dir_3=turn(src.dir,45)
					for(var/mob/Z in oview(7,src))
						if(!Z.alignment)continue
						else if(!count)break
						if(get_dir(src,Z)==src.dir||get_dir(src,Z)==dir_2||get_dir(src,Z)==dir_3)
							if(get_dist(src,Z)<=1)
								Z.health-=(src.turret.firepower*2.5)
								nums(Z,src.turret.firepower*2.5,"lightgreen")
							else if(get_dist(src,Z)<=2)
								Z.health-=src.turret.firepower*1.5
								nums(Z,src.turret.firepower,"lightgreen")
							else if(get_dist(src,Z)<=3)
								Z.health-=src.turret.firepower
								nums(Z,src.turret.firepower,"lightgreen")
							else if(get_dist(src,Z)<=4)
								Z.health-=(src.turret.firepower/4)
								nums(Z,src.turret.firepower/4,"lightgreen")
							else
								Z.health-=(src.turret.firepower/5)
								nums(Z,src.turret.firepower/5,"lightgreen")
							if(prob(BLOODDROPRATE) && length(Z.loc.overlays) < MAX_BLOOD)Z.loc.overlays += new/obj/blood_effects/blood
							if(Z.health<=0)
								src.kills++
								death_zombie(src.team,Z)
							count--
				if(4)
					if(src.turret.aimfire)
						for(var/mob/M in oview(src))
							if(!M.alignment)continue
							c_target=M
							break
						src.dir = get_dir(src,c_target)
						src.turret.dir = get_dir(src.turret,c_target)
					src.turret.varheat+=rand(1,3)
					var/obj/projectiles/Laser/O = new src.turret.laser
					O.blowmax=src.turret.laserlength
					O.owner = src
					O.loc = src.loc
					O.dir = src.dir
					step(O,src.dir)
					flick(flickinge,src.turret)
					spawn()O.Run()
			if(SPECZM==1)
				src.dir = get_dir(src,c_target)
				src.turret.dir = get_dir(src.turret,c_target)
			src.fired=1
			spawn(src.turret.fire_speed)src.fired=0
		else if(src.weapon)
			if(!src.gamein||src.reloading||src.stuck||src.manning)return
			if(src.weapon&&src.weapon2)
				if(src.weapon.clip<=0&&src.weapon2.clip<=0)
					if(src.weapon.ammo>=1){src.reloading=1;src.reload();src.reloading=0}
					return
			else if(src.weapon.clip<=0)
				if(src.weapon.ammo>=1){src.reloading=1;src.reload();src.reloading=0}
				return
			src.fired=1
			var/power=0
			var/obj/Pickup/Guns/G = src.weapon
			var/flickinge = G.flicker
			var/SPREAD = G.spread
			if(src.weapon2)
				flickinge="ShootingDualL"
				if(src.weapon.clip<=0&&src.weapon2.clip>0){src.dualturn=1;G=src.weapon2;flickinge="ShootingDualR"}
				else if(!src.dualturn&&src.weapon2.clip>0){src.dualturn=1;G=src.weapon2;flickinge="ShootingDualR"}
				else src.dualturn=0
			switch(G.stype)
				if(1)
					spawn(7)src.fired=0
					G.clip--
					G.suffix="[G.clip]/[G.mclip]"
					range(7,src)<<sound(G.fire_sound,0,volume=(G.sound_wav-master_vol))
					if(!src.weapon2&&!src.flicking){src.flicking=1;flick(flickinge,src);spawn(2)src.flicking=0}
					power=round(rand(G.fire_power*1.4,G.fire_power*2.5))
				if(2)
					spawn(10)src.fired=0
					var/bullet=G.clip
					if(bullet>=3)bullet=3
					power=round((G.fire_power*bullet))
					if(src.weapon2)flick(flickinge,src)
					else if(!src.flicking){src.flicking=1;flick(flickinge,src);spawn(2)src.flicking=0}
					for(var/i=1,i<=bullet,i++)
						G.clip--
						G.suffix="[G.clip]/[G.mclip]"
						range(7,src)<<sound(G.fire_sound,0,volume=(G.sound_wav-master_vol))
						sleep(1)
				if(3)
					var/time=G.firerate
					if(prob(30))time++
					if(src.weapon2&&!G.fshoot){time=(time/2);if(time<=6)time=6}
					spawn(time)src.fired=0
					G.clip--
					G.suffix="[G.clip]/[G.mclip]"
					range(7,src)<<sound(G.fire_sound,0,volume=(G.sound_wav-master_vol))
					if(src.weapon2)flick(flickinge,src)
					else if(!src.flicking){src.flicking=1;flick(flickinge,src);spawn(2)src.flicking=0}
					power=(G.fire_power-rand(0,8))
				if(4)
					spawn(G.firerate)src.fired=0
					G.clip--
					G.suffix="[G.clip]/[G.mclip]"
					range(7,src)<<sound(G.fire_sound,0,volume=(G.sound_wav-master_vol))
					flick(flickinge,src)
					power=round(G.fire_power*rand(8,12))
				if(5)
					spawn(G.firerate)src.fired=0
					var/bullet=G.clip
					if(bullet>=2)bullet=2
					power=round((G.fire_power*bullet)*rand(8,11))
					if(!src.weapon2&&!src.flicking){src.flicking=1;flick(flickinge,src);spawn(2)src.flicking=0}
					for(var/i=1,i<=bullet,i++)
						G.clip--
						G.suffix="[G.clip]/[G.mclip]"
						range(7,src)<<sound(G.fire_sound,0,volume=(G.sound_wav-master_vol))
						sleep(2)
			if(G.projectile)
				var/obj/projectiles/O = new G.projectile
				O.owner = src
				O.density = 1
				O.loc = src.loc
				O.dir = src.dir
				spawn()O.projectile_loop()
			else if(G.laser)
				var/obj/projectiles/Laser/O = new G.laser
				O.blowmax=G.laserlength
				O.owner = src
				O.loc = src.loc
				O.dir = src.dir
				step(O,src.dir)
				spawn()O.Run()
			else
				for(var/obj/Attackable/Windows/W in get_step(src,src.dir))
					if(W.density){W.Death();return}
				var/mob/c_target = null
				for(var/mob/M in oview(src))
					if(!M.alignment)continue
					c_target=M
					break
				if(c_target)
					src.target(c_target)
					src.dir = get_dir(src,c_target)
					if(!SPREAD)
						//new/obj/blood_effects/splatter(c_target.loc)
						if(prob(G.accuracy))
							if(prob(BLOODDROPRATE) && length(c_target.loc.overlays) < MAX_BLOOD)c_target.loc.overlays += new/obj/blood_effects/blood
							if(prob(G.accuracy/5))
								c_target.health-=power*10
								nums(c_target,power*10,"lightblue")
								if(c_target.health<=0)
									src.kills++
									death_zombie(src.team,c_target)
							else
								c_target.health-=power
								nums(c_target,power,"red")
								if(c_target.health<=0)
									src.kills++
									death_zombie(src.team,c_target)
					else if(SPREAD==1)
						var/dir_2=turn(src.dir,-45)
						var/dir_3=turn(src.dir,45)
						var/count=rand(2,3)
						for(var/mob/Z in oview(7,src))
							if(!Z.alignment)continue
							else if(!count)break
							if(get_dir(src,Z)==src.dir||get_dir(src,Z)==dir_2||get_dir(src,Z)==dir_3)
								//new/obj/blood_effects/splatter(Z.loc)
								if(get_dist(src,Z)<=1)
									Z.health-=(power*2.5)
									nums(Z,power*2.5,"lightblue")
								else if(get_dist(src,Z)<=2)
									Z.health-=power*1.5
									nums(Z,power,"red")
								else if(get_dist(src,Z)<=3)
									Z.health-=power
									nums(Z,power,"red")
								else if(get_dist(src,Z)<=4)
									Z.health-=(power/4)
									nums(Z,power/4,"red")
								else
									Z.health-=(power/5)
									nums(Z,power/5,"red")
								if(prob(BLOODDROPRATE) && length(Z.loc.overlays) < MAX_BLOOD)Z.loc.overlays += new/obj/blood_effects/blood
								if(Z.health<=0)
									src.kills++
									death_zombie(src.team,Z)
								count--
					else
						var/dir_2=turn(src.dir,-45)
						var/dir_3=turn(src.dir,45)
						var/dir_4=turn(src.dir,-25)
						var/dir_5=turn(src.dir,25)
						var/count=rand(2,6)
						for(var/mob/Z in oview(7,src))
							if(!Z.alignment)continue
							else if(!count)break
							if(get_dir(src,Z)==src.dir||get_dir(src,Z)==dir_2||get_dir(src,Z)==dir_3||get_dir(src,Z)==dir_4||get_dir(src,Z)==dir_5)
								//new/obj/blood_effects/splatter(Z.loc)
								if(get_dist(src,Z)<=1)
									Z.health-=(power*2.5)
									nums(Z,power*2.5,"lightblue")
								else if(get_dist(src,Z)<=2)
									Z.health-=power*1.5
									nums(Z,power,"red")
								else if(get_dist(src,Z)<=3)
									Z.health-=power
									nums(Z,power,"red")
								else if(get_dist(src,Z)<=4)
									Z.health-=(power/4)
									nums(Z,power/4,"red")
								else
									Z.health-=(power/5)
									nums(Z,power/5,"red")
								if(prob(BLOODDROPRATE) && length(Z.loc.overlays) < MAX_BLOOD)Z.loc.overlays += new/obj/blood_effects/blood
								if(Z.health<=0)
									src.kills++
									death_zombie(src.team,Z)
								count--
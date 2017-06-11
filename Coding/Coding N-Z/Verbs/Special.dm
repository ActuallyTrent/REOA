mob/player/client/verb
	Special()
		set background=1
		set hidden=1
		if(src.throwed||GameOver||src.stuck)return
		if(src.gamein)
			switch(src.special)
				if("Mine")
					if(src.mine>0)
						if(locate(/obj/Pickup/Items/Land_Mine) in src.loc)return
						src.throwed=1
						spawn(2)src.throwed=0
						src.mine--
						var/obj/Pickup/Items/Land_Mine/X = new(src.loc)
						X.armed=1
						X.owner=src
					else src << "You are out of mines!"
				if("Grenade")
					if(src.grenade>0)
						src.throwed=1
						spawn(10)src.throwed=0
						src.grenade--
						new/obj/effects/Grenade(src.loc,src.dir,1,src)
					else src << "You are out of grenades!"
				if("Molotov")
					if(src.molotov>0)
						src.throwed=1
						spawn(10)src.throwed=0
						src.molotov--
						new/obj/effects/Molotov(src.loc,src.dir,1,src)
					else src << "You are out of molotovs!"
		else if(!src.gamein && src.alignment)
			if(src.deadspec=="Tongue Whip"&&src.islicker)
				if(src.tongue&&!src.isdead)
					for(var/mob/player/P in oview(src,2))
						if(!P||!P.gamein)continue
						if(!src.density)break
						switch(src.dir)
							if(4,5,6)
								drawline(src,P,'tongue.dmi',list(26,15),,4,"Tongue",,,src,P,MOB_LAYER+0.1)
							if(8,9,10)
								drawline(src,P,'tongue.dmi',list(6,17),,4,"Tongue",,,src,P,MOB_LAYER+0.1)
							if(1)
								drawline(src,P,'tongue.dmi',list(16,25),,4,"Tongue",,,src,P,MOB_LAYER+0.1)
							if(2)
								drawline(src,P,'tongue.dmi',list(16,16),,4,"Tongue",,,src,P,MOB_LAYER+0.1)
						P.health-=rand(round(src.attack/1.25),(src.attack*2))
						if(P.health<=0)P.Death()
						src.tongue=0
						spawn(10)
							if(!src.tongue)
								src<<"Your Tongue grew back!"
							src.tongue=1
						sleep(3)
						for(var/line/line)
							if(line.owner==src)
								del(line)
						break
			else if(src.deadspec=="Tongue Grab"&&src.islicker)
				for(var/mob/player/M in oview(src,5))
					if(M)
						var/mob/player/N=M
						var/mob/player/lick=usr
						if(istype(M,/mob/player/NPC/Obj))continue
						if(lick.alignment)
							if(lick.islicker&&!lick.isdead&&lick.tongue&&N.gamein&&lick.icon=='Licker.dmi'&&!lick.isdead)
								if((N in oview(lick,5))&&!N.stuck&&!lick.licking)
									if(N.client)
										if(N:manning)continue
									if(!src.density)break
									lick.licking=1
									N.stuck=1
									lick.tongue=0
									lick.dir=(get_dir(src,N))
									switch(lick.dir)
										if(4,5,6)
											drawline(lick,N,'tongue.dmi',list(26,15),,4,"Tongue",,,lick,N,MOB_LAYER+0.1)
										if(8,9,10)
											drawline(lick,N,'tongue.dmi',list(6,17),,4,"Tongue",,,lick,N,MOB_LAYER+0.1)
										if(1)
											drawline(lick,N,'tongue.dmi',list(16,25),,4,"Tongue",,,lick,N,MOB_LAYER+0.1)
										if(2)
											drawline(lick,N,'tongue.dmi',list(16,16),,4,"Tongue",,,lick,N,MOB_LAYER+0.1)
									N.overlays+=/obj/playerlays/wrap
									while(lick.licking)
										if(lick.licking)
											if(!(lick.client)||(get_dist(N,lick))>5||N.alignment)
												for(var/line/line)
													if(line.owner==lick)
														del(line)
												N.stuck=0
												N.overlays-=/obj/playerlays/wrap
												lick.licking=0
												spawn(300)
													if(!lick.tongue)
														lick<<"Your Tongue grew back!"
													lick.tongue=1
												return
										if(lick.licking&&!(lick.frozen)&&(get_dist(N,lick))>1)
											step_to(N,lick)
											for(var/line/line)
												if(line.owner==lick)
													del(line)
											lick.dir=(get_dir(src,N))
											switch(lick.dir)
												if(4,5,6)
													drawline(lick,N,'tongue.dmi',list(26,15),,4,"Tongue",,,lick,N,MOB_LAYER+0.1)
												if(8,9,10)
													drawline(lick,N,'tongue.dmi',list(6,17),,4,"Tongue",,,lick,N,MOB_LAYER+0.1)
												if(1)
													drawline(lick,N,'tongue.dmi',list(16,25),,4,"Tongue",,,lick,N,MOB_LAYER+0.1)
												if(2)
													drawline(lick,N,'tongue.dmi',list(16,16),,4,"Tongue",,,lick,N,MOB_LAYER+0.1)
											sleep(rand(50,70))
											continue
			else if(src.deadspec=="Tentical Whip"&&(src.istyrant||src.istyrant2))
				if(src.tentical&&!src.isdead&&!src.wrapping)
					for(var/mob/player/P in oview(src,2))
						if(!P||!P.gamein)continue
						if(!src.density)break
						drawline(src,P,'tenticle.dmi',list(16,16),,4,"Tentacle",,,src,P,MOB_LAYER+0.1)
						P.health-=rand(rand(5,10))
						if(P.health<=0)P.Death()
						src.tentical=0
						sleep(3)
						for(var/line/line)
							if(line.owner==src)
								del(line)
						spawn(300)
							if(!src.tentical)
								src<<"Your Tenticals grew back!"
							src.tentical=1
						break
			else if(src.deadspec=="Tentical Grab"&&(src.istyrant||src.istyrant2))
				if(src.wrapping||src.isdead||!src.tentical)return
				for(var/mob/player/M in oview(src,5))
					if(istype(M,/mob/player/NPC/Obj/))continue
					if(M.stuck||!M.gamein)continue
					if(M.client)
						if(M:manning)continue
					moblist+=M
				if(moblist.len>3)
					for(var/mob/player/M in moblist)
						drawline(src,M,'tenticle.dmi',list(16,16),,4,"Tentacle",,,src,M,MOB_LAYER+0.1)
						M.overlays+=/obj/playerlays/wrap2
						M.stuck=1
						src.licks++
					src.wrapping=1
				else moblist=new/list()
				while(src.wrapping)
					for(var/mob/player/M in moblist)
						if(istype(M,/mob/player/NPC/Mob))
							if((get_dist(src,M))>7)
								for(var/line/line)
									if(line.owner==src&&line.reftarg==M)
										del(line)
								M.overlays-=/obj/playerlays/wrap2
								moblist-=M
								if(!(length(moblist)))
									src.wrapping=0
						else if(!M.client||(get_dist(src,M))>7)
							for(var/line/line)
								if(line.owner==src&&line.reftarg==M)
									del(line)
							M.overlays-=/obj/playerlays/wrap2
							moblist-=M
							if(!(length(moblist)))
								src.wrapping=0
								spawn(300)
									if(!src.tentical)
										src<<"Your Tenticals grew back!"
									src.tentical=1
					for(var/mob/player/M in moblist)
						if((get_dist(M,src))>1)
							step_to(M,src)
							for(var/line/line)
								if(line.owner==src&&line.reftarg==M)
									del(line)
							drawline(src,M,'tenticle.dmi',list(16,16),,4,"Tentacle",,,src,M,MOB_LAYER+0.1)
					sleep(rand(50,70))
					continue
			else if(src.deadspec=="Web Grab"&&src.isspider)
				for(var/mob/player/M in oview(src,5))
					if(M)
						var/mob/player/N=M
						var/mob/player/lick=usr
						if(istype(M,/mob/player/NPC/Obj))continue
						if(lick.alignment)
							if(lick.isspider&&!lick.isdead&&lick.web&&N.gamein&&lick.icon=='Spider.dmi'&&!lick.isdead)
								if((N in oview(lick,5))&&!N.stuck&&!lick.webbing)
									if(N.client)
										if(N:manning)continue
									if(!src.density)break
									lick.webbing=1
									N.stuck=1
									lick.web=0
									lick.dir=(get_dir(src,N))
									switch(lick.dir)
										if(4,5,6)
											drawline(lick,N,'web.dmi',list(26,15),,4,"Web",,,lick,N,MOB_LAYER+0.1)
										if(8,9,10)
											drawline(lick,N,'web.dmi',list(6,17),,4,"Web",,,lick,N,MOB_LAYER+0.1)
										if(1)
											drawline(lick,N,'web.dmi',list(16,25),,4,"Web",,,lick,N,MOB_LAYER+0.1)
										if(2)
											drawline(lick,N,'web.dmi',list(16,16),,4,"Web",,,lick,N,MOB_LAYER+0.1)
									N.overlays+=/obj/playerlays/wrap3
									while(lick.webbing)
										set background = 1
										if(lick.webbing)
											if(!(lick.client)||(get_dist(N,lick))>5||N.alignment)
												for(var/line/line)
													if(line.owner==lick)
														del(line)
												N.stuck=0
												N.overlays-=/obj/playerlays/wrap3
												lick.webbing=0
												spawn(300)
													if(!lick.web)
														lick<<"Your Web grew back!"
														lick.web++
												break
										if(lick.webbing&&!(lick.frozen)&&(get_dist(N,lick))>1)
											step_to(N,lick)
											for(var/line/line)
												if(line.owner==lick)
													del(line)
											lick.dir=(get_dir(src,N))
											switch(lick.dir)
												if(4,5,6)
													drawline(lick,N,'web.dmi',list(26,15),,4,"Web",,,lick,N,MOB_LAYER+0.1)
												if(8,9,10)
													drawline(lick,N,'web.dmi',list(6,17),,4,"Web",,,lick,N,MOB_LAYER+0.1)
												if(1)
													drawline(lick,N,'web.dmi',list(16,25),,4,"Web",,,lick,N,MOB_LAYER+0.1)
												if(2)
													drawline(lick,N,'web.dmi',list(16,16),,4,"Web",,,lick,N,MOB_LAYER+0.1)
											sleep(rand(50,70))
											continue
			else if(src.deadspec=="Release EggSack"&&src.isspider)
				if(src.isdead)return
				if(src.eggsack)
					src.eggsack--
					var/i=rand(7,13)
					while(i)
						new/mob/Monster/MiniSpider(src.loc)
						i--
			else if(src.deadspec=="Wall Break"&&src.ismrx)
				var/turf/T = get_step(src,src.dir)
				if(!T||src.isdead)return
				if(src.isBoss && T.density)
					T.health-=rand(30,60)
					if(T.health<=0)T.Death()
					return
			else if(src.deadspec=="Transform"&&src.ismrx)
				if(src.transformed||src.transforming||src.isdead)return
				src.transforming=1
				src.health=100000
				src.icon_state="normal_down"
				sleep(50)
				src.icon_state="normal_downup"
				sleep(5)
				src.icon_state="normal2"
				src.transformed=1
				src.transforming=0
				src.health=35000
			else if(src.deadspec=="Transform"&&src.iscyborg)
				if(src.transformed||src.transforming||src.isdead)return
				src.transforming=1
				src.health=100000
				src.icon_state="normal2"
				sleep(10)
				src.icon_state="normal"
				sleep(10)
				src.icon_state="normal2"
				sleep(10)
				src.icon_state="normal"
				sleep(10)
				src.icon_state="normal2"
				sleep(10)
				src.transformed=1
				src.transforming=0
				src.health=40000
			else if(src.deadspec=="Reload"&&src.iscyborg)
				if(src.isdead||src.hasammo||src.zreloading)return
				src.zreloading=1
				sleep(rand(100,300))
				if(src.hasammo)return
				src.zreloading=0
				src.hasammo=1
				src<<"You're reloaded"
			else if(src.deadspec=="Rocket Launcher"&&src.iscyborg)
				if(src.isdead||!src.hasammo||!src.transformed)return
				var/obj/projectiles/player_rocket/O=new(src.loc)
				O.density = 1
				O.loc = src.loc
				O.dir = src.dir
				spawn()O.projectile_loop()
				src.hasammo=0
				flick(src,"normal2_attack")
			else if(src.deadspec=="Reload"&&src.isnemesis)
				if(src.isdead||src.hasammo||src.zreloading)return
				src.zreloading=1
				sleep(rand(50,200))
				if(src.hasammo)return
				src.zreloading=0
				src.hasammo=1
				src<<"You're reloaded"
			else if(src.deadspec=="Rocket Launcher"&&src.isnemesis)
				if(src.isdead||!src.hasammo)return
				var/obj/projectiles/player_rocket/O=new(src.loc)
				O.density = 1
				O.loc = src.loc
				O.dir = src.dir
				spawn()O.projectile_loop()
				src.hasammo=0
				flick(src,"normal_attack")
	Switch()
		set hidden=1
		if(src.gamein)
			if(src.special=="Grenade")
				src.special="Mine"
				src<<"Special: Mine"
			else if(src.special=="Mine")
				src.special="Molotov"
				src<<"Special: Molotov"
			else if(src.special=="Molotov")
				src.special="Grenade"
				src<<"Special: Grenade"
		else if(!src.gamein && src.alignment)
			if(src.islicker)
				if(src.deadspec=="Tongue Whip")
					src.deadspec="Tongue Grab"
					src<<"Special: Tongue Grab"
				else if(src.deadspec=="Tongue Grab")
					src.deadspec="Tongue Whip"
					src<<"Special: Tongue Whip"
			if(src.isspider)
				if(src.deadspec=="Release EggSack")
					src.deadspec="Web Grab"
					src<<"Special: Web Grab"
				else if(src.deadspec=="Web Grab")
					src.deadspec="Release EggSack"
					src<<"Special: Release EggSack"
			if(src.iscyborg)
				if(src.deadspec=="Transform")
					src.deadspec="Rocket Launcher"
					src<<"Special: Rocket Launcher"
				else if(src.deadspec=="Rocket Launcher")
					src.deadspec="Reload"
					src<<"Special: Reload"
				else if(src.deadspec=="Reload")
					src.deadspec="Transform"
					src<<"Special: Transform"
			if(src.ismrx)
				if(src.deadspec=="Transform")
					src.deadspec="Wall Break"
					src<<"Special: Wall Break"
				else if(src.deadspec=="Wall Break")
					src.deadspec="Transform"
					src<<"Special: Transform"
			if(src.isnemesis)
				if(src.deadspec=="Reload")
					src.deadspec="Rocket Launcher"
					src<<"Special: Rocket Launcher"
				else if(src.deadspec=="Rocket Launcher")
					src.deadspec="Reload"
					src<<"Special: Reload"
			if(src.istyrant)
				if(src.deadspec=="Tentical Grab")
					src.deadspec="Tentical Whip"
					src<<"Special: Tentical Whip"
				else if(src.deadspec=="Tentical Whip")
					src.deadspec="Tentical Grab"
					src<<"Special: Tentical Grab"
			if(src.istyrant2)
				if(src.deadspec=="Tentical Grab")
					src.deadspec="Tentical Whip"
					src<<"Special: Tentical Whip"
				else if(src.deadspec=="Tentical Whip")
					src.deadspec="Tentical Grab"
					src<<"Special: Tentical Grab"
	Knife()
		set hidden=1
		if(GameOver||src.fired||!src.gamein||src.stuck)return
		src.fired=1
		spawn(4)src.fired=0
		new/obj/effects/slash(get_step(src,src.dir),src.dir)
		range(7,src)<<sound(SOUND_SLASH,0,0,0,volume=(60-master_vol))
		var/obj/playerlays/w = locate()in view(src,1)
		var/lineseg/line = locate()in view(src,1)
		if(w&&!line)
			for(var/mob/player/client/M in world)
				if(w in M.overlays)
					M.stuck=0
					M.overlays-=/obj/playerlays
			return
		if(line)
			if(istype(line.parentLine.owner,/mob/Monster/Licker)||(istype(line.parentLine.owner,/mob/player/client)&&line.parentLine.owner:islicker))
				line.parentLine.owner:licking=0
				line.parentLine.reftarg:stuck=0
				line.parentLine.reftarg.overlays-=/obj/playerlays/wrap
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
			else if(istype(line.parentLine.owner,/mob/Monster/Spider)||(istype(line.parentLine.owner,/mob/player/client)&&line.parentLine.owner:isspider))
				line.parentLine.owner:linehealth--
				if(line.parentLine.owner:linehealth<=0)
					line.parentLine.owner:webbing=0
					line.parentLine.reftarg:stuck=0
					line.parentLine.reftarg.overlays-=/obj/playerlays/wrap3
					line.parentLine.owner:linehealth=5
					del(line.parentLine)
			return
		for(var/mob/Z in get_step(src,src.dir))
			if(!Z.alignment||Z.isdead)continue
			var/newdir=get_dir(src,Z)
			src.dir=newdir
			Z.health-=rand(10,15)
			if(Z.health<=0){src.kills++;death_zombie(src.team,Z)}
			return
		for(var/obj/Attackable/Windows/A in get_step(src,src.dir))
			if(A.density)
				A.health-=rand(1,2)
				if(A.health<=0)A.Death()
				else if(A.health<=3)A.icon_state="[A.name]broke"
				else if(A.health<=6)A.icon_state="[A.name]brok"
				else if(A.health<=8)A.icon_state="[A.name]bro"
				return
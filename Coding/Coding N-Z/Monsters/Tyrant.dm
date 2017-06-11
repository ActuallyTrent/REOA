//TYRANT AI
mob/Monster/Boss/Tyrant
	icon='Tyrant.dmi'
	icon_state="normal"
	see_in_dark=10
	attack=3
	isBoss=1
	resistance = list("fire" = 100, "acid" = 100)
	isHS=0
	New()
		..()
		src.maxhealth=15000
		src.health=src.maxhealth
		src.Get_Target()
		spawn()src.Walk()
		if(prob(10))
			var/icon/i=new(src.icon)
			var
				randr = rand(0,50)
				randg = rand(0,50)
				randb = rand(0,50)
				randh = rand(0,5000)
			i.Blend(rgb(randr,randg,randb))
			icon=i
			src.maxhealth+=randh
			src.health=src.maxhealth
	Bump(atom/A)
		if(!A)return..()
		if(istype(A,/mob))
			if(istype(A,/mob/player))
				var/mob/player/p=A
				if(p.gamein)
					if(p.client)spawn()p.infection()
					var/moan=pick(list(SOUND_ZBITE,SOUND_ZBITE2))
					p<<sound(moan,0,volume=(60-master_vol))
					new/obj/effects/Bit(p.loc)
					flick("[src.icon_state]_attack",src)
					range(3,src)<<sound(SOUND_ZATTACK,volume=(60-master_vol))
					A.health-=rand(round(src.attack/1.25),(src.attack*2))
					if(A.health<=0)A.Death()
				else src.loc=p.loc
			else if(istype(A,/mob/Monster))src.loc=A.loc
		else if(istype(A,/obj/Vehicle))
			var/obj/Vehicle/V=A
			if(prob(80)&&V.main.health>0)
				oview(3,src)<<sound(SOUND_ZATTACK,0,volume=(80-master_vol))
				V.main.health-=rand(6,10)
				if(V.main.health<=0){V.main.Death()}
		else if(istype(A,/obj/Attackable))
			if(A.density)
				flick("[src.icon_state]_attack",src)
				range(3,src)<<sound(SOUND_ZATTACK,volume=(60-master_vol))
				var/obj/Attackable/B = A
				B.Bumped(round(src.attack/1.25),(src.attack*3))
		..()
	Walk()
		while(1)
			if(GameOver)break
			if(!src.target||!src.target.gamein)
				src.Get_Target()
			else
				if(src.wrapping)
					if(!(moblist.len)||!licks)
						src.wrapping=0
						sleep(10)
						continue
					for(var/mob/player/M in moblist)
						if(istype(M,/mob/player/NPC/Mob/))
							if((get_dist(src,M))>5)
								for(var/line/line)
									if(line.owner==src&&line.reftarg==M)
										del(line)
								M.overlays-=/obj/playerlays/wrap2
								moblist-=M
						else if(!M.client||(get_dist(src,M))>5)
							for(var/line/line)
								if(line.owner==src&&line.reftarg==M)
									del(line)
							M.overlays-=/obj/playerlays/wrap2
							moblist-=M
					for(var/mob/player/M in moblist)
						if((get_dist(src,M))<=1)
							if(prob(60))
								src.Bump(M)
					if(!(src.frozen))
						for(var/mob/player/M in moblist)
							if((get_dist(M,src))>1)
								step_to(M,src)
								for(var/line/line)
									if(line.owner==src&&line.reftarg==M)
										del(line)
								drawline(src,M,'tenticle.dmi',list(16,16),,4,"Tentacle",,,src,M,MOB_LAYER+0.1)
						sleep(rand(20,70))
						continue
					sleep(rand(2,10))
					continue
				if(src.frozen)
					sleep(rand(15,20))
					continue
				if(prob(5)&&!(src.wrapping))
					for(var/mob/player/M in oview(src,5))
						if(istype(M,/mob/player/NPC/Obj/))continue
						if(M.stuck||!M.gamein)continue
						if(M.client)
							if(M:manning)continue
						if(prob(80))
							moblist+=M
					if(moblist.len>3)
						for(var/mob/player/M in moblist)
							drawline(src,M,'tenticle.dmi',list(16,16),,4,"Tentacle",,,src,M,MOB_LAYER+0.1)
							M.overlays+=/obj/playerlays/wrap2
							M.stuck=1
							src.licks++
					else moblist=list()
					src.wrapping=1
					sleep(10)
					continue
				if(prob(20)&&turn)
					turn=0
					spawn(60) turn = 1
					for(var/mob/player/P in oview(src))
						if(!P||!P.gamein)continue
						src.target=P
						break
				var/turf/T=get_step(src,get_dir(src,src.target))
				if(!T.density)step_towards(src,src.target)
				else
					flick("[src.icon_state]_attack",src)
					T.health-=rand(3,6)
					if(T.health<=0)T.Death()
					step_rand(src)
			sleep(rand(5,10))
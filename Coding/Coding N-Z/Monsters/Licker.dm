//Licker AI
mob/Monster/Licker
	var/licking=0
	var/tongue=1
	icon='Licker.dmi'
	icon_state="normal"
	see_in_dark=10
	attack=1
	isHS=0
	New()
		tlickers++
		..()
		if(Difficulty=="Easy")
			src.maxhealth=rand(285,495)
			src.Get_Target()
			src.health=src.maxhealth
			spawn()src.Walk()
		else if(Difficulty=="Medium")
			src.maxhealth=rand(360,485)
			src.health=src.maxhealth
			src.Get_Target()
			spawn()src.Walk()
		else if(Difficulty=="Hard")
			src.maxhealth=rand(485,535)
			src.health=src.maxhealth
			src.Get_Target()
			spawn()src.Walk()
		else if(Difficulty=="Extreme")
			src.isHS=0
			src.maxhealth=rand(485,635)
			src.health=src.maxhealth
			src.attack+=1
			src.Get_Target()
			spawn()src.Walk()
	Bump(atom/movable/A)
		if(!A)return..()
		if(istype(A,/mob))
			if(istype(A,/mob/player))
				var/mob/player/p=A
				if(p.gamein)
					if(p.client)spawn()p.infection()
					var/moan=pick(list(SOUND_ZBITE,SOUND_ZBITE2))
					p<<moan
					new/obj/effects/Bit(p.loc)
					flick("[src.icon_state]_attack",src)
					//range(3,src)<<sound(SOUND_ZATTACK,volume=(60-master_vol))
					p.health-=rand(round(src.attack/1.25),(src.attack*3))
					if(p.health<=0)p.Death()
				else src.loc=p.loc
			else if(istype(A,/mob/Monster)&&prob(10))src.loc=A.loc
		else if(istype(A,/obj/Vehicle))
			var/obj/Vehicle/V=A
			if(prob(80)&&V.main.health>0)
				oview(3,src)<<sound(SOUND_ZATTACK,0,volume=(80-master_vol))
				V.main.health-=rand(0,6)
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
				if(src.frozen)
					sleep(rand(15,20))
					continue
				for(var/mob/player/P in oview(src,2))
					if(P==src.target)
						if(prob(80))break
						if(!P||!P.gamein)continue
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
						sleep(3)
						for(var/line/line)
							if(line.owner==src)
								del(line)
						break
				if(src.sleeper)
					sleep(rand(50,70))
					src.sleeper = 0
				if(!turn)
					if(checks>=maxchecks)
						turn = 1
						checks = 0
					else checks++
				if(prob(50) && turn)
					turn=0
					for(var/mob/player/P in oview(src))
						if(!P||!P.gamein)continue
						src.target=P
						break
				var/turf/T=get_step(src,get_dir(src,src.target))
				if(!T.density)step_towards(src,src.target)
				else step_rand(src)
			sleep(rand(2,10))
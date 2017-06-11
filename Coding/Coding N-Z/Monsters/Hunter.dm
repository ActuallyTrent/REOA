//HUNTER AI
mob/Monster/Hunter
	icon='Hunter.dmi'
	icon_state="normal"
	see_in_dark=10
	resistance = list("fire" = 240, "acid" = 320)
	attack=2
	isHS=0
	New()
		thunters++
		..()
		if(Difficulty=="Easy")
			src.maxhealth=rand(500,550)
			src.Get_Target()
			src.health=src.maxhealth
			spawn()src.Walk()
		else if(Difficulty=="Medium")
			src.maxhealth=rand(575,650)
			src.health=src.maxhealth
			src.Get_Target()
			spawn()src.Walk()
		else if(Difficulty=="Hard")
			src.maxhealth=rand(675,775)
			src.health=src.maxhealth
			src.Get_Target()
			spawn()src.Walk()
		else if(Difficulty=="Extreme")
			src.maxhealth=rand(700,850)
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
					new/obj/effects/Bit(p.loc)
					flick("[src.icon_state]_attack",src)
					range(3,src)<<sound(SOUND_HATTACK,volume=(60-master_vol))
					p.health-=rand(round(src.attack/1.25),(src.attack*3))
					if(p.health<=0)p.Death()
				else src.loc=p.loc
			else if(istype(A,/mob/Monster))src.loc=A.loc
		else if(istype(A,/obj/Vehicle))
			var/obj/Vehicle/V=A
			if(prob(80)&&V.main.health>0)
				oview(3,src)<<sound(SOUND_HATTACK,0,volume=(80-master_vol))
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
				if(prob(50) && turn)
					turn=0
					spawn(60) turn = 1
					for(var/mob/player/P in oview(src))
						if(!P||!P.gamein)continue
						src.target=P
						break
				var/turf/T=get_step(src,get_dir(src,src.target))
				if(!T.density)step_towards(src,src.target)
				else step_rand(src)
			sleep(rand(5,14))
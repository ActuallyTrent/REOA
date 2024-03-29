//THANATOS AI
mob/Monster/Boss/Thanatos
	icon='Thanatos.dmi'
	icon_state="normal"
	resistance = list("fire" = -670, "acid" = 320)
	see_in_dark=10
	attack=2
	isBoss=1
	isHS=0
	New()
		..()
		src.maxhealth=25000
		src.health=src.maxhealth
		src.Get_Target()
		spawn()src.Walk()
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
				if(src.frozen)
					sleep(rand(15,20))
					continue
				if(prob(20)&&turn)
					turn=0
					spawn(60) turn = 1
					for(var/mob/player/P in oview(src))
						if(!P||!P.gamein)continue
						src.target=P
						break
				var/turf/T=get_step(src,get_dir(src,src.target))
				if(!T.density)
					step_towards(src,src.target)
				else
					flick("[src.icon_state]_attack",src)
					T.health-=rand(5,10)
					if(T.health<=0)T.Death()
					step_rand(src)
			sleep(rand(6,10))
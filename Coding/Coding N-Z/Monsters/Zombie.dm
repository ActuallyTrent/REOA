//ZOMBIE AI
mob/Monster/Zombie
	icon_state="normal"
	see_in_dark=5
	resistance = list("fire" = -300)
	attack=2
	isHS=1
	New()
		tzombies++
		..()
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
		switch(Difficulty)
			if("Easy")
				src.maxhealth=rand(260,300)
				if(prob(10))src.attack+=1
				src.Get_Target()
				src.health=src.maxhealth
				spawn()src.Walk()
			if("Medium")
				src.maxhealth=rand(300,400)
				src.health=src.maxhealth
				if(prob(25))src.attack+=1
				src.Get_Target()
				spawn()src.Walk()
			if("Hard")
				src.maxhealth=rand(460,610)
				src.health=src.maxhealth
				src.isHS=rand(0,1)
				if(prob(50))src.attack+=rand(1,2)
				src.Get_Target()
				spawn()src.Walk()
			if("Extreme")
				src.isHS=0
				src.maxhealth=rand(720,945)
				src.health=src.maxhealth
				src.attack+=2
				src.Get_Target()
				spawn()src.Walk()
	Bump(atom/movable/A)
		..()
		if(!A)return
		else if(istype(A,/mob))
			if(istype(A,/mob/player))
				var/mob/player/p=A
				if(p.gamein)
					if(istype(A,/mob/player/NPC))
						var/mob/player/NPC/N = A
						N.target = src
					else
						spawn()p.infection()
					var/moan=pick(list(SOUND_ZBITE,SOUND_ZBITE2))
					p<<moan
					new/obj/effects/Bit(p.loc)
					flick("[src.icon_state]_attack",src)
					range(3,src)<<sound(SOUND_ZATTACK,volume=(60-master_vol))
					p.health-=rand(round(src.attack/2),src.attack)
					if(p.health<=0)
						p.Death()
				else src.loc=p.loc
			else {if(!step_rand(src))src.sleeper=1}
		else if(istype(A,/obj/Vehicle))
			var/obj/Vehicle/V=A
			if(prob(80)&&V.main.health>0)
				flick("[src.icon_state]_attack",src)
				oview(3,src)<<sound(SOUND_ZATTACK,0,volume=(80-master_vol))
				V.main.health-=rand(0,6)
				if(V.main.health<=0){V.main.Death()}
		else if(istype(A,/obj/Attackable))
			if(A.density)
				flick("[src.icon_state]_attack",src)
				range(3,src)<<sound(SOUND_ZATTACK,volume=(60-master_vol))
				var/obj/Attackable/B = A
				B.Bumped(round(src.attack/1.25),(src.attack*3))
	Walk()
		if(GameOver)return
		if(src.sleeper)
			sleep(rand(50,70))
			src.sleeper = 0
		else if(src.frozen)
			spawn(rand(15,20))src.Walk()
			return
		var/time = Speed2
		if(!src.target||!src.target.gamein)
			src.Get_Target()
			time += rand(2,6)
		else
			if(!turn)
				if(checks>=maxchecks)
					turn = 1
					checks = 0
				else checks++
			else if(prob(60) && turn)
				turn=0
				for(var/mob/player/P in oview(rand(4,6),src))
					if(!P||!P.gamein)continue
					soundmoan(P)
					if(!src.target||get_dist(src,P)<get_dist(src,src.target))
						src.target = P
			if(get_dist(src,src.target) <= 1)
				step_towards(src,src.target)
				sleep(rand(2,4))
			else
				var/a = 0
				for(var/obj/O in get_step(src,get_dir(src,src.target)))
					if(!O||!O.density||!O.attackable)continue
					src.Bump(O)
					a = 1
					break
				if(!a)
					if(!step_to(src,src.target))
						var/turf/T=get_step(src,get_dir(src,src.target))
						if(T && !T.density)step_towards(src,src.target)
						else
							if(!step_rand(src))
								src.sleeper=1
		spawn(rand(Speed1,time))src.Walk()
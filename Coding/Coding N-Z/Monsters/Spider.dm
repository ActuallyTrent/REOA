//MINISPIDER AI
mob/Monster/MiniSpider
	icon_state="normal"
	see_in_dark=5
	resistance = list("fire" = -300)
	attack=0.5
	isHS=1
	New()
		tspiders++
		..()
		src.icon='MiniSpider.dmi'
		src.icon_state="normal"
		src.maxhealth=rand(10,100)
		src.Get_Target()
		src.health=src.maxhealth
		var/xX=rand(1,2)
		var/xp=rand(1,3)
		var/yY=rand(1,2)
		var/yp=rand(1,3)
		switch(xX)
			if(1)src.pixel_x+=xp
			if(2)src.pixel_x-=xp
		switch(yY)
			if(1)src.pixel_y+=yp
			if(2)src.pixel_y-=yp
		spawn()src.Walk()
	Bump(atom/movable/A)
		..()
		if(!A)return
		else if(istype(A,/mob))
			if(istype(A,/mob/Monster))
				src.loc=A.loc
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
					p.health-=rand(round(src.attack/2),src.attack)
					if(p.health<=0)
						p.Death()
				else src.loc=p.loc
			else {if(!step_rand(src))src.sleeper=1}
		else if(istype(A,/obj/Vehicle))
			var/obj/Vehicle/V=A
			if(prob(80)&&V.main.health>0)
				flick("[src.icon_state]_attack",src)
				V.main.health-=rand(0,6)
				if(V.main.health<=0){V.main.Death()}
		else if(istype(A,/obj/Attackable))
			if(A.density)
				flick("[src.icon_state]_attack",src)
				range(3,src)<<sound(SOUND_ZATTACK,volume=(60-master_vol))
				var/obj/Attackable/B = A
				B.Bumped(round(src.attack/1.25),(src.attack*3))
	Walk()
		while(1)
			if(GameOver)break
			if(!src.target||!src.target.gamein)
				src.Get_Target()
			else
				if(src.frozen)
					sleep(rand(15,20))
					continue
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
			sleep(rand(2,5))
//SPIDER AI
mob/Monster/Spider
	var
		linehealth=5
		web=3
		webbing=0
	icon_state="normal"
	see_in_dark=5
	resistance = list("fire" = -300)
	attack=2
	isHS=1
	New()
		tspiders++
		..()
		var/randomer=rand(1,4)
		switch(randomer)
			if(1)src.icon='Spider.dmi'
			if(2)src.icon='Spider2.dmi'
			if(3)src.icon='Spider3.dmi'
			if(4)src.icon='Spider4.dmi'
		src.icon_state="normal"
		switch(Difficulty)
			if("Easy")
				src.maxhealth=rand(300,400)
				if(prob(10))src.attack+=1
				src.Get_Target()
				src.health=src.maxhealth
				spawn()src.Walk()
			if("Medium")
				src.maxhealth=rand(400,500)
				src.health=src.maxhealth
				if(prob(25))src.attack+=1
				src.Get_Target()
				spawn()src.Walk()
			if("Hard")
				src.maxhealth=rand(500,650)
				src.health=src.maxhealth
				src.isHS=rand(0,1)
				if(prob(50))src.attack+=rand(1,2)
				src.Get_Target()
				spawn()src.Walk()
			if("Extreme")
				src.isHS=0
				src.maxhealth=rand(750,1000)
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
		while(1)
			if(GameOver)break
			if(!src.target||!src.target.gamein)
				src.Get_Target()
			else
				if(src.webbing)
					if(!(src.target)||(get_dist(src,src.target))>6||src.target.alignment)
						for(var/line/line)
							if(line.owner==src)
								line.reftarg:stuck=0
								line.reftarg.overlays-=/obj/playerlays/wrap3
								del(line)
						src.webbing=0
						sleep(10)
						continue
				if(src.webbing&&!(src.frozen)&&(get_dist(src.target,src))>1)
					step_to(src.target,src)
					for(var/line/line)
						if(line.owner==src)
							del(line)
					src.dir=(get_dir(src,src.target))
					switch(src.dir)
						if(4,5,6)
							drawline(src,src.target,'web.dmi',list(26,15),,4,"Web",,,src,src.target,MOB_LAYER+0.1)
						if(8,9,10)
							drawline(src,src.target,'web.dmi',list(6,17),,4,"Web",,,src,src.target,MOB_LAYER+0.1)
						if(1)
							drawline(src,src.target,'web.dmi',list(16,25),,4,"Web",,,src,src.target,MOB_LAYER+0.1)
						if(2)
							drawline(src,src.target,'web.dmi',list(16,16),,4,"Web",,,src,src.target,MOB_LAYER+0.1)
					sleep(rand(50,70))
					continue
				if(src.webbing&&(get_dist(src.target,src))==1)
					if(prob(60))src.Bump(src.target)
					sleep(rand(2,10))
					continue
				if(src.frozen)
					sleep(rand(15,20))
					continue
				if(prob(3)&&!(src.webbing)&&(src.target in oview(src,5))&&src.target.gamein&&!(src.target in oview(src,1))&&!(src.target.stuck)&&src.web)
					if(istype(src.target,/mob/player/NPC/Obj/))continue
					if(istype(src.target,/mob/player/client))
						if(src.target.manning)continue
					src.dir=(get_dir(src,src.target))
					switch(src.dir)
						if(4,5,6)
							drawline(src,src.target,'web.dmi',list(26,15),,4,"Web",,,src,src.target,MOB_LAYER+0.1)
						if(8,9,10)
							drawline(src,src.target,'web.dmi',list(6,17),,4,"Web",,,src,src.target,MOB_LAYER+0.1)
						if(1)
							drawline(src,src.target,'web.dmi',list(16,25),,4,"Web",,,src,src.target,MOB_LAYER+0.1)
						if(2)
							drawline(src,src.target,'web.dmi',list(16,16),,4,"Web",,,src,src.target,MOB_LAYER+0.1)
					src.webbing=1
					src.web--
					spawn(300)src.web++
					src.target.stuck=1
					src.target.overlays+=/obj/playerlays/wrap3
					sleep(10)
					continue
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
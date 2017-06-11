mob/player/proc
	infection()
		if(!src||src.infected)return
		if(!prob(src.resist_inf)){src<<"<b>* You resisted infection. *";return}
		src.infected=1
		oview(src)<<"<b>* [src] has been infected. *"
		world.log<<"<b>* [src] has been infected. *"
		src<<"<b>* You have been infected. *"
		var/infadd=rand(1,4)
		while(src.infected&&!GameOver)
			src.infection+=rand(round(infadd/3),infadd)
			if(src.infection>=100){src.infection=100;break}
			else if(!src.gamein)break
			sleep(140)
		if(src.gamein&&src.infection>=100){src<<"*<b>You have died due to infection.*";src.Death()}
		src.infected=0
		src.infection=0
	stone_infe()
		if(!src||src.stone_infe)return
		src.stone_infe=1
		oview(src)<<"<b>* [src] has been given the S-Virus. *"
		world.log<<"<b>* [src] has been given the S-Virus. *"
		src<<"<b>* You have been given the S-Virus. *"
		var/infperc = 0
		while(src.stone_infe&&!GameOver)
			infperc ++
			if(infperc>=30)break
			else if(!src.gamein)break
			sleep(10)
		if(src.gamein&&infperc>=30&&src.stone_infe){src<<"*<b>You have been turned to stone.*";src.Death(1)}
		src.stone_infe=0
mob/player/var
	stone_infe = 0

var/list/soundmoaner=list(SOUND_MOAN_1,SOUND_MOAN_2,SOUND_MOAN_3,SOUND_MOAN_4,SOUND_MOAN_5,SOUND_MOAN_6,SOUND_MOAN_7,SOUND_MOAN_8,SOUND_MOAN_9)
mob/player/var/tmp/sound=0
proc/soundmoan(var/mob/player/H)
	if(H.sound)return
	H.sound=1
	spawn(20)if(H)H.sound=0
	H<<sound(pick(soundmoaner),0,volume=(rand(70,80)-master_vol))

mob/player/client
	Bump(atom/movable/a)
		..()
		if(istype(a,/obj/projectiles/Laser))
			var/obj/projectiles/Laser/b = a
			src.loc=a.loc
			b.Bump(src)
		if(istype(a,/obj/projectiles/fire))
			var/obj/projectiles/fire/b = a
			if(b.owner==src)
				return
			src.loc=a.loc
			b.Bump(src)
		if(istype(a,/obj/Attackable/Pushable_Obj))
			var/ok=0
			if(src.gamein||a.health<=0)ok=1
			if(a:locked)return
			if(ok)step(a,src.dir)
		else if(istype(a,/mob/player))
			var/mob/player/p=a
			if(src.gamein==p.gamein)src.loc=a.loc
		else if(istype(a,/mob/Monster))
			if(!src.gamein)src.loc=a.loc

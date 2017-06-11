obj/proc
	BlowUp(var/Range=1,Damage,mob/player/client/p,var/is_npc=0)
		if(!src)return
		range(src)<<sound('Audio/Sound/Explosion.wav',0,volume=(50-master_vol))
		src.luminosity=2
		src.CreateExp()
		src.CreateFire(p)
		if(explosive)
			var/count=0
			for(var/atom/movable/A in range(src,Range))
				if(count>25)break
				if(istype(A,/mob))
					var/mob/M=A
					if(!is_npc)
						if(!M.alignment||M.isdead)continue
					else
						if(M.alignment||M.isdead)continue
					M.health-=Damage
					if(M.health<=0)
						if(MAX_BLOOD)new/obj/blood_effects/chunks(M.loc)
						var/teams
						if(p){p.kills++;teams=p.team}
						if(!is_npc)
							spawn()death_zombie(teams,M,MAX_BLOOD)
						else
							spawn()M.Death()
					count++
				else if(istype(A,/obj/Attackable/Windows))
					if(A.density){A.health-=Damage;if(A.health<=0){A.Death()};count++}
			if(td||is_npc)
				for(var/turf/T in range(src,Range))
					if(!T)continue
					if(T.is_blowup)
						T.is_blowup=0
						T.Death()
					else if(T.density)
						T.Death()
		spawn(10)
			src.luminosity=0
			src.overlays.Cut()
			src.invisibility=1
			spawn(10)del(src)
	CreateExp()
		for(var/xi=1,xi<=3,xi++)
			for(var/yi=1,yi<=3,yi++)
				if(xi||yi)
					var/obj/O = new()
					O.icon='explosion.dmi'
					O.icon_state="[xi],[yi]"
					O.layer=5
					O.pixel_x=-64
					O.pixel_y=-64
					if(xi)O.pixel_x += (32*xi)
					if(yi)O.pixel_y += (32*yi)
					src.overlays+=O
atom/proc
	CreateFire(var/mob/player/M,var/num=1,var/molo=0)
		var/list/burnloc=new/list()
		for(var/turf/T in orange(num,src))if(!T.density)burnloc+=T
		if(molo)
			for(var/i=1,i<=(length(burnloc)),i++)
				if(prob(90)&&length(burnloc))
					var/obj/effects/Hazards/S_Flame/F= new(pick(burnloc))
					F.owner=M
				else
					var/obj/effects/Hazards/Flame/F= new(pick(burnloc))
					F.owner=M
		for(var/i=1,i<=(num*3),i++)
			if(prob(90)&&length(burnloc))
				var/obj/effects/Hazards/S_Flame/F= new(pick(burnloc))
				F.owner=M
			else
				var/obj/effects/Hazards/Flame/F= new(pick(burnloc))
				F.owner=M

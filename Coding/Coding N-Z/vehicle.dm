obj
	Vehicle
		attackable = 1
		name="Vehicle"
		health=600
		maxhealth=600
		var
			gas=400
			maxgas=400
			mob/player/client/driver
			obj/Vehicle/topright
			obj/Vehicle/bottomright
			obj/Vehicle/bottomleft
			obj/Vehicle/main
			list/owner_part=new/list()
		layer=4.9
		density=1
		icon='vehicle.dmi'
		tl
			icon_state="tl"
			verb
				Drive()
					set src in oview(1)
					set category=null
					var/mob/player/client/p=usr
					if(GameOver||!p.gamein)return
					if(p.incar||p.driver){p<<"You're already in a vehicle!";return}
					else if(!src.driver)
						p.invisibility=1
						p.trspot+=src.topright
						p.brspot+=src.bottomright
						p.blspot+=src.bottomleft
						p.tlspot+=src
						if(src.topright.topright)p.trspot+=src.topright.topright
						if(src.bottomleft.bottomleft)p.blspot+=src.bottomleft.bottomleft
						if(src.bottomright.bottomright)p.brspot+=src.bottomright.bottomright
						p.driver=src
						src.driver=p
						p.loc=src.loc
					else {p<<"[src.driver] is already driving that vehicle";return}
			New()
				..()
				src.topright=new/obj/Vehicle/tr
				src.bottomright=new/obj/Vehicle/br
				src.bottomleft=new/obj/Vehicle/bl
				src.topright.loc=locate(src.x+1,src.y,src.z)
				src.bottomright.loc=locate(src.x+1,src.y-1,src.z)
				src.bottomleft.loc=locate(src.x,src.y-1,src.z)
				src.main=src
				src.topright.main=src
				src.bottomright.main=src
				src.bottomleft.main=src
				src.owner_part+=src.bottomright
				src.owner_part+=src.topright
				src.owner_part+=src.bottomleft
			Death()
				src.density=0
				if(src.driver)
					src.driver.driver=0
					src.driver.invisibility = 0
					src.driver.tlspot=new/list()
					src.driver.trspot=new/list()
					src.driver.blspot=new/list()
					src.driver.brspot=new/list()
					src.driver=0
				for(var/obj/Vehicle/V in src.owner_part)
					V.Death()
				src.BlowUp(2,675)
		tr
			Death()
				src.density=0
				if(src.topright)
					var/mob/player/client/p=src.topright
					p.incar=0
					p.invisibility = 0
					src.topright=0
				src.BlowUp(2,675)
			icon_state="tr"
			verb/Get_In()
				set src in oview(1)
				set category=null
				var/mob/player/client/p=usr
				if(GameOver||!p.gamein)return
				if(p.incar||p.driver)p<<"You're already in a vehicle!"
				else if(src.topright)p<<"Somones in that spot of the vehicle!"
				else if(!src.main.driver)p<<"This vehicle has no driver! Use the top left section to enter the Driver's Seat"
				else {p.invisibility=1;src.topright=p;src.main.driver.trspot+=p;p.incar=src.main;p.loc=src.loc}
		br
			Death()
				src.density=0
				if(src.bottomright)
					var/mob/player/client/p=src.bottomright
					p.incar=0
					p.invisibility = 0
					src.bottomright=0
				src.BlowUp(2,675)
			icon_state="br"
			verb/Get_In()
				set src in oview(1)
				set category=null
				var/mob/player/client/p=usr
				if(GameOver||!p.gamein)return
				if(p.incar||p.driver)p<<"You're already in a vehicle!"
				else if(src.bottomright)p<<"Somones in that spot of the vehicle!"
				else if(!src.main.driver)p<<"This vehicle has no driver! Use the top left section to enter the Driver's Seat"
				else {p.invisibility=1;src.bottomright=p;src.main.driver.brspot+=p;p.incar=src.main;p.loc=src.loc}
		bl
			Death()
				src.density=0
				if(src.bottomleft)
					var/mob/player/client/p=src.bottomleft
					p.incar=0
					p.invisibility = 0
					src.bottomleft=0
				src.BlowUp(2,675)
			icon_state="bl"
			verb/Get_In()
				set src in oview(1)
				set category=null
				var/mob/player/client/p=usr
				if(GameOver||!p.gamein)return
				if(p.incar||p.driver)p<<"You're already in a vehicle!"
				else if(src.bottomleft)p<<"Somones in that spot of the vehicle!"
				else if(!src.main.driver)p<<"This vehicle has no driver! Use the top left section to enter the Driver's Seat"
				else {p.invisibility=1;src.bottomleft=p;src.main.driver.blspot+=p;p.incar=src.main;p.loc=src.loc}
		verb/Get_Out()
			set src in oview(0)
			set category=null
			var/mob/player/client/p=usr
			if(!p.incar&&!p.driver)return
			if(src.topright==p)
				src.topright=null
				if(src.main.driver)
					if(p in src.main.driver.trspot)
						src.main.driver.trspot-=p
			else if(src.bottomright==p)
				src.bottomright=null
				if(src.main.driver)
					if(p in src.main.driver.brspot)
						src.main.driver.brspot-=p
			else if(src.bottomleft==p)
				src.bottomleft=null
				if(src.main.driver)
					if(p in src.main.driver.blspot)
						src.main.driver.blspot-=p
			else if(src.main==src&&src.driver&&src.driver==p)
				src.driver=null
				p.tlspot=new/list()
				p.trspot=new/list()
				p.blspot=new/list()
				p.brspot=new/list()
			p.invisibility = 0
			p.incar=0
			p.driver=0
		proc
			RunOver(var/dire)
				src.dir=dire
				var/count=0
				for(var/mob/M in get_step(src,dire))
					if(!M.alignment)continue
					if(istype(M,/mob/Monster))
						M.health-=300
						if(M.health<=0){M.health=0;death_zombie(null,M)}
						count++
				if(count)return 0
				else return 1
			LookRoad(var/dire,list/L)
				var/turf/T=get_step(src,dire)
				if(T)
					if(T.density||T.y<=1||T.x>=world.maxx)return 0
					switch(T.loc.tag)
						if("/area/Block_Zone")return 0
						if("/area/Block_Blockades")return 0
					for(var/obj/O in T)
						if(istype(O,/obj/Attackable/Door)||istype(O,/obj/Attackable/Secured_Stuff/Big_Doors))
							return 0
						else if(O.density)
							if(!(O in L))return 0
					return 1
				else return 0
			GasUsage()
				if(prob(60))src.gas-=rand(0,4)
				if(src.gas<=0)src.gas=0


mob/player/client/proc
	vehiclecheck(var/dire)
		var/list/L=new/list
		L+=src.tlspot;L+=src.trspot
		L+=src.blspot;L+=src.brspot
		for(var/obj/Vehicle/A in L)
			if(!A.LookRoad(dire,L))return 0
		var/count=0
		for(var/obj/Vehicle/A in L)
			if(!A.RunOver(dire))count++
		if(count)return 0
		return 1
	carinimove()
		for(var/atom/movable/A in src.tlspot)A.loc=src.loc
		for(var/atom/movable/A in src.trspot)A.loc=src.loc
		for(var/atom/movable/A in src.blspot)A.loc=src.loc
		for(var/atom/movable/A in src.brspot)A.loc=src.loc
	carmove()
		for(var/atom/movable/A in src.tlspot){A.dir=src.dir;A.loc=src.loc}
		for(var/atom/movable/A in src.trspot){A.dir=src.dir;A.loc=locate(src.x+1,src.y,src.z)}
		for(var/atom/movable/A in src.blspot){A.dir=src.dir;A.loc=locate(src.x,src.y-1,src.z)}
		for(var/atom/movable/A in src.brspot){A.dir=src.dir;A.loc=locate(src.x+1,src.y-1,src.z)}
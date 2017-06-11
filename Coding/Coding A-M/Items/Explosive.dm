obj/Pickup
	Items
		oil_dispensor
			var/used=0
			icon='Other.dmi'
			icon_state="oil"
			name="Oil Dispensor"
			max_grouped_item=1
			DblClick()
				var/mob/player/client/M=usr
				if(!(src in M))return
				if(!M.gamein||GameOver)return
				if(src.used>=50)return
				if(length(M.contents)&&M.contents.Find(src))
					var/obj/effects/Hazards/oil/O = new(usr.loc)
					O.owner=usr
					src.used++
					src.suffix="[src.used]/50"
		gastanker
			icon='Other.dmi'
			icon_state="gas tank"
			name="Gas Tank"
			max_grouped_item=1
			DblClick()
				var/mob/player/client/M=usr
				if(!(src in M))return
				if(!M.gamein||GameOver)return
				if(length(M.contents)&&M.contents.Find(src))
					src.Drop()
		Grenade
			icon = 'Other.dmi'
			icon_state = "grenade"
			density=0
			name="Grenade"
			New()
				..()
				if(gamemode=="Fire Fight")
					spawn(50)
						if(prob(50))
							new/obj/Pickup/Items/Molotov(src.loc)
						else
							new/obj/Pickup/Items/gastanker(src.loc)
						del(src)
				else
					spawn(50)
						if(prob(50))
							new/obj/Pickup/Items/Molotov(src.loc)
							del(src)
				var/x=rand(1,2)
				var/xp=rand(1,8)
				var/y=rand(1,2)
				var/yp=rand(1,8)
				switch(x)
					if(1)src.pixel_x+=xp
					if(2)src.pixel_x-=xp
				switch(y)
					if(1)src.pixel_y+=yp
					if(2)src.pixel_y-=yp
		Molotov
			icon = 'Other.dmi'
			icon_state = "molotov"
			density=0
			name="Molotov"
			New()
				..()
				var/x=rand(1,2)
				var/xp=rand(1,8)
				var/y=rand(1,2)
				var/yp=rand(1,8)
				switch(x)
					if(1)src.pixel_x+=xp
					if(2)src.pixel_x-=xp
				switch(y)
					if(1)src.pixel_y+=yp
					if(2)src.pixel_y-=yp
		Land_Mine
			var
				armed=0
				owner=null
			icon = 'Other.dmi'
			icon_state = "mine"
			name="Land Mine"
			Trigger(var/mob/M)
				if(!src.armed||src.owner == M)return
				src.BlowUp(2,575,src.owner)
			New()
				if(gamemode=="Fire Fight")
					spawn(50)
						if(prob(50))
							new/obj/Pickup/Items/Molotov(src.loc)
						else
							new/obj/Pickup/Items/gastanker(src.loc)
						del(src)
				..()
				var/obj/Zombie_Spawn/A = locate()in view(src,3)
				if(A)
					del(src)
				var/x=rand(1,2)
				var/xp=rand(1,3)
				var/y=rand(1,2)
				var/yp=rand(1,3)
				switch(x)
					if(1)src.pixel_x+=xp
					if(2)src.pixel_x-=xp
				switch(y)
					if(1)src.pixel_y+=yp
					if(2)src.pixel_y-=yp
		C4
			var
				armed=0
				owner=0
			icon = 'Other.dmi'
			icon_state = "C4"
			name="C4"
			max_grouped_item=3
			DblClick()
				var/mob/player/client/M=usr
				if(!(src in M))return
				if(!M.gamein||GameOver)return
				if(length(M.contents)&&M.contents.Find(src))
					src.ammount--
					if(src.ammount<=1)src.suffix=null
					else src.suffix="x[src.ammount]"
					if(src.ammount<=0)
						src.armed=1
						src.owner=M.key
						src.icon_state="C4_Set"
						src.loc=M.loc
						M<<sound(SOUND_CLICK,0,0,0,volume=40)
						M.update_items()
					else
						var/obj/Pickup/Items/C4/O=new src.type(M.loc)
						O.armed=1
						O.owner=M.key
						O.icon_state="C4_Set"
						M.update_items()
						M<<sound(SOUND_CLICK,0,0,0,volume=40)
			New()
				..()

				if(gamemode=="Fire Fight")
					spawn(50)
						if(prob(50))
							new/obj/Pickup/Items/Molotov(src.loc)
						else
							new/obj/Pickup/Items/gastanker(src.loc)
						del(src)
				var/x=rand(1,2)
				var/xp=rand(1,3)
				var/y=rand(1,2)
				var/yp=rand(1,3)
				switch(x)
					if(1)src.pixel_x+=xp
					if(2)src.pixel_x-=xp
				switch(y)
					if(1)src.pixel_y+=yp
					if(2)src.pixel_y-=yp
		TripWire
			var
				isSet=0
				armed=0
				mob/owner=0
				list/lparts=new/list()
			icon = 'Other.dmi'
			icon_state = "tripwire(off)"
			name="Trip Wire"
			max_grouped_item=3
			DblClick()
				var/mob/player/client/M=usr
				if(!(src in M))return
				if(!M.gamein||GameOver)return
				if(length(M.contents)&&M.contents.Find(src))
					if(!setTW(M))return
					src.ammount--
					if(src.ammount<=1)src.suffix=null
					else src.suffix="x[src.ammount]"
					if(src.ammount<=0)
						src.armed=1
						src.owner=M
						src.dir=turn(M.dir,190)
						src.icon_state="tripwire(on)"
						src.loc=M.loc
						src.createline()
						M.update_items()
						M<<sound(SOUND_CLICK,0,0,0,volume=40)
					else
						var/obj/Pickup/Items/TripWire/O=new src.type(M.loc)
						O.armed=1
						O.owner=M
						O.dir=turn(M.dir,190)
						O.icon_state="tripwire(on)"
						O.createline()
						M.update_items()
						M<<sound(SOUND_CLICK,0,0,0,volume=40)
			New()
				..()

				if(gamemode=="Fire Fight")
					spawn(50)
						if(prob(50))
							new/obj/Pickup/Items/Molotov(src.loc)
						else
							new/obj/Pickup/Items/gastanker(src.loc)
						del(src)
				var/x=rand(1,2)
				var/xp=rand(1,3)
				var/y=rand(1,2)
				var/yp=rand(1,3)
				switch(x)
					if(1)src.pixel_x+=xp
					if(2)src.pixel_x-=xp
				switch(y)
					if(1)src.pixel_y+=yp
					if(2)src.pixel_y-=yp
			proc
				setTW(mob/M)
					if(!M||M.dir==NORTHEAST||M.dir==NORTHWEST||M.dir==SOUTHEAST||M.dir==SOUTHWEST)return 0
					var/turf/TT=get_step(M,M.dir)
					if(!TT||!TT.density)return 0
					var/turf/T=M.loc
					if(!locate(/obj/Pickup/Items/TripWire) in T)
						var/obj/O = locate(/obj/effects/Laser_Wire) in T
						if(!O)return 1
						else if(O.dir!=src.dir)
							return 1
					return 0
				createline()
					var/obj/effects/LaserLead/L=new /obj/effects/LaserLead
					L.owner=src
					L.dir=src.dir
					L.loc=src.loc
					spawn()L.Run()
			Trigger()
				if(!src.isSet||!length(src.lparts))return
				for(var/obj/O in src.lparts)
					if(!O)continue
					del(O)
				src.BlowUp(2,575,src.owner)
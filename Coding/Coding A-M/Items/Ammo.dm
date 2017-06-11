obj/Pickup
	Items
		Ammo_FlameT
			icon = 'Ammo.dmi'
			icon_state = "ammo8"
			mouse_drag_pointer = "ammo8"
			name="Propane"
			ammotogive=50
			max_grouped_item=3
			cost=80
			DblClick()
				var/mob/player/client/M=usr
				if(!(src in M))return
				if(!M.gamein||GameOver)return
				if(length(M.contents)&&M.contents.Find(src))
					if(M.weapon && M.weapon.ammo_type == src.name)
						M.ammo["Propane"] = M.weapon.ammo
					if(M.ammo["Propane"] >= MAXFLAME)
						M<<"Ammo is full"
						return
					src.ammount--
					if(src.ammount <=1)src.suffix=null
					else src.suffix="x[src.ammount]"
					M.ammo["Propane"] += src.ammotogive
					if(M.ammo["Propane"] >= MAXFLAME)
						M.ammo["Propane"] = MAXFLAME
					if(M.weapon && M.weapon.ammo_type == src.name)
						M.weapon.ammo = M.ammo["Propane"]
					if(src.ammount <= 0) M.contents-=src
					M.update_items()
					M<<sound(SOUND_CLICK,0,0,0,volume=40)
					if(src.ammount <= 0)del(src)
		Ammo_Light_Handgun
			icon = 'Ammo.dmi'
			icon_state = "ammo"
			mouse_drag_pointer = "ammo4"
			name="9mm Parabellum Rounds"
			ammotogive=18
			max_grouped_item=3
			cost=80
			DblClick()
				var/mob/player/client/M=usr
				if(!(src in M))return
				if(!M.gamein||GameOver)return
				if(length(M.contents)&&M.contents.Find(src))
					if(M.weapon && M.weapon.ammo_type == src.name)
						M.ammo["9mm Parabellum Rounds"] = M.weapon.ammo
					if(M.ammo["9mm Parabellum Rounds"] >= MAXLHAMMO)
						M<<"Ammo is full"
						return
					src.ammount--
					if(src.ammount <=1)src.suffix=null
					else src.suffix="x[src.ammount]"
					M.ammo["9mm Parabellum Rounds"] += src.ammotogive
					if(M.ammo["9mm Parabellum Rounds"] >= MAXLHAMMO)
						M.ammo["9mm Parabellum Rounds"] = MAXLHAMMO
					if(M.weapon && M.weapon.ammo_type == src.name)
						M.weapon.ammo = M.ammo["9mm Parabellum Rounds"]
					if(src.ammount <= 0) M.contents-=src
					M.update_items()
					M<<sound(SOUND_CLICK,0,0,0,volume=40)
					if(src.ammount <= 0)del(src)
			MouseDrop(var/mob/player/client/p)
				var/mob/player/client/M=usr
				if(!(src in M))return
				if(istype(p,/mob/player/client))
					if(get_dist(M,p)>2)return
					if(p.weapon && p.weapon.ammo_type == src.name)
						p.ammo["9mm Parabellum Rounds"] = p.weapon.ammo
					if(p.ammo["9mm Parabellum Rounds"] >= MAXLHAMMO)
						M<<"Ammo is full"
						return
					src.ammount--
					if(src.ammount <=1)src.suffix=null
					else src.suffix="x[src.ammount]"
					p.ammo["9mm Parabellum Rounds"] += src.ammotogive
					if(p.ammo["9mm Parabellum Rounds"] >= MAXLHAMMO)
						p.ammo["9mm Parabellum Rounds"] = MAXLHAMMO
					if(p.weapon && p.weapon.ammo_type == src.name)
						p.weapon.ammo = p.ammo["9mm Parabellum Rounds"]
					if(src.ammount <= 0) M.contents-=src
					M.update_items()
					p<<"[M] gave you [src.ammotogive] [src.name]"
					p<<sound(SOUND_CLICK,0,0,0,volume=40)
					if(src.ammount <= 0)del(src)

		Ammo_Heavy_Handgun
			icon = 'Ammo.dmi'
			icon_state = "ammo4"
			mouse_drag_pointer = "ammo4"
			name=".357 Magnum Rounds"
			ammotogive=5
			max_grouped_item=1
			cost=220
			DblClick()
				var/mob/player/client/M=usr
				if(!(src in M))return
				if(!M.gamein||GameOver)return
				if(length(M.contents)&&M.contents.Find(src))
					if(M.weapon && M.weapon.ammo_type == src.name)
						M.ammo[".357 Magnum Rounds"] = M.weapon.ammo
					if(M.ammo[".357 Magnum Rounds"] >= MAXHHAMMO)
						M<<"Ammo is full"
						return
					src.ammount--
					if(src.ammount <=1)src.suffix=null
					else src.suffix="x[src.ammount]"
					M.ammo[".357 Magnum Rounds"] += src.ammotogive
					if(M.ammo[".357 Magnum Rounds"] >= MAXHHAMMO)
						M.ammo[".357 Magnum Rounds"] = MAXHHAMMO
					if(M.weapon && M.weapon.ammo_type == src.name)
						M.weapon.ammo = M.ammo[".357 Magnum Rounds"]
					if(src.ammount <= 0) M.contents-=src
					M.update_items()
					M<<sound(SOUND_CLICK,0,0,0,volume=40)
					if(src.ammount <= 0)del(src)
			MouseDrop(var/mob/player/client/p)
				var/mob/player/client/M=usr
				if(!(src in M))return
				if(istype(p,/mob/player/client))
					if(get_dist(M,p)>2)return
					if(p.weapon && p.weapon.ammo_type == src.name)
						p.ammo[".357 Magnum Rounds"] = p.weapon.ammo
					if(p.ammo[".357 Magnum Rounds"] >= MAXHHAMMO)
						M<<"Ammo is full"
						return
					src.ammount--
					if(src.ammount <=1)src.suffix=null
					else src.suffix="x[src.ammount]"
					p.ammo[".357 Magnum Rounds"] += src.ammotogive
					if(p.ammo[".357 Magnum Rounds"] >= MAXHHAMMO)
						p.ammo[".357 Magnum Rounds"] = MAXHHAMMO
					if(p.weapon && p.weapon.ammo_type == src.name)
						p.weapon.ammo = p.ammo[".357 Magnum Rounds"]
					if(src.ammount <= 0) M.contents-=src
					M.update_items()
					p<<"[M] gave you [src.ammotogive] [src.name]"
					p<<sound(SOUND_CLICK,0,0,0,volume=40)
					if(src.ammount <= 0)del(src)
		Ammo_Shotgun
			icon = 'Ammo.dmi'
			icon_state = "ammo2"
			mouse_drag_pointer = "ammo2"
			name="12 Gauge Shells"
			ammotogive=6
			max_grouped_item=2
			cost=170
			DblClick()
				var/mob/player/client/M=usr
				if(!(src in M))return
				if(!M.gamein||GameOver)return
				if(length(M.contents)&&M.contents.Find(src))
					if(M.weapon && M.weapon.ammo_type == src.name)
						M.ammo["12 Gauge Shells"] = M.weapon.ammo
					if(M.ammo["12 Gauge Shells"] >= MAXSGAMMO)
						M<<"Ammo is full"
						return
					src.ammount--
					if(src.ammount <=1)src.suffix=null
					else src.suffix="x[src.ammount]"
					M.ammo["12 Gauge Shells"] += src.ammotogive
					if(M.ammo["12 Gauge Shells"] >= MAXSGAMMO)
						M.ammo["12 Gauge Shells"] = MAXSGAMMO
					if(M.weapon && M.weapon.ammo_type == src.name)
						M.weapon.ammo = M.ammo["12 Gauge Shells"]
					if(src.ammount <= 0) M.contents-=src
					M.update_items()
					M<<sound(SOUND_CLICK,0,0,0,volume=40)
					if(src.ammount <= 0)del(src)
			MouseDrop(var/mob/player/client/p)
				var/mob/player/client/M=usr
				if(!(src in M))return
				if(istype(p,/mob/player/client))
					if(get_dist(M,p)>2)return
					if(p.weapon && p.weapon.ammo_type == src.name)
						p.ammo["12 Gauge Shells"] = p.weapon.ammo
					if(p.ammo["12 Gauge Shells"] >= MAXSGAMMO)
						M<<"Ammo is full"
						return
					src.ammount--
					if(src.ammount <=1)src.suffix=null
					else src.suffix="x[src.ammount]"
					p.ammo["12 Gauge Shells"] += src.ammotogive
					if(p.ammo["12 Gauge Shells"] >= MAXSGAMMO)
						p.ammo["12 Gauge Shells"] = MAXSGAMMO
					if(p.weapon && p.weapon.ammo_type == src.name)
						p.weapon.ammo = p.ammo["12 Gauge Shells"]
					if(src.ammount <= 0) M.contents-=src
					M.update_items()
					p<<"[M] gave you [src.ammotogive] [src.name]"
					p<<sound(SOUND_CLICK,0,0,0,volume=40)
					if(src.ammount <= 0)del(src)
		Ammo_Light_Machinegun
			icon = 'Ammo.dmi'
			icon_state = "ammo3"
			mouse_drag_pointer = "ammo3"
			name=".45 ACP Rounds"
			ammotogive=50
			max_grouped_item=2
			cost=148
			DblClick()
				var/mob/player/client/M=usr
				if(!(src in M))return
				if(!M.gamein||GameOver)return
				if(length(M.contents)&&M.contents.Find(src))
					if(M.weapon && M.weapon.ammo_type == src.name)
						M.ammo[".45 ACP Rounds"] = M.weapon.ammo
					if(M.ammo[".45 ACP Rounds"] >= MAXACPAMMO)
						M<<"Ammo is full"
						return
					src.ammount--
					if(src.ammount <=1)src.suffix=null
					else src.suffix="x[src.ammount]"
					M.ammo[".45 ACP Rounds"] += src.ammotogive
					if(M.ammo[".45 ACP Rounds"] >= MAXACPAMMO)
						M.ammo[".45 ACP Rounds"] = MAXACPAMMO
					if(M.weapon && M.weapon.ammo_type == src.name)
						M.weapon.ammo = M.ammo[".45 ACP Rounds"]
					if(src.ammount <= 0) M.contents-=src
					M.update_items()
					M<<sound(SOUND_CLICK,0,0,0,volume=40)
					if(src.ammount <= 0)del(src)
			MouseDrop(var/mob/player/client/p)
				var/mob/player/client/M=usr
				if(!(src in M))return
				if(istype(p,/mob/player/client))
					if(get_dist(M,p)>2)return
					if(p.weapon && p.weapon.ammo_type == src.name)
						p.ammo[".45 ACP Rounds"] = p.weapon.ammo
					if(p.ammo[".45 ACP Rounds"] >= MAXACPAMMO)
						M<<"Ammo is full"
						return
					src.ammount--
					if(src.ammount <=1)src.suffix=null
					else src.suffix="x[src.ammount]"
					p.ammo[".45 ACP Rounds"] += src.ammotogive
					if(p.ammo[".45 ACP Rounds"] >= MAXACPAMMO)
						p.ammo[".45 ACP Rounds"] = MAXACPAMMO
					if(p.weapon && p.weapon.ammo_type == src.name)
						p.weapon.ammo = p.ammo[".45 ACP Rounds"]
					if(src.ammount <= 0) M.contents-=src
					M.update_items()
					p<<"[M] gave you [src.ammotogive] [src.name]"
					p<<sound(SOUND_CLICK,0,0,0,volume=40)
					if(src.ammount <= 0)del(src)
		Ammo_Heavy_Machinegun
			icon = 'Ammo.dmi'
			icon_state = "ammo6"
			mouse_drag_pointer = "ammo6"
			name="5.56mm NatO Rounds"
			ammotogive=60
			max_grouped_item=2
			cost=190
			DblClick()
				var/mob/player/client/M=usr
				if(!(src in M))return
				if(!M.gamein||GameOver)return
				if(length(M.contents)&&M.contents.Find(src))
					if(M.weapon && M.weapon.ammo_type == src.name)
						M.ammo["5.56mm NatO Rounds"] = M.weapon.ammo
					if(M.ammo["5.56mm NatO Rounds"] >= MAXNATOAMMO)
						M<<"Ammo is full"
						return
					src.ammount--
					if(src.ammount <=1)src.suffix=null
					else src.suffix="x[src.ammount]"
					M.ammo["5.56mm NatO Rounds"] += src.ammotogive
					if(M.ammo["5.56mm NatO Rounds"] >= MAXNATOAMMO)
						M.ammo["5.56mm NatO Rounds"] = MAXNATOAMMO
					if(M.weapon && M.weapon.ammo_type == src.name)
						M.weapon.ammo = M.ammo["5.56mm NatO Rounds"]
					if(src.ammount <= 0) M.contents-=src
					M.update_items()
					M<<sound(SOUND_CLICK,0,0,0,volume=40)
					if(src.ammount <= 0)del(src)
			MouseDrop(var/mob/player/client/p)
				var/mob/player/client/M=usr
				if(!(src in M))return
				if(istype(p,/mob/player/client))
					if(get_dist(M,p)>2)return
					if(p.weapon && p.weapon.ammo_type == src.name)
						p.ammo["5.56mm NatO Rounds"] = p.weapon.ammo
					if(p.ammo["5.56mm NatO Rounds"] >= MAXNATOAMMO)
						M<<"Ammo is full"
						return
					src.ammount--
					if(src.ammount <=1)src.suffix=null
					else src.suffix="x[src.ammount]"
					p.ammo["5.56mm NatO Rounds"] += src.ammotogive
					if(p.ammo["5.56mm NatO Rounds"] >= MAXNATOAMMO)
						p.ammo["5.56mm NatO Rounds"] = MAXNATOAMMO
					if(p.weapon && p.weapon.ammo_type == src.name)
						p.weapon.ammo = p.ammo["5.56mm NatO Rounds"]
					if(src.ammount <= 0) M.contents-=src
					M.update_items()
					p<<"[M] gave you [src.ammotogive] [src.name]"
					p<<sound(SOUND_CLICK,0,0,0,volume=40)
					if(src.ammount <= 0)del(src)
		Ammo_Sniper
			icon = 'Ammo.dmi'
			icon_state = "ammo5"
			mouse_drag_pointer = "ammo5"
			name="7.62x54mmR Rounds"
			ammotogive=4
			max_grouped_item=2
			cost=440
			DblClick()
				var/mob/player/client/M=usr
				if(!(src in M))return
				if(!M.gamein||GameOver)return
				if(length(M.contents)&&M.contents.Find(src))
					if(M.weapon && M.weapon.ammo_type == src.name)
						M.ammo["7.62x54mmR Rounds"] = M.weapon.ammo
					if(M.ammo["7.62x54mmR Rounds"] >= MAXMMRAMMO)
						M<<"Ammo is full"
						return
					src.ammount--
					if(src.ammount <=1)src.suffix=null
					else src.suffix="x[src.ammount]"
					M.ammo["7.62x54mmR Rounds"] += src.ammotogive
					if(M.ammo["7.62x54mmR Rounds"] >= MAXMMRAMMO)
						M.ammo["7.62x54mmR Rounds"] = MAXMMRAMMO
					if(M.weapon && M.weapon.ammo_type == src.name)
						M.weapon.ammo = M.ammo["7.62x54mmR Rounds"]
					if(src.ammount <= 0) M.contents-=src
					M.update_items()
					M<<sound(SOUND_CLICK,0,0,0,volume=40)
					if(src.ammount <= 0)del(src)
			MouseDrop(var/mob/player/client/p)
				var/mob/player/client/M=usr
				if(!(src in M))return
				if(istype(p,/mob/player/client))
					if(get_dist(M,p)>2)return
					if(p.weapon && p.weapon.ammo_type == src.name)
						p.ammo["7.62x54mmR Rounds"] = p.weapon.ammo
					if(p.ammo["7.62x54mmR Rounds"] >= MAXMMRAMMO)
						M<<"Ammo is full"
						return
					src.ammount--
					if(src.ammount <=1)src.suffix=null
					else src.suffix="x[src.ammount]"
					p.ammo["7.62x54mmR Rounds"] += src.ammotogive
					if(p.ammo["7.62x54mmR Rounds"] >= MAXMMRAMMO)
						p.ammo["7.62x54mmR Rounds"] = MAXMMRAMMO
					if(p.weapon && p.weapon.ammo_type == src.name)
						p.weapon.ammo = p.ammo["7.62x54mmR Rounds"]
					if(src.ammount <= 0) M.contents-=src
					M.update_items()
					p<<"[M] gave you [src.ammotogive] [src.name]"
					p<<sound(SOUND_CLICK,0,0,0,volume=40)
					if(src.ammount <= 0)del(src)
		Ammo_Sniper2
			icon = 'Ammo.dmi'
			icon_state = "ammo7"
			mouse_drag_pointer = "ammo7"
			name=".50 CC Rounds"
			ammotogive=3
			max_grouped_item=2
			cost=660
			DblClick()
				var/mob/player/client/M=usr
				if(!(src in M))return
				if(!M.gamein||GameOver)return
				if(length(M.contents)&&M.contents.Find(src))
					if(M.weapon && M.weapon.ammo_type == src.name)
						M.ammo[".50 CC Rounds"] = M.weapon.ammo
					if(M.ammo[".50 CC Rounds"] >= MAX50CCAMMO)
						M<<"Ammo is full"
						return
					src.ammount--
					if(src.ammount <=1)src.suffix=null
					else src.suffix="x[src.ammount]"
					M.ammo[".50 CC Rounds"] += src.ammotogive
					if(M.ammo[".50 CC Rounds"] >= MAX50CCAMMO)
						M.ammo[".50 CC Rounds"] = MAX50CCAMMO
					if(M.weapon && M.weapon.ammo_type == src.name)
						M.weapon.ammo = M.ammo[".50 CC Rounds"]
					if(src.ammount <= 0) M.contents-=src
					M.update_items()
					M<<sound(SOUND_CLICK,0,0,0,volume=40)
					if(src.ammount <= 0)del(src)
			MouseDrop(var/mob/player/client/p)
				var/mob/player/client/M=usr
				if(!(src in M))return
				if(istype(p,/mob/player/client))
					if(get_dist(M,p)>2)return
					if(p.weapon && p.weapon.ammo_type == src.name)
						p.ammo[".50 CC Rounds"] = p.weapon.ammo
					if(p.ammo[".50 CC Rounds"] >= MAX50CCAMMO)
						M<<"Ammo is full"
						return
					src.ammount--
					if(src.ammount <=1)src.suffix=null
					else src.suffix="x[src.ammount]"
					p.ammo[".50 CC Rounds"] += src.ammotogive
					if(p.ammo[".50 CC Rounds"] >= MAX50CCAMMO)
						p.ammo[".50 CC Rounds"] = MAX50CCAMMO
					if(p.weapon && p.weapon.ammo_type == src.name)
						p.weapon.ammo = p.ammo[".50 CC Rounds"]
					if(src.ammount <= 0) M.contents-=src
					M.update_items()
					p<<"[M] gave you [src.ammotogive] [src.name]"
					p<<sound(SOUND_CLICK,0,0,0,volume=40)
					if(src.ammount <= 0)del(src)
		Ammo_Flame
			icon = 'Ammo.dmi'
			icon_state = "flame"
			mouse_drag_pointer = "flame"
			name="Flame Rounds"
			ammotogive=2
			max_grouped_item=2
			cost=320
			DblClick()
				var/mob/player/client/M=usr
				if(!(src in M))return
				if(!M.gamein||GameOver)return
				if(length(M.contents)&&M.contents.Find(src))
					if(M.weapon)
						if(M.weapon.grenade_launcher)
							if(M.weapon.projectile == /obj/projectiles/flame)
								M.ammo["Flame Rounds"] = M.weapon.ammo
					if(M.ammo["Flame Rounds"] >= MAXNADEAMMO)
						M<<"Ammo is full"
						return
					src.ammount--
					if(src.ammount <=1)src.suffix=null
					else src.suffix="x[src.ammount]"
					M.ammo["Flame Rounds"] += src.ammotogive
					if(M.ammo["Flame Rounds"] >= MAXNADEAMMO)
						M.ammo["Flame Rounds"] = MAXNADEAMMO
					if(M.weapon)
						if(M.weapon.grenade_launcher)
							if(M.weapon.projectile == /obj/projectiles/flame)
								M.weapon.ammo = M.ammo["Flame Rounds"]
					if(src.ammount <= 0) M.contents-=src
					M.update_items()
					M<<sound(SOUND_CLICK,0,0,0,volume=40)
					if(src.ammount <= 0)del(src)
			MouseDrop(var/mob/player/client/p)
				var/mob/player/client/M=usr
				if(!(src in M))return
				if(istype(p,/mob/player/client))
					if(get_dist(M,p)>2)return
					if(p.weapon && p.weapon.ammo_type == src.name)
						p.ammo["Flame Rounds"] = p.weapon.ammo
					if(p.ammo["Flame Rounds"] >= MAXNADEAMMO)
						M<<"Ammo is full"
						return
					src.ammount--
					if(src.ammount <=1)src.suffix=null
					else src.suffix="x[src.ammount]"
					p.ammo["Flame Rounds"] += src.ammotogive
					if(p.ammo["Flame Rounds"] >= MAXNADEAMMO)
						p.ammo["Flame Rounds"] = MAXNADEAMMO
					if(p.weapon && p.weapon.ammo_type == src.name)
						p.weapon.ammo = p.ammo["Flame Rounds"]
					if(src.ammount <= 0) M.contents-=src
					M.update_items()
					p<<"[M] gave you [src.ammotogive] [src.name]"
					p<<sound(SOUND_CLICK,0,0,0,volume=40)
					if(src.ammount <= 0)del(src)
			New()
				..()
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
		Ammo_Acid
			icon = 'Ammo.dmi'
			icon_state = "acid"
			mouse_drag_pointer = "acid"
			name="Acid Rounds"
			ammotogive=2
			max_grouped_item=2
			cost=320
			DblClick()
				var/mob/player/client/M=usr
				if(!(src in M))return
				if(!M.gamein||GameOver)return
				if(length(M.contents)&&M.contents.Find(src))
					if(M.weapon)
						if(M.weapon.grenade_launcher)
							if(M.weapon.projectile == /obj/projectiles/acid)
								M.ammo["Acid Rounds"] = M.weapon.ammo
					if(M.ammo["Acid Rounds"] >= MAXNADEAMMO)
						M<<"Ammo is full"
						return
					src.ammount--
					if(src.ammount <=1)src.suffix=null
					else src.suffix="x[src.ammount]"
					M.ammo["Acid Rounds"] += src.ammotogive
					if(M.ammo["Acid Rounds"] >= MAXNADEAMMO)
						M.ammo["Acid Rounds"] = MAXNADEAMMO
					if(M.weapon)
						if(M.weapon.grenade_launcher)
							if(M.weapon.projectile == /obj/projectiles/acid)
								M.weapon.ammo = M.ammo["Acid Rounds"]
					if(src.ammount <= 0) M.contents-=src
					M.update_items()
					M<<sound(SOUND_CLICK,0,0,0,volume=40)
					if(src.ammount <= 0)del(src)
			MouseDrop(var/mob/player/client/p)
				var/mob/player/client/M=usr
				if(!(src in M))return
				if(istype(p,/mob/player/client))
					if(get_dist(M,p)>2)return
					if(p.weapon && p.weapon.ammo_type == src.name)
						p.ammo["Acid Rounds"] = p.weapon.ammo
					if(p.ammo["Acid Rounds"] >= MAXNADEAMMO)
						M<<"Ammo is full"
						return
					src.ammount--
					if(src.ammount <=1)src.suffix=null
					else src.suffix="x[src.ammount]"
					p.ammo["Acid Rounds"] += src.ammotogive
					if(p.ammo["Acid Rounds"] >= MAXNADEAMMO)
						p.ammo["Acid Rounds"] = MAXNADEAMMO
					if(p.weapon && p.weapon.ammo_type == src.name)
						p.weapon.ammo = p.ammo["Acid Rounds"]
					if(src.ammount <= 0) M.contents-=src
					M.update_items()
					p<<"[M] gave you [src.ammotogive] [src.name]"
					p<<sound(SOUND_CLICK,0,0,0,volume=40)
					if(src.ammount <= 0)del(src)
			New()
				..()
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
		Ammo_Freeze
			icon = 'Ammo.dmi'
			icon_state = "freeze"
			mouse_drag_pointer = "freeze"
			name="Freeze Rounds"
			ammotogive=2
			max_grouped_item=2
			cost=320
			DblClick()
				var/mob/player/client/M=usr
				if(!(src in M))return
				if(!M.gamein||GameOver)return
				if(length(M.contents)&&M.contents.Find(src))
					if(M.weapon)
						if(M.weapon.grenade_launcher)
							if(M.weapon.projectile == /obj/projectiles/freeze)
								M.ammo["Freeze Rounds"] = M.weapon.ammo
					if(M.ammo["Freeze Rounds"] >= MAXNADEAMMO)
						M<<"Ammo is full"
						return
					src.ammount--
					if(src.ammount <=1)src.suffix=null
					else src.suffix="x[src.ammount]"
					M.ammo["Freeze Rounds"] += src.ammotogive
					if(M.ammo["Freeze Rounds"] >= MAXNADEAMMO)
						M.ammo["Freeze Rounds"] = MAXNADEAMMO
					if(M.weapon)
						if(M.weapon.grenade_launcher)
							if(M.weapon.projectile == /obj/projectiles/freeze)
								M.weapon.ammo = M.ammo["Freeze Rounds"]
					if(src.ammount <= 0) M.contents-=src
					M.update_items()
					M<<sound(SOUND_CLICK,0,0,0,volume=40)
					if(src.ammount <= 0)del(src)
			MouseDrop(var/mob/player/client/p)
				var/mob/player/client/M=usr
				if(!(src in M))return
				if(istype(p,/mob/player/client))
					if(get_dist(M,p)>2)return
					if(p.weapon && p.weapon.ammo_type == src.name)
						p.ammo["Freeze Rounds"] = p.weapon.ammo
					if(p.ammo["Freeze Rounds"] >= MAXNADEAMMO)
						M<<"Ammo is full"
						return
					src.ammount--
					if(src.ammount <=1)src.suffix=null
					else src.suffix="x[src.ammount]"
					p.ammo["Freeze Rounds"] += src.ammotogive
					if(p.ammo["Freeze Rounds"] >= MAXNADEAMMO)
						p.ammo["Freeze Rounds"] = MAXNADEAMMO
					if(p.weapon && p.weapon.ammo_type == src.name)
						p.weapon.ammo = p.ammo["Freeze Rounds"]
					if(src.ammount <= 0) M.contents-=src
					M.update_items()
					p<<"[M] gave you [src.ammotogive] [src.name]"
					p<<sound(SOUND_CLICK,0,0,0,volume=40)
					if(src.ammount <= 0)del(src)
			New()
				..()
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
		Ammo_Explosive
			icon = 'Ammo.dmi'
			icon_state = "explosive"
			mouse_drag_pointer = "explosive"
			name="Explosive Rounds"
			ammotogive=2
			max_grouped_item=2
			cost=320
			DblClick()
				var/mob/player/client/M=usr
				if(!(src in M))return
				if(!M.gamein||GameOver)return
				if(length(M.contents)&&M.contents.Find(src))
					if(M.weapon)
						if(M.weapon.grenade_launcher)
							if(M.weapon.projectile == /obj/projectiles/explosive)
								M.ammo["Explosive Rounds"] = M.weapon.ammo
					if(M.ammo["Explosive Rounds"] >= MAXNADEAMMO)
						M<<"Ammo is full"
						return
					src.ammount--
					if(src.ammount <=1)src.suffix=null
					else src.suffix="x[src.ammount]"
					M.ammo["Explosive Rounds"] += src.ammotogive
					if(M.ammo["Explosive Rounds"] >= MAXNADEAMMO)
						M.ammo["Explosive Rounds"] = MAXNADEAMMO
					if(M.weapon)
						if(M.weapon.grenade_launcher)
							if(M.weapon.projectile == /obj/projectiles/explosive)
								M.weapon.ammo = M.ammo["Explosive Rounds"]
					if(src.ammount <= 0) M.contents-=src
					M.update_items()
					M<<sound(SOUND_CLICK,0,0,0,volume=40)
					if(src.ammount <= 0)del(src)
			MouseDrop(var/mob/player/client/p)
				var/mob/player/client/M=usr
				if(!(src in M))return
				if(istype(p,/mob/player/client))
					if(get_dist(M,p)>2)return
					if(p.weapon && p.weapon.ammo_type == src.name)
						p.ammo["Explosive Rounds"] = p.weapon.ammo
					if(p.ammo["Explosive Rounds"] >= MAXNADEAMMO)
						M<<"Ammo is full"
						return
					src.ammount--
					if(src.ammount <=1)src.suffix=null
					else src.suffix="x[src.ammount]"
					p.ammo["Explosive Rounds"] += src.ammotogive
					if(p.ammo["Explosive Rounds"] >= MAXNADEAMMO)
						p.ammo["Explosive Rounds"] = MAXNADEAMMO
					if(p.weapon && p.weapon.ammo_type == src.name)
						p.weapon.ammo = p.ammo["Explosive Rounds"]
					if(src.ammount <= 0) M.contents-=src
					M.update_items()
					p<<"[M] gave you [src.ammotogive] [src.name]"
					p<<sound(SOUND_CLICK,0,0,0,volume=40)
					if(src.ammount <= 0)del(src)
			New()
				..()
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
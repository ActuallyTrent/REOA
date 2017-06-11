obj/Pickup
	Items
		Launcher_Parts
			icon = 'Other.dmi'
			icon_state = "launcher"
			name="Launcher Parts"
			max_grouped_item=1
			cost=3000
			DblClick()
				set src in usr
				set category = null
				var/mob/player/client/M=usr
				if(!(src in usr))return
				if(!M.gamein||GameOver)return
				var/list/glist=list()
				for(var/obj/Pickup/Guns/G in M.contents)
					if(G.cancombine)
						glist+=G
				var/obj/Pickup/Guns/G = input(usr,"Upgrade Which weapon?")as null|anything in glist
				if(G)
					G.combined=1
					del(src)
		Turret
			icon = 'Other.dmi'
			icon_state = "turret"
			name="Turret"
			max_grouped_item=1
			cost=3000
			DblClick()
				set src in usr
				set category = null
				var/mob/player/client/M=usr
				if(!(src in usr))return
				if(!M.gamein||GameOver)return
				var/mob/player/NPC/Obj/personal_sentry_turret/T = new(M.loc)
				T.owner=M
				if(src.upgrade)
					var/xxx=rand(10,20)
					xxx*=src.upgrade
					for(var/o in T.overlays)
						if(o)del(o)
					T.health+=xxx
					T.gun_power+=xxx
					T.overlays+=text2path("/obj/turretlevel/a[src.upgrade]")
					T.upgrade_level=src.upgrade
					if(src.upgrade_level>=3)T.maxupgrade=1
				spawn(5)M.update_items()
				del(src)
		Hammer
			icon = 'Other.dmi'
			icon_state = "hammer"
			mouse_drag_pointer = "hammer"
			name="Hammer"
			max_grouped_item=20
			cost=200
			MouseDrop(var/atom/a)
				var/mob/player/client/M=usr
				if(isobj(a))
					var/obj/o=a
					if(istype(o,/obj/Attackable/Destructable_Obj)||istype(o,/obj/Attackable/Pushable_Obj))
						if(!o.density)
							if(!M.fixing)
								if(!(src in M))return
								if(!M.gamein||GameOver)return
								if(length(M.contents)&&M.contents.Find(src))
									var/fix
									M.fixing=1
									var/obj/repair/TI = new((locate(o.x,o.y,o.z)))
									spawn()
										while((M in oview(o,1))&&!o.density)
											sleep(rand(1,5))
											fix++
											TI.icon_state="[fix]"
											if(fix>=14)
												M.points++
												o.density=1
												o.health=initial(o.health)
												o.healthbonus=0
												o.maxupgrade=0
												o.upgrade_level=0
												o.icon_state=initial(o.icon_state)
												o.attackable=1
												src.ammount--
												if(src.ammount<=0)src.suffix=null
												else src.suffix="x[src.ammount]"
												if(!src.suffix)M.contents-=src
												M.update_items()
										M.fixing=0
										del(TI)
										if(!src.suffix)del(src)
						else if(!o.maxupgrade)
							if(istype(o,/obj/Attackable/Pushable_Obj/Destroyable/Barricade))
								if(!M.fixing)
									if(!(src in M))return
									if(!M.gamein||GameOver)return
									if(length(M.contents)&&M.contents.Find(src))
										var/fix
										M.fixing=1
										var/obj/repair/TI = new((locate(o.x,o.y,o.z)))
										var/done=0
										spawn()
											while((M in oview(o,1))&&!done)
												sleep(rand(1,5))
												fix++
												TI.icon_state="[fix]"
												if(fix>=14)
													M.points++
													if(!o.density)
														o.density=1
														o.health=initial(o.health)
														o.healthbonus=0
														o.maxupgrade=0
														o.upgrade_level=0
														o.icon_state=initial(o.icon_state)
														o.attackable=1
													else
														if(o.upgrade_level>=3)
															o.maxupgrade=1
															done=1
															goto end
														o.overlays-=text2path("/obj/cadelays/a[o.upgrade_level]")
														o.upgrade_level++
														if(o.upgrade_level>=3)o.maxupgrade=1
														o.healthbonus+=rand(10,20)
														o.health+=o.healthbonus
														o.overlays+=text2path("/obj/cadelays/a[o.upgrade_level]")
													done=1
													src.ammount--
													if(src.ammount<=0)src.suffix=null
													else src.suffix="x[src.ammount]"
													if(!src.suffix)M.contents-=src
													M.update_items()
													end
											M.fixing=0
											del(TI)
											if(!src.suffix)del(src)
				else if(ismob(a))
					if(istype(a,/mob/player/NPC/Obj/personal_sentry_turret))
						var/mob/player/NPC/Obj/personal_sentry_turret/n=a
						if(!n.maxupgrade)
							if(!M.fixing)
								if(!(src in M))return
								if(!M.gamein||GameOver)return
								if(length(M.contents)&&M.contents.Find(src))
									var/fix
									M.fixing=1
									var/done
									var/obj/repair/TI = new((locate(n.x,n.y,n.z)))
									spawn()
										while((M in oview(n,1))&&!done)
											sleep(rand(1,5))
											fix++
											TI.icon_state="[fix]"
											if(fix>=14)
												M.points++
												if(n.upgrade_level>=3)
													n.maxupgrade=1
													done=1
													goto end
												n.overlays-=text2path("/obj/turretlevel/a[n.upgrade_level]")
												n.upgrade_level++
												if(n.upgrade_level>=3)n.maxupgrade=1
												var/healthbonus=rand(10,20)
												var/gun_powerbonus=rand(10,20)
												n.health+=healthbonus
												n.gun_power+=gun_powerbonus
												n.overlays+=text2path("/obj/turretlevel/a[n.upgrade_level]")
												done=1
												src.ammount--
												if(src.ammount<=0)src.suffix=null
												else src.suffix="x[src.ammount]"
												if(!src.suffix)M.contents-=src
												M.update_items()
												end
										M.fixing=0
										del(TI)
										if(!src.suffix)del(src)
					if(istype(a,/mob/player/NPC/Obj/MANNED_TURRET/MAN_1))
						var/mob/player/NPC/Obj/MANNED_TURRET/MAN_1/n=a
						if(!n.maxupgrade)
							if(!M.fixing)
								if(!(src in M))return
								if(!M.gamein||GameOver)return
								if(length(M.contents)&&M.contents.Find(src))
									var/fix
									M.fixing=1
									var/done
									var/obj/repair/TI = new((locate(n.x,n.y,n.z)))
									spawn()
										while((M in oview(n,1))&&!done)
											sleep(rand(1,5))
											fix++
											TI.icon_state="[fix]"
											if(fix>=14)
												M.points++
												if(n.upgrade_level>=3)
													n.maxupgrade=1
													done=1
													goto end
												n.upgrade_level++
												if(n.upgrade_level>=3)n.maxupgrade=1
												n.firepower+=rand(10,20)
												n.varheatmax+=rand(5,12)
												done=1
												src.ammount--
												if(src.ammount<=0)src.suffix=null
												else src.suffix="x[src.ammount]"
												if(!src.suffix)M.contents-=src
												M.update_items()
												end
										M.fixing=0
										del(TI)
										if(!src.suffix)del(src)
					if(istype(a,/mob/player/NPC/Obj/MANNED_TURRET/MAN_4))
						var/mob/player/NPC/Obj/MANNED_TURRET/MAN_4/n=a
						if(!n.maxupgrade)
							if(!M.fixing)
								if(!(src in M))return
								if(!M.gamein||GameOver)return
								if(length(M.contents)&&M.contents.Find(src))
									var/fix
									M.fixing=1
									var/done
									var/obj/repair/TI = new((locate(n.x,n.y,n.z)))
									spawn()
										while((M in oview(n,1))&&!done)
											sleep(rand(1,5))
											fix++
											TI.icon_state="[fix]"
											if(fix>=14)
												M.points++
												if(n.upgrade_level>=1)
													n.maxupgrade=1
													done=1
													goto end
												n.upgrade_level++
												if(n.upgrade_level>=1)n.maxupgrade=1
												n.aimfire=1
												done=1
												src.ammount--
												if(src.ammount<=0)src.suffix=null
												else src.suffix="x[src.ammount]"
												if(!src.suffix)M.contents-=src
												M.update_items()
												end
										M.fixing=0
										del(TI)
										if(!src.suffix)del(src)
		Spray
			icon = 'Cures.dmi'
			icon_state = "spray"
			mouse_drag_pointer = "spray"
			name="Spray"
			max_grouped_item=1
			cost=200
			DblClick()
				var/mob/player/client/M=usr
				if(!(src in M))return
				if(!M.gamein||GameOver)return
				if(length(M.contents)&&M.contents.Find(src))
					if(M.health<M.maxhealth||M.stone_infe)
						if(M.stone_infe){M.stone_infe = 0;M<<"You were cured of the S-Virus!"}
						src.ammount--
						if(src.ammount<=0)src.suffix=null
						else src.suffix="x[src.ammount]"
						M.health=M.maxhealth
						M.healthbar()
						M<<"Your healed"
						if(!src.suffix)M.contents-=src
						M.update_items()
						M<<sound(SOUND_CLICK,0,0,0,volume=40)
						if(!src.suffix)del(src)
			MouseDrop(var/mob/player/client/p)
				var/mob/player/M=usr
				if(!(src in M))return
				if(istype(p,/mob/player/client))
					if(get_dist(M,p)>2)return
					if(p.health < p.maxhealth||p.stone_infe)
						if(p.stone_infe){p.stone_infe=0;p<<"[M] Cured you of the S-Virus";M<<"You cured [p] of the S-Virus"}
						src.ammount--
						if(src.ammount<=0)src.suffix=null
						else src.suffix="x[src.ammount]"
						p.health=p.maxhealth
						p.healthbar()
						if(p != M)
							p<<"[M] healed you."
							M<<"You've healed [p]."
						else M<<"You've been healed."
						if(!src.suffix)p.contents-=src
						p.update_items()
						p<<sound(SOUND_CLICK,0,0,0,volume=40)
						if(!src.suffix)del(src)
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
		TCure
			icon = 'Cures.dmi'
			icon_state = "t-cure"
			name="T-Cure"
			mouse_drag_pointer = "t-cure"
			max_grouped_item=1
			cost=300
			DblClick()
				var/mob/player/client/M=usr
				if(!(src in M))return
				if(!M.gamein||GameOver)return
				if(length(M.contents)&&M.contents.Find(src))
					if(M.infected)
						src.ammount--
						if(src.ammount<=0)src.suffix=null
						else src.suffix="x[src.ammount]"
						M.infected=0
						M.infection=0
						M<<"You've been cured."
						if(!src.suffix)M.contents-=src
						M.update_items()
						M<<sound(SOUND_CLICK,0,0,0,volume=40)
						if(!src.suffix)del(src)
			MouseDrop(var/mob/player/client/p)
				var/mob/player/M=usr
				if(!(src in M))return
				if(istype(p,/mob/player/client))
					if(get_dist(M,p)>2)return
					if(p.infected)
						src.ammount--
						if(src.ammount<=0)src.suffix=null
						else src.suffix="x[src.ammount]"
						p.infected=0
						p.infection=0
						if(p != M)
							p<<"[M] cured you."
							M<<"You've cured [p]."
						else M<<"You've been cured."
						if(!src.suffix)p.contents-=src
						p.update_items()
						p<<sound(SOUND_CLICK,0,0,0,volume=40)
						if(!src.suffix)del(src)
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
obj
	Attackable
		proc/Bumped(var/damage)
		Door
			attackable = 1
			mouse_opacity=0
			icon='B_Obj.dmi'
			var
				broken=0
			health=50
			maxhealth=50
			density=1
			opacity=1
			Door1
				Vertical
					icon_state="door_Closed"
					name="door"
				Horizontal
					icon_state="door2_Closed"
					name="door2"
			Door2
				icon_state="door3_Closed"
				name="door3"
			Death()
				src.density=0
				src.opacity=0
				src.icon_state="[src.name]_Open"
				src.loc.overlays+=src
				src.loc=null
			Bumped(var/damage)
				src.health-=damage
				if(src.health<=0)
					src.Death()
		Secured_Stuff
			icon='B_Obj.dmi'
			Big_Doors
				attackable = 1
				mouse_opacity=0
				var
					broken=0
					switch_number=0
					locked = 0
				layer=5
				Secured_Door
					health=160
					maxhealth=160
					density=1
					opacity=1
					name="Secured_Door2"
					icon_state="Secured_Door2Closed"
				Secured_Door2
					health=160
					maxhealth=160
					density=1
					opacity=0
					name="Secured_Door3"
					icon_state="Secured_Door3Closed"
				Death()
					src.density=0
					src.opacity=0
					src.icon_state="[src.name]Open"
					src.loc.overlays+=src
					src.loc=null
				Bumped(var/damage)
					src.health-=damage
					if(src.health<=0)
						src.Death()
		Windows
			attackable = 1
			mouse_opacity=0
			opacity=0
			density=1
			health=10
			maxhealth=10
			Window
				name="window"
				icon_state="window"
				icon='B_Obj.dmi'
			Window3
				name="window3"
				icon='B_Obj.dmi'
				icon_state="window3"
			Death()
				orange(src,7)<<sound(SOUND_WINDOW_BREAK,0,volume=(50-master_vol))
				src.density=0
				src.icon_state="[src.name]broken"
				src.loc.overlays+=src
				src.loc=null
			Bumped(var/damage)
				src.health-=damage
				if(src.health<=0)
					src.Death()
				else if(src.health<=3)
					src.icon_state="[src.name]broke"
				else if(src.health<=6)
					src.icon_state="[src.name]brok"
				else if(src.health<=8)
					src.icon_state="[src.name]bro"
		Pushable_Obj
			Bumped(var/damage)
				src.pixel_x=rand(-2,2)
				src.pixel_y=rand(-2,2)
				src.health-=damage
				if(src.health<=0)
					src.Death()
				else if(src.health<=(src.maxhealth/5))
					src.icon_state="[src.name]_2"
				else if(src.health<=(src.maxhealth/2))
					src.icon_state="[src.name]_1"
			var/locked=1
			attackable = 1
			New()
				..()
				for(var/obj/Attackable/Pushable_Obj/P in src.loc)
					if(P==src)continue
					del(P)
				src.health=initial(src.health)
			Destroyable
				DeskChair
					icon='B_Turfs.dmi'
					icon_state="desk_s"
					name="desk_s"
					health=45
					maxhealth=45
					density=1
					NORTH
						icon_state="desk_n"
						name="desk_n"
					WEST
						icon_state="desk_w"
						name="desk_w"
					EAST
						icon_state="desk_e"
						name="desk_e"
					Death()
						src.density=0
						src.icon_state="desk_gone"
						src.attackable=0
				Barricade
					icon='Obj.dmi'
					icon_state="Barricade(1)"
					name="Barricade(1)"
					density=1
					health=50
					maxhealth=50
					Death()
						src.density=0
						src.icon_state="Barricade(1)_gone"
						src.attackable=0
						src.overlays-=text2path("/obj/cadelays/a[src.upgrade_level]")
				Barricade2
					icon='Obj.dmi'
					icon_state="Barricade(2)"
					name="Barricade(2)"
					density=1
					health=50
					maxhealth=50
					Death()
						src.density=0
						src.icon_state="Barricade(2)_gone"
						src.attackable=0
					verb/Get()
						set src in oview(1)
						set category = null
						var/mob/player/client/M=usr
						if(!(src in oview(1)))return
						if(!M.gamein||GameOver||!src.density)return
						if(M.check_items())
							M.contents+=src
							M.update_items()
					verb/drop()
						set src in usr
						set category = null
						var/mob/player/client/M=usr
						if(!(src in M))return
						if(!M.gamein||GameOver)return
						for(var/obj/P in M.loc)
							if(P==src)continue
							if(P.density)
								return
						if(!src.suffix)
							src.layer=initial(src.layer)
							src.loc=M.loc
							M.update_items()
					DblClick()
						..()
						src.drop()
				Barricade3
					icon='QS_Items.dmi'
					icon_state="GDI barricade"
					name="GDI barricade"
					density=1
					health=75
					maxhealth=75
					Death()
						src.density=0
						src.icon_state="GDI barricade_gone"
						src.attackable=0
					verb/Get()
						set src in oview(1)
						set category = null
						var/mob/player/client/M=usr
						if(!(src in oview(1)))return
						if(!M.gamein||GameOver||!src.density)return
						if(M.check_items())
							M.contents+=src
							M.update_items()
					verb/drop()
						set src in usr
						set category = null
						var/mob/player/client/M=usr
						if(!(src in M))return
						if(!M.gamein||GameOver)return
						for(var/obj/P in M.loc)
							if(P==src)continue
							if(P.density)
								return
						if(!src.suffix)
							src.layer=initial(src.layer)
							src.loc=M.loc
							M.update_items()
					DblClick()
						..()
						src.drop()
				Barricade4
					icon='QS_Items.dmi'
					icon_state="Nod barricade"
					name="Nod barricade"
					density=1
					health=75
					maxhealth=75
					Death()
						src.density=0
						src.icon_state="Nod barricade_gone"
						src.attackable=0
					verb/Get()
						set src in oview(1)
						set category = null
						var/mob/player/client/M=usr
						if(!(src in oview(1)))return
						if(!M.gamein||GameOver||!src.density)return
						if(M.check_items())
							M.contents+=src
							M.update_items()
					verb/drop()
						set src in usr
						set category = null
						var/mob/player/client/M=usr
						if(!(src in M))return
						if(!M.gamein||GameOver)return
						for(var/obj/P in M.loc)
							if(P==src)continue
							if(P.density)
								return
						if(!src.suffix)
							src.layer=initial(src.layer)
							src.loc=M.loc
							M.update_items()
					DblClick()
						..()
						src.drop()

			Pushable
				health=60
				maxhealth=60
				GarbageBox
					icon='turfs.dmi'
					icon_state="GarbageBox"
					name = "GarbageBox"
					density=1
				GarbageBox2
					icon='turfs.dmi'
					icon_state="GarbageBox2"
					name = "GarbageBox2"
					density=1
				Death()
					src.density=0
					src.icon_state="[src.name]dest"
					src.attackable=0
			verb
				Pull()
					set category=null
					set src in oview(1)
					var/mob/player/client/M=usr
					if(!(src in oview(1,M)))return
					if(GameOver||nomounting||M.incar||src.locked||M.driver||!M.gamein||!src.density||src.pulled||M.stand||M.stuck||M.manning)return
					var/PO = locate(/obj/Attackable/Pushable_Obj) in M.loc
					if(PO)return
					PO = locate(/obj/Attackable/Destructable_Obj) in M.loc
					if(PO)return
					if(M.loc.loc.tag == "/area/Block_Blockades")return
					src.pulled = 1
					spawn(5) src.pulled = 0
					src.loc = M.loc
				Jump_On()
					set category=null
					set src in oview(1)
					var/mob/player/client/M=usr
					if(!(src in oview(1,M)))return
					if(GameOver||nomounting||M.incar||M.driver||!M.gamein||!src.density||src.pulled||M.stand||M.stuck||M.manning)return
					M.loc=src.loc
				Lock()
					set src in oview(1)
					set category = null
					set name = "Lock/Unlock"
					var/mob/player/client/M=usr
					if(!(src in oview(1)))return
					if(!M.gamein||GameOver)return
					src.locked=!src.locked
		Destructable_Obj
			Bumped(var/damage)
				src.pixel_x=rand(-2,2)
				src.pixel_y=rand(-2,2)
				src.health-=damage
				if(src.health<=0)
					src.Death()
				else if(src.health<=(src.maxhealth/5))
					src.icon_state="[src.name]_2"
				else if(src.health<=(src.maxhealth/2))
					src.icon_state="[src.name]_1"
			attackable = 1
			Nod_Wall
				density=1
				health=100
				icon='B_Turfs.dmi'
				icon_state="Nod Wall"
				name="Nod Wall"
				WEST
					icon_state="Nod Wall1"
					name="Nod Wall1"
				EAST
					icon_state="Nod Wall2"
					name="Nod Wall2"
			GDI_Wall
				density=1
				health=100
				icon='B_Turfs.dmi'
				icon_state="GDI Wall"
				name="GDI Wall"
				WEST
					icon_state="GDI Wall1"
					name="GDI Wall1"
				EAST
					icon_state="GDI Wall2"
					name="GDI Wall2"
			Chainlink_Fence
				density=1
				health=60
				icon='B_Turfs.dmi'
				icon_state="fence1"
				name="fence1"
				NORTH
					icon_state="fence1"
					name="fence1"
				SOUTHWEST
					icon_state="fence1"
					name="fence1"
				WEST
					icon_state="fence3"
					name="fence3"
				EAST
					icon_state="fence4"
					name="fence4"
				SOUTHEAST
					icon_state="fence1"
					name="fence1"
			Death()
				src.density=0
				src.icon_state="[src.name]_down"
				src.attackable=0
			verb/Jump_Over()
				set category=null
				set src in oview(1)
				var/mob/player/client/M=usr
				if(!(src in oview(1,M)))return
				if(GameOver||nomounting||M.incar||M.driver||!M.gamein||!src.density||M.stand||M.stuck||M.manning)return
				M.loc=src.loc
	Secured_Stuff
		icon='B_Obj.dmi'
		Switch
			name="Control Pad"
			var
				switch_number=0
				switched=0
			icon_state="Switch down"
			verb/Press()
				set src in oview(1)
				set category=null
				var/mob/player/client/M=usr
				if(src.switched||GameOver||!M.gamein)return
				src.switched=1;spawn(20)if(src)src.switched=0
				for(var/obj/Attackable/Secured_Stuff/Big_Doors/D in world)
					if(D.broken||D.locked)continue
					if(D.switch_number&&!D.broken)
						if(D.switch_number==src.switch_number)
							if(D.density)
								D.icon_state="[D.name]Open"
								flick("[D.name]Opening",D)
								spawn(8)
									D.density=0
									D.opacity = 0
							else
								D.icon_state="[D.name]Closed"
								flick("[D.name]Closing",D)
								spawn(8)
									D.density=initial(D.density)
									D.opacity=initial(D.opacity)
	turretlevel
		layer=MOB_LAYER+0.2
		a1
			icon='turret_level.dmi'
		a2
			icon='turret_level2.dmi'
		a3
			icon='turret_level3.dmi'
	cadelays
		icon='cade_level.dmi'
		icon_state="0"
		a0
			icon_state="0"
		a1
			icon_state="1"
		a2
			icon_state="2"
		a3
			icon_state="3"
	repair
		icon='repair_bar.dmi'
		icon_state="1"
		layer=MOB_LAYER+0.2
	classes
		icon='Classes.dmi'
		layer=MOB_LAYER+0.2
	playerlays
		wrap
			icon='wrap.dmi'
			layer=MOB_LAYER+0.1
		wrap2
			icon='wrap2.dmi'
			layer=MOB_LAYER+0.1
		wrap3
			icon='wrap3.dmi'
			layer=MOB_LAYER+0.1
	Pushable_tmp
		Barricade2
			icon='Obj.dmi'
			icon_state="Barricade(2)"
			verb/Get()
				set src in oview(1)
				set category = null
				var/mob/player/client/M=usr
				if(!(src in oview(1)))return
				if(!M.gamein||GameOver)return
				if(M.check_items())
					var/obj/Attackable/Pushable_Obj/Destroyable/Barricade2/A = new(M.loc)
					M.contents+=A
					M.update_items()
					del(src)
	name
		icon='text.dmi'
		icon_state=""
		density=0
		layer=MOB_LAYER+99998
		pixel_y=-13
	healthbar
		icon='hparamater.dmi'
		icon_state="Fine"
		density=0
		layer=MOB_LAYER+99997
		pixel_y=-2
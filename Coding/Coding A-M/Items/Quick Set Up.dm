obj
	Pickup
		Items
			QS
				icon='QS_Items.dmi'
				var
					it
					ita = 1
					sp
					list
						items=list()
						numi2spawn=list()
						num2spawn=list()
						listx=list()
						listy=list()
				DblClick()
					set src in usr
					set category = null
					var/mob/player/client/M=usr
					if(!(src in usr))return
					if(!M.gamein||GameOver)return
					if(sp)
						for(var/i=num2spawn[1],i>=1,i--)
							var/atom/movable/a = new sp(M.loc)
							if( a )
								step_to(a,(locate(M.x+listx[i],M.y+listy[i],M.z)))
								step_to(a,(locate(M.x+listx[i],M.y+listy[i],M.z)))
								if(!(a in view( M )))
									del( a )
					if(it&&length(items))
						for(var/i=length(items),i>=1,i--)
							for(var/ii=numi2spawn[i],ii>=1,ii--)
								var/a=items[i]
								new a(M.loc)
					spawn(5)M.update_items()
					del(src)

				Barricade_N   										//Example
					icon_state = "Nod Pack"							//Set the icon state here (Icon file is in Icons-Items-QS_Items)
					name="Nod Quick Set up Barricade Pack"			//Name
					sp = /obj/Attackable/Pushable_Obj/Destroyable/Barricade4	//This will be the spawn path. For the sake of you I will list them\
					/obj/Attackable/Pushable_Obj/Destroyable/Barricade = Normal Cade\
												  Barricade2 = Yellow Cade\
												  Barricade3 = GDI Cade\
												  Barricade4 = Nod Cade\
												  DeskChair = South facing desk\
												  DeskChair/NORTH = North facing desk\
												  		    EAST = East facing desk\
												  		    WEST = West facing desk\
									  Pushable/GarbageBox = GarbageBox\
									  		   GarbageBox2 = Other GarbageBox\
						/Destructable_Obj/Chainlink_Fence/NORTH = Fence\
						 								 /EAST = Eastern facing fence\
						 								 /WEST = Western facing fence\
						 				 /Nod_Wall = Nod_Wall\
						 				 /Nod_Wall/EAST = Eastern facing Nod_Wall\
						 				 /Nod_Wall/WEST = Western facing Nod_Wall\
						 				 /GDI_Wall = GDI_Wall\
						 				 /GDI_Wall/EAST = Eastern facing GDI_Wall\
						 				 /GDI_Wall/WEST = Western facing GDI_Wall\
					/mob/player/NPC/Mob/UCM = UCM\
										FUCK THAT. I'm not listing all 423428342934283 different NPCs\
								   /Obj/MANNED_TURRET/MAN_1 = Manned MG\
								   					 /MAN_2 = Manned Fam0s Cannon\
								   	   /sentry_turret = sentry turret\
								   	   I think you get the idea.

					max_grouped_item=1
					cost=500

					num2spawn=list( 1 = 8 )  //How many of this item you wish to spawn

					listx=list( 1=1 , 2=1 , 3=1 , 4=0 , 5=0 , 6=-1 , 7=-1 , 8=-1 )  //These two are the tricky ones, they require a brain!  The numbers, are co ords ontop of the qs\
													pack's owner's location. 1=2 from listx, and 1=2 from listy is the same as the co ord +2,+2, \
													so the object will spawn 2 spaces above and two spaces to the east (the right) of the qs pack's\
													location. Don't worry about them spawning on dense locs, i've sorted all of that myself. :B

					listy=list( 1=0 , 2=1 , 3=-1 , 4=1 , 5=-1 , 6=1 , 7=-1 , 8=0 )

				Radio_N
					icon_state = "blackhand radio"
					name="Nod Backup Radio"
					sp = /mob/player/NPC/Mob/Black_Hand
					max_grouped_item=1
					cost=500

					num2spawn=list( 1=4 )

					listx=list( 1=2 , 2=-2 , 3=2 , 4=-2)

					listy=list( 1=2 , 2=-2 , 3=-2 , 4=2)

				Radio_G
					icon_state = "army radio"
					name="GDI Backup Radio"
					sp = /mob/player/NPC/Mob/GDI_Commando
					max_grouped_item=1
					cost=500

					num2spawn=list( 1=4 )

					listx=list( 1=2 , 2=-2 , 3=2 , 4=-2)

					listy=list( 1=2 , 2=-2 , 3=-2 , 4=2)

				Engie_Pack
					icon_state = "engie pack"
					name="Engineer Supply Pack"
					sp = /obj/Attackable/Pushable_Obj/Destroyable/Barricade
					it = 1
					max_grouped_item=1

					items=list( 1= /obj/Pickup/Items/Hammer)

					numi2spawn=list(1=20)

					cost=500

					num2spawn=list( 1 = 8 )

					listx=list( 1=1 , 2=1 , 3=1 , 4=0 , 5=0 , 6=-1 , 7=-1 , 8=-1 )

					listy=list( 1=0 , 2=1 , 3=-1 , 4=1 , 5=-1 , 6=1 , 7=-1 , 8=0 )

				Demo_Pack
					icon_state = "dpack"
					name="Demolitions Supply Pack"
					it = 1
					max_grouped_item=1

					items=list( 1= /obj/Pickup/Items/Ammo_Heavy_Machinegun, 2= /obj/Pickup/Items/Ammo_Shotgun, 3= /obj/Pickup/Items/C4, 4= /obj/Pickup/Items/Grenade)

					numi2spawn=list(1=3,2=3,3=2,4=2)

					cost=300

				Arms_Pack
					icon_state = "apack"
					name="Ammo Supply Pack"
					it = 1
					max_grouped_item=1

					items=list( 1= /obj/Pickup/Items/Ammo_Heavy_Machinegun, 2= /obj/Pickup/Items/Ammo_Shotgun, 3= /obj/Pickup/Items/Ammo_Sniper2, 4= /obj/Pickup/Items/Ammo_Light_Machinegun)

					numi2spawn=list(1=3,2=3,3=3,4=3)

					cost=300

				Medi_Pack
					icon_state = "mpack"
					name="MediPack"
					it = 1
					max_grouped_item=1

					items=list( 1= /obj/Pickup/Items/TCure, 2= /obj/Pickup/Items/Spray)

					numi2spawn=list(1=2,2=3)

					cost=1000



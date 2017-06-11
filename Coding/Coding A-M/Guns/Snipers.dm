obj/Pickup
	Guns
		FiftyCaliber
			name = "M107 .50 Caliber"
			icon = 'Snipers.dmi'
			icon_state = "50Caliber"
			clip=1
			mclip=1
			maxammo=MAX50CCAMMO
			firerate=28
			fire_power=200
			reload_time=48
			accuracy=100
			reload_sound=SOUND_RELOADING_2
			fire_sound=SOUND_MOSIN_FIRE
			ammo_type=".50 CC Rounds"
			flicker="ShootingMachineH"
			overlay_add='50Caliber.dmi'
			sniper=1
			sound_wav=70
			at=6
			cost=3800
			range = 32
			clip_level_cost=400
			firerate_level_cost=200
			gunpower_level_cost=200
			upgrade_mc=list(1=4,2=8,3=10)
			upgrade_fp=list(1=210,2=220,3=230,4=240,5=250,6=260)
			upgrade_rs=list(1=46,2=40,3=36,4=32,5=30,6=26)
			upgrade_fr=list(1=24,2=22,3=20,4=18)
			upgrade_ac=list(1=100)
			accuracy_level=1
			can_upgrade_ac = 0
			ammo_path=/obj/Pickup/Items/Ammo_Sniper2
			verb
				Sniper_Mode()
					set category = "Commands"
					set src in usr
					set category = null
					var/mob/player/client/M=usr
					if(!(src in M))return
					if(!M.gamein||M.reloading||GameOver)return
					if(M.weapon == src)
						if(M.sniper_mode)
							M.sniper_mode=0
							M.client.eye=M
							M.eye_x=10
							M.eye_y=10
							M.eye_z=1
						else
							var/turf/T = M.loc
							if(!T)return
							M.sniper_mode = 1
							M.eye_x=T.x
							M.eye_y=T.y
							M.eye_z=T.z
							M.client.eye=locate(M.eye_x, M.eye_y, M.eye_z)
		FiftyCaliber_N
			name = "Nod .50 Caliber"
			icon = 'Snipers.dmi'
			icon_state = "50Caliber_N"
			clip=5
			mclip=5
			maxammo=MAX50CCAMMO
			firerate=28
			fire_power=300
			reload_time=48
			accuracy=100
			reload_sound=SOUND_RELOADING_2
			fire_sound=SOUND_MOSIN_FIRE
			ammo_type=".50 CC Rounds"
			flicker="ShootingMachineH"
			overlay_add='50CaliberN.dmi'
			sniper=1
			sound_wav=70
			at=6
			cost=8000
			range = 32
			clip_level_cost=600
			firerate_level_cost=200
			gunpower_level_cost=200
			upgrade_mc=list(1=7,2=10,3=15)
			upgrade_fp=list(1=310,2=320,3=330,4=340,5=350,6=360)
			upgrade_rs=list(1=46,2=40,3=36,4=32,5=30,6=26)
			upgrade_fr=list(1=24,2=22,3=20,4=18,5=15,6=10)
			upgrade_ac=list(1=100)
			accuracy_level=1
			can_upgrade_ac = 0
			ammo_path=/obj/Pickup/Items/Ammo_Sniper2
			verb
				Sniper_Mode()
					set category = "Commands"
					set src in usr
					set category = null
					var/mob/player/client/M=usr
					if(!(src in M))return
					if(!M.gamein||M.reloading||GameOver)return
					if(M.weapon == src)
						if(M.sniper_mode)
							M.sniper_mode=0
							M.client.eye=M
							M.eye_x=10
							M.eye_y=10
							M.eye_z=1
						else
							var/turf/T = M.loc
							if(!T)return
							M.sniper_mode = 1
							M.eye_x=T.x
							M.eye_y=T.y
							M.eye_z=T.z
							M.client.eye=locate(M.eye_x, M.eye_y, M.eye_z)
		FiftyCaliber_G
			name = "GDI .50 Caliber"
			icon = 'Snipers.dmi'
			icon_state = "50Caliber_G"
			clip=1
			mclip=1
			maxammo=MAX50CCAMMO
			firerate=28
			fire_power=300
			reload_time=48
			accuracy=100
			reload_sound=SOUND_RELOADING_2
			fire_sound=SOUND_MOSIN_FIRE
			ammo_type=".50 CC Rounds"
			flicker="ShootingMachineH"
			overlay_add='50CaliberG.dmi'
			sniper=1
			sound_wav=70
			at=6
			cost=8000
			range = 32
			clip_level_cost=400
			firerate_level_cost=200
			gunpower_level_cost=200
			upgrade_mc=list(1=4)
			upgrade_fp=list(1=350,2=400,3=450,4=500,5=550)
			upgrade_rs=list(1=46,2=40,3=36,4=32,5=30,6=20)
			upgrade_fr=list(1=24,2=22,3=20,4=18)
			upgrade_ac=list(1=100)
			accuracy_level=1
			can_upgrade_ac = 0
			ammo_path=/obj/Pickup/Items/Ammo_Sniper2
			verb
				Sniper_Mode()
					set category = "Commands"
					set src in usr
					set category = null
					var/mob/player/client/M=usr
					if(!(src in M))return
					if(!M.gamein||M.reloading||GameOver)return
					if(M.weapon == src)
						if(M.sniper_mode)
							M.sniper_mode=0
							M.client.eye=M
							M.eye_x=10
							M.eye_y=10
							M.eye_z=1
						else
							var/turf/T = M.loc
							if(!T)return
							M.sniper_mode = 1
							M.eye_x=T.x
							M.eye_y=T.y
							M.eye_z=T.z
							M.client.eye=locate(M.eye_x, M.eye_y, M.eye_z)
		MosinNagant
			name = "Mosin-Nagant"
			icon = 'Snipers.dmi'
			icon_state = "Mosin-Nagant"
			clip=1
			mclip=1
			maxammo=MAXMMRAMMO
			firerate=12
			fire_power=96
			reload_time=42
			accuracy=100
			reload_sound=SOUND_RELOADING_2
			fire_sound=SOUND_MOSIN_FIRE
			ammo_type="7.62x54mmR Rounds"
			flicker="ShootingMachineH"
			overlay_add='Mosin-Nagant.dmi'
			sniper=1
			sound_wav=70
			at=6
			cost=2718
			clip_level_cost=400
			firerate_level_cost=300
			upgrade_mc=list(1=5)
			upgrade_fp=list(1=100,2=104,3=108,4=110,5=114,6=120)
			upgrade_rs=list(1=40,2=36,3=32,4=28,5=24,6=20)
			upgrade_fr=list(1=11,2=10,3=9,4=8)
			upgrade_ac=list(1=100)
			accuracy_level=1
			can_upgrade_ac = 0
			ammo_path=/obj/Pickup/Items/Ammo_Sniper
			verb
				Sniper_Mode()
					set category = "Commands"
					set src in usr
					set category = null
					var/mob/player/client/M=usr
					if(!(src in M))return
					if(!M.gamein||M.reloading||GameOver)return
					if(M.weapon == src)
						if(M.sniper_mode)
							M.sniper_mode=0
							M.client.eye=M
							M.eye_x=10
							M.eye_y=10
							M.eye_z=1
						else
							var/turf/T = M.loc
							if(!T)return
							M.sniper_mode = 1
							M.eye_x=T.x
							M.eye_y=T.y
							M.eye_z=T.z
							M.client.eye=locate(M.eye_x, M.eye_y, M.eye_z)
		M24
			name = "M24"
			icon = 'Snipers.dmi'
			icon_state = "m24"
			clip=1
			mclip=1
			maxammo=MAXMMRAMMO
			firerate=12
			fire_power=96
			reload_time=42
			accuracy=100
			reload_sound=SOUND_RELOADING_2
			fire_sound=SOUND_MOSIN_FIRE
			ammo_type="7.62x54mmR Rounds"
			flicker="ShootingMachineH"
			overlay_add='50Caliber.dmi'
			sniper=1
			sound_wav=70
			at=6
			cost=2718
			clip_level_cost=400
			firerate_level_cost=300
			upgrade_mc=list(1=5)
			upgrade_fp=list(1=100,2=104,3=108,4=110,5=114,6=120)
			upgrade_rs=list(1=40,2=36,3=32,4=28,5=24,6=20)
			upgrade_fr=list(1=11,2=10,3=9,4=8)
			upgrade_ac=list(1=100)
			accuracy_level=1
			can_upgrade_ac = 0
			ammo_path=/obj/Pickup/Items/Ammo_Sniper
			verb
				Sniper_Mode()
					set category = "Commands"
					set src in usr
					set category = null
					var/mob/player/client/M=usr
					if(!(src in M))return
					if(!M.gamein||M.reloading||GameOver)return
					if(M.weapon == src)
						if(M.sniper_mode)
							M.sniper_mode=0
							M.client.eye=M
							M.eye_x=10
							M.eye_y=10
							M.eye_z=1
						else
							var/turf/T = M.loc
							if(!T)return
							M.sniper_mode = 1
							M.eye_x=T.x
							M.eye_y=T.y
							M.eye_z=T.z
							M.client.eye=locate(M.eye_x, M.eye_y, M.eye_z)
		SVD
			name = "SVD"
			icon = 'Snipers.dmi'
			icon_state = "SVD"
			clip=5
			mclip=5
			maxammo=MAXMMRAMMO
			firerate=12
			fire_power=96
			reload_time=42
			accuracy=100
			reload_sound=SOUND_RELOADING_2
			fire_sound=SOUND_MOSIN_FIRE
			ammo_type="7.62x54mmR Rounds"
			flicker="ShootingMachineH"
			overlay_add='Mosin-Nagant.dmi'
			sniper=1
			sound_wav=70
			at=6
			cost=16718
			clip_level_cost=400
			firerate_level_cost=300
			upgrade_mc=list(1=10)
			upgrade_fp=list(1=300,2=304,3=308,4=310,5=314,6=320)
			upgrade_rs=list(1=40,2=36,3=32,4=28,5=24,6=20)
			upgrade_fr=list(1=11,2=10,3=9,4=8,5=6)
			upgrade_ac=list(1=100)
			accuracy_level=1
			can_upgrade_ac = 0
			ammo_path=/obj/Pickup/Items/Ammo_Sniper
			verb
				Sniper_Mode()
					set category = "Commands"
					set src in usr
					set category = null
					var/mob/player/client/M=usr
					if(!(src in M))return
					if(!M.gamein||M.reloading||GameOver)return
					if(M.weapon == src)
						if(M.sniper_mode)
							M.sniper_mode=0
							M.client.eye=M
							M.eye_x=10
							M.eye_y=10
							M.eye_z=1
						else
							var/turf/T = M.loc
							if(!T)return
							M.sniper_mode = 1
							M.eye_x=T.x
							M.eye_y=T.y
							M.eye_z=T.z
							M.client.eye=locate(M.eye_x, M.eye_y, M.eye_z)



		scout
			name = "Scout Tatical"
			icon = 'Snipers.dmi'
			icon_state = "Scout"
			clip=5
			mclip=5
			maxammo=MAXMMRAMMO
			firerate=12
			fire_power=306
			reload_time=42
			accuracy=100
			reload_sound=SOUND_RELOADING_2
			fire_sound=SOUND_MOSIN_FIRE
			ammo_type="7.62x54mmR Rounds"
			flicker="ShootingMachineH"
			overlay_add='50Caliber.dmi'
			sniper=1
			sound_wav=70
			at=6
			cost=12718
			clip_level_cost=400
			firerate_level_cost=300
			upgrade_mc=list(1=8)
			upgrade_fp=list(1=400,2=404,3=408,4=410,5=414,6=420)
			upgrade_rs=list(1=40,2=36,3=32,4=28,5=24,6=20)
			upgrade_fr=list(1=11,2=10)
			upgrade_ac=list(1=100)
			accuracy_level=1
			can_upgrade_ac = 0
			ammo_path=/obj/Pickup/Items/Ammo_Sniper
			verb
				Sniper_Mode()
					set category = "Commands"
					set src in usr
					set category = null
					var/mob/player/client/M=usr
					if(!(src in M))return
					if(!M.gamein||M.reloading||GameOver)return
					if(M.weapon == src)
						if(M.sniper_mode)
							M.sniper_mode=0
							M.client.eye=M
							M.eye_x=10
							M.eye_y=10
							M.eye_z=1
						else
							var/turf/T = M.loc
							if(!T)return
							M.sniper_mode = 1
							M.eye_x=T.x
							M.eye_y=T.y
							M.eye_z=T.z
							M.client.eye=locate(M.eye_x, M.eye_y, M.eye_z)

		Nodsnip
			name = "Ramjet Sniper(N)"
			icon = 'Snipers.dmi'
			icon_state = "RamN"
			clip=30
			mclip=30
			maxammo=MAXMMRAMMO
			firerate=12
			fire_power=1000
			reload_time=12
			accuracy=100
			reload_sound=SOUND_RELOADING_2
			fire_sound=SOUND_MOSIN_FIRE
			ammo_type="7.62x54mmR Rounds"
			flicker="ShootingMachineH"
			overlay_add='50Caliber.dmi'
			sniper=1
			sound_wav=70
			at=6
			cost=92718
			clip_level_cost=400
			firerate_level_cost=300
			upgrade_mc=list(1=40)
			upgrade_fp=list(1=1400,)
			upgrade_rs=list(1=20)
			upgrade_fr=list(1=10)
			upgrade_ac=list(1=100)
			accuracy_level=1
			can_upgrade_ac = 0
			ammo_path=/obj/Pickup/Items/Ammo_Sniper
			verb
				Sniper_Mode()
					set category = "Commands"
					set src in usr
					set category = null
					var/mob/player/client/M=usr
					if(!(src in M))return
					if(!M.gamein||M.reloading||GameOver)return
					if(M.weapon == src)
						if(M.sniper_mode)
							M.sniper_mode=0
							M.client.eye=M
							M.eye_x=10
							M.eye_y=10
							M.eye_z=1
						else
							var/turf/T = M.loc
							if(!T)return
							M.sniper_mode = 1
							M.eye_x=T.x
							M.eye_y=T.y
							M.eye_z=T.z
							M.client.eye=locate(M.eye_x, M.eye_y, M.eye_z)


		GDIsnip
			name = "Ramjet Sniper(G)"
			icon = 'Snipers.dmi'
			icon_state = "RamG"
			clip=30
			mclip=30
			maxammo=MAXMMRAMMO
			firerate=12
			fire_power=2000
			reload_time=22
			accuracy=100
			reload_sound=SOUND_RELOADING_2
			fire_sound=SOUND_MOSIN_FIRE
			ammo_type="7.62x54mmR Rounds"
			flicker="ShootingMachineH"
			overlay_add='50Caliber.dmi'
			sniper=1
			sound_wav=70
			at=6
			cost=92718
			clip_level_cost=400
			firerate_level_cost=300
			upgrade_mc=list(1=40)
			upgrade_fp=list(1=2400,)
			upgrade_rs=list(1=20)
			upgrade_fr=list(1=20,2=18)
			upgrade_ac=list(1=100)
			accuracy_level=1
			can_upgrade_ac = 0
			ammo_path=/obj/Pickup/Items/Ammo_Sniper
			verb
				Sniper_Mode()
					set category = "Commands"
					set src in usr
					set category = null
					var/mob/player/client/M=usr
					if(!(src in M))return
					if(!M.gamein||M.reloading||GameOver)return
					if(M.weapon == src)
						if(M.sniper_mode)
							M.sniper_mode=0
							M.client.eye=M
							M.eye_x=10
							M.eye_y=10
							M.eye_z=1
						else
							var/turf/T = M.loc
							if(!T)return
							M.sniper_mode = 1
							M.eye_x=T.x
							M.eye_y=T.y
							M.eye_z=T.z
							M.client.eye=locate(M.eye_x, M.eye_y, M.eye_z)
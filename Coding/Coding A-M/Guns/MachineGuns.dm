obj/Pickup
	Guns
		MAC11_SubMachine_Gun
			name = "MAC11 Sub-Machine Gun"
			icon = 'MachineGuns.dmi'
			icon_state = "7"
			clip=30
			mclip=30
			maxammo = MAXACPAMMO
			firerate=1
			fire_power=24
			reload_time=26
			accuracy=60
			reload_sound=SOUND_RELOADING_2
			fire_sound=SOUND_SUB_MAC
			ammo_type=".45 ACP Rounds"
			flicker="ShootingMachineL"
			overlay_add='Mac_Sub.dmi'
			sound_wav=55
			at=4
			cost=2270
			clip_level_cost=220
			firerate_level=1
			upgrade_mc=list(1=34,2=36,3=40)
			upgrade_fp=list(1=25,2=26,3=27,4=28,5=29,6=30)
			upgrade_rs=list(1=24,2=22,3=20,4=18,5=14)
			upgrade_fr=list(1=1)
			upgrade_ac=list(1=65,2=70)
			can_upgrade_fr = 0
			ammo_path=/obj/Pickup/Items/Ammo_Light_Machinegun
		AK_74
			name = "AK-74"
			icon = 'MachineGuns.dmi'
			icon_state = "AK74"
			clip=28
			mclip=28
			maxammo = MAXNATOAMMO
			firerate=1
			fire_power=27
			reload_time=24
			accuracy=70
			reload_sound=SOUND_RELOADING_2
			fire_sound=SOUND_M16_1
			ammo_type="5.56mm NatO Rounds"
			flicker="ShootingMachineL"
			overlay_add='AK-47.dmi'
			sound_wav=50
			at=5
			cost=2310
			clip_level_cost=280
			upgrade_mc=list(1=30,2=32,3=36)
			upgrade_fp=list(1=26.5,2=27,3=27.5,4=28,5=29,6=30)
			upgrade_rs=list(1=22,2=20,3=18,4=16,5=14)
			upgrade_fr=list(1=1)
			upgrade_ac=list(1=70)
			accuracy_level=1
			can_upgrade_ac = 0
			can_upgrade_fr = 0
			firerate_level=1
			ammo_path=/obj/Pickup/Items/Ammo_Heavy_Machinegun
		MP5
			name = "MP5"
			icon = 'MachineGuns.dmi'
			icon_state = "MP5"
			clip=25
			mclip=25
			maxammo = MAXACPAMMO
			firerate=1
			fire_power=22
			reload_time=22
			accuracy=80
			reload_sound=SOUND_COCKGUN
			fire_sound=SOUND_MATILDA
			ammo_type=".45 ACP Rounds"
			flicker="ShootingMachineL"
			overlay_add='MP5.dmi'
			sound_wav=50
			duableg=1
			fshoot=1
			at=4
			cost=2200
			clip_level_cost=180
			firerate_level=1
			upgrade_mc=list(1=27,2=29,3=32,4=36)
			upgrade_fp=list(1=23,2=24,3=25,4=26,5=27,6=28)
			upgrade_rs=list(1=20,2=18,3=16,4=14,5=12)
			upgrade_fr=list(1=1)
			upgrade_ac=list(1=85,2=90,3=95)
			accuracy_level=1
			can_upgrade_ac = 0
			can_upgrade_fr = 0
			ammo_path=/obj/Pickup/Items/Ammo_Light_Machinegun
		UMP45
			name = "UMP45"
			icon = 'MachineGuns.dmi'
			icon_state = "UMP45"
			clip=26
			mclip=26
			maxammo = MAXACPAMMO
			firerate=1
			fire_power=22
			reload_time=20
			accuracy=80
			reload_sound=SOUND_UMP45_BOLTPULL
			fire_sound=SOUND_UMP45_1
			ammo_type=".45 ACP Rounds"
			flicker="ShootingMachineL"
			overlay_add='UMP45.dmi'
			sound_wav=50
			duableg=1
			fshoot=1
			at=4
			cost=2205
			clip_level_cost=200
			upgrade_mc=list(1=28,2=30,3=32,4=34)
			upgrade_fp=list(1=23,2=24,3=25,4=26,5=27,6=28)
			upgrade_rs=list(1=18,2=16,3=14,4=12,5=10)
			upgrade_fr=list(1=1)
			upgrade_ac=list(1=80)
			accuracy_level=1
			can_upgrade_ac = 0
			can_upgrade_fr = 0
			firerate_level=1
			ammo_path=/obj/Pickup/Items/Ammo_Light_Machinegun
		Uzi
			name = "Uzi"
			icon = 'MachineGuns.dmi'
			icon_state = "Uzi"
			clip = 42
			mclip = 42
			maxammo = MAXACPAMMO
			firerate = 1
			fire_power = 20
			reload_time = 28
			accuracy=80
			reload_sound = SOUND_UMP45_BOLTPULL
			fire_sound = SOUND_UZI
			ammo_type = ".45 ACP Rounds"
			flicker = "ShootingHandgun"
			overlay_add = 'Uzi.dmi'
			sound_wav = 50
			duableg = 1
			fshoot = 1
			at = 4
			cost = 2200
			clip_level_cost = 500
			firerate_level = 1
			upgrade_mc=list(1=52)
			upgrade_fp=list(1=21,2=22,3=23,4=24,5=25,6=26,7=27)
			upgrade_rs=list(1=26,2=24,3=22,4=20,5=18)
			upgrade_fr=list(1=1)
			upgrade_ac=list(1=80)
			accuracy_level=1
			can_upgrade_ac = 0
			can_upgrade_fr = 0
			ammo_path=/obj/Pickup/Items/Ammo_Light_Machinegun
		skorp
			name = "Skorpion vz. 61 Machine Pistol"
			icon = 'MachineGuns.dmi'
			icon_state = "skorp"
			clip = 10
			mclip = 10
			maxammo = MAXACPAMMO
			firerate = 1
			fire_power = 30
			reload_time = 28
			accuracy=80
			reload_sound = SOUND_UMP45_BOLTPULL
			fire_sound = SOUND_UZI
			ammo_type = ".45 ACP Rounds"
			flicker = "ShootingHandgun"
			overlay_add = 'skorp.dmi'
			sound_wav = 50
			duableg = 1
			fshoot = 1
			at = 4
			cost = 3200
			clip_level_cost = 500
			firerate_level = 1
			upgrade_mc=list(1=20)
			upgrade_fp=list(1=35,2=38,3=40,4=42,5=45,6=47,7=49)
			upgrade_rs=list(1=26,2=24,3=22,4=20,5=18)
			upgrade_fr=list(1=1)
			upgrade_ac=list(1=80)
			accuracy_level=1
			can_upgrade_ac = 0
			can_upgrade_fr = 0
			ammo_path=/obj/Pickup/Items/Ammo_Light_Machinegun
		Ultimax_100_MK4_LMG
			name = "Ultimax 100 MK4 LMG/SAW"
			icon = 'MachineGuns.dmi'
			icon_state = "Ultimax_100"
			clip=30
			mclip=30
			maxammo = MAXNATOAMMO
			firerate=1
			fire_power=23
			reload_time=34
			accuracy=60
			reload_sound=SOUND_RELOADING_3
			fire_sound=SOUND_AK47
			ammo_type="5.56mm NatO Rounds"
			flicker="ShootingMachineH"
			overlay_add='Ultimax100.dmi'
			sound_wav=50
			at=5
			cost=2620
			clip_level_cost=800
			gunpower_level_cost=200
			upgrade_mc=list(1=100)
			upgrade_fp=list(1=24.5,2=25,3=26,4=27,5=28)
			upgrade_rs=list(1=32,2=30,3=26,4=23,5=20)
			upgrade_fr=list(1=1)
			upgrade_ac=list(1=60)
			accuracy_level=1
			can_upgrade_ac = 0
			can_upgrade_fr = 0
			firerate_level=1
			ammo_path=/obj/Pickup/Items/Ammo_Heavy_Machinegun
		M60
			name = "M60"
			icon = 'MachineGuns.dmi'
			icon_state = "M60"
			clip=50
			mclip=50
			maxammo = MAXNATOAMMO
			firerate=1
			fire_power=31
			reload_time=36
			accuracy=60
			reload_sound=SOUND_BOLT_REL
			fire_sound=SOUND_M249_1
			ammo_type="5.56mm NatO Rounds"
			flicker="ShootingMachineH"
			overlay_add='M60.dmi'
			sound_wav=50
			at=5
			cost=2680
			clip_level_cost=500
			gunpower_level_cost=200
			upgrade_mc=list(1=100)
			upgrade_fp=list(1=35,2=37,3=40,4=45,5=48)
			upgrade_rs=list(1=34,2=32,3=28)
			upgrade_fr=list(1=1)
			upgrade_ac=list(1=60)
			accuracy_level=1
			can_upgrade_ac = 0
			can_upgrade_fr = 0
			firerate_level=1
			ammo_path=/obj/Pickup/Items/Ammo_Heavy_Machinegun
		M249
			name = "M-249"
			icon = 'MachineGuns.dmi'
			icon_state = "M249"
			clip=50
			mclip=50
			maxammo = MAXNATOAMMO
			firerate=1
			fire_power=21
			reload_time=36
			accuracy=60
			reload_sound=SOUND_BOLT_REL
			fire_sound=SOUND_M249_1
			ammo_type="5.56mm NatO Rounds"
			flicker="ShootingMachineH"
			overlay_add='M249.dmi'
			sound_wav=50
			at=5
			cost=2680
			clip_level_cost=500
			gunpower_level_cost=200
			upgrade_mc=list(1=100,2=140,3=200)
			upgrade_fp=list(1=22,2=23,3=24.5,4=25,5=26)
			upgrade_rs=list(1=34,2=32,3=28,4=26,5=22)
			upgrade_fr=list(1=1)
			upgrade_ac=list(1=60)
			accuracy_level=1
			can_upgrade_ac = 0
			can_upgrade_fr = 0
			firerate_level=1
			ammo_path=/obj/Pickup/Items/Ammo_Heavy_Machinegun
			verb/Stand()
				set category = null
				set src in usr
				set category = null
				var/mob/player/client/M=usr
				if(!(src in M))return
				if(!M.gamein||M.reloading||GameOver||GameOn == 0||GameOn == 1)return
				if(M.weapon == src)
					if(!M.stand)
						M.stand=1
						src.firerate=0.6
						src.accuracy+=20
						src.reload_time+=50
					else
						M.stand=0
						src.removestand(M)
			proc/removestand(mob/player/client/M)
				M.stand=0
				src.firerate=1
				src.accuracy=60
				src.reload_time=36
				if(src.accuracy_level)
					src.accuracy=src.upgrade_ac[src.accuracy_level]
				if(src.reloadtime_level)
					src.reload_time=src.upgrade_rs[src.reloadtime_level]
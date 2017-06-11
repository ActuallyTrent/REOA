obj/Pickup
	Guns
		Spaz_12
			name = "Spaz 12 Gauge"
			icon = 'Shotguns.dmi'
			icon_state = "Spaz_12"
			clip=8
			mclip=8
			maxammo = MAXSGAMMO
			firerate=14
			fire_power=12
			reload_time=30
			accuracy=100
			reload_sound=SOUND_SHOTGUN_RELOAD
			shell_reload_sound=SOUND_SPAZ_12_RELOAD
			fire_sound=SOUND_SPAZ_12_FIRE
			ammo_path=/obj/Pickup/Items/Ammo_Shotgun
			ammo_type="12 Gauge Shells"
			flicker="ShootingShotgun"
			overlay_add='Spaz12.dmi'
			sound_wav=70
			at=3
			cost=2640
			upgrade_mc=list(1=9,2=10,3=11,4=12,5=14)
			upgrade_fr=list(1=12,2=11,3=10,4=9,5=8)
			upgrade_fp=list(1=13,2=14,3=15,4=16)
			upgrade_rs=list(1=26,2=24,3=23,4=22,5=18)
			upgrade_ac=list(1=100)
			firerate_level_cost=200
			gunpower_level_cost=200
			accuracy_level=1
			can_upgrade_ac=0
			stype = 4
			spread = 1
			verb/Change_Fire()
				set src in usr
				set category = null
				var/mob/player/client/M=usr
				var/list/firel=list("Single-Action"=4,"Double-Action"=5)
				var/answer=firel[input(M,"Change fire to?","Switch")as null|anything in firel]
				if(!answer||!(src in M))return
				src.stype=answer
		Pump_Shotgun
			name = "Pump Shotgun"
			icon = 'Shotguns.dmi'
			icon_state = "PumpShotgun"
			clip=6
			mclip=6
			maxammo = MAXSGAMMO
			firerate=14
			fire_power=14
			reload_time=28
			accuracy=100
			reload_sound=SOUND_PUMP_1
			shell_reload_sound=SOUND_SHELL_IN
			fire_sound=SOUND_M3
			ammo_type="12 Gauge Shells"
			flicker="ShootingShotgun"
			overlay_add='PumpShotgun.dmi'
			sound_wav=60
			at=3
			cost=2663
			gunpower_level_cost=200
			reloadtime_level_cost=200
			upgrade_mc=list(1=8,2=10,3=12)
			upgrade_fr=list(1=13,2=12.5,3=11,4=10)
			upgrade_fp=list(1=15,2=16,3=17,4=18)
			upgrade_rs=list(1=24,2=22,3=20,4=18,5=16)
			upgrade_ac=list(1=100)
			accuracy_level=1
			can_upgrade_ac=0
			ammo_path=/obj/Pickup/Items/Ammo_Shotgun
			stype = 4
			spread = 1
		roit
			name = "Riot Shotgun"
			icon = 'Shotguns.dmi'
			icon_state = "roit"
			clip=7
			mclip=7
			maxammo = MAXSGAMMO
			firerate=14
			fire_power=14
			reload_time=28
			accuracy=100
			reload_sound=SOUND_PUMP_1
			shell_reload_sound=SOUND_SHELL_IN
			fire_sound=SOUND_M3
			ammo_type="12 Gauge Shells"
			flicker="ShootingShotgun"
			overlay_add='PumpShotgun.dmi'
			sound_wav=60
			at=3
			cost=2663
			gunpower_level_cost=200
			reloadtime_level_cost=200
			upgrade_mc=list(1=9,2=13,3=15)
			upgrade_fr=list(1=13,2=12.5,3=11,4=10)
			upgrade_fp=list(1=15,2=16,3=17,4=20)
			upgrade_rs=list(1=24,2=22,3=20,4=18)
			upgrade_ac=list(1=100)
			accuracy_level=1
			can_upgrade_ac=0
			ammo_path=/obj/Pickup/Items/Ammo_Shotgun
			stype = 4
			spread = 1
		Tatshot
			name = "Tactical Shotgun"
			icon = 'Shotguns.dmi'
			icon_state = "tatshot"
			clip=3
			mclip=3
			maxammo = MAXSGAMMO
			firerate=20
			fire_power=20
			reload_time=28
			accuracy=100
			reload_sound=SOUND_PUMP_1
			shell_reload_sound=SOUND_SHELL_IN
			fire_sound=SOUND_M3
			ammo_type="12 Gauge Shells"
			flicker="ShootingShotgun"
			overlay_add='TacticalShotgun.dmi'
			sound_wav=60
			at=3
			cost=4663
			gunpower_level_cost=200
			reloadtime_level_cost=200
			upgrade_mc=list(1=5)
			upgrade_fr=list(1=13,2=12.5,3=11,4=10)
			upgrade_fp=list(1=23,2=25)
			upgrade_rs=list(1=24,2=22,3=20,4=18,5=16)
			upgrade_ac=list(1=100)
			accuracy_level=1
			can_upgrade_ac=0
			ammo_path=/obj/Pickup/Items/Ammo_Shotgun
			stype = 4
			spread = 2
			verb/Change_Fire()
				set src in usr
				set category = null
				var/mob/player/client/M=usr
				var/list/firel=list("Single-Action"=4,"Double-Action"=5)
				var/answer=firel[input(M,"Change fire to?","Switch")as null|anything in firel]
				if(!answer||!(src in M))return
				src.stype=answer
		moss
			name = "Mossberg 500"
			icon = 'Shotguns.dmi'
			icon_state = "moss"
			clip=4
			mclip=4
			maxammo = MAXSGAMMO
			firerate=14
			fire_power=14
			reload_time=24
			accuracy=100
			reload_sound=SOUND_PUMP_1
			shell_reload_sound=SOUND_SHELL_IN
			fire_sound=SOUND_M3
			ammo_type="12 Gauge Shells"
			flicker="ShootingShotgun"
			overlay_add='MossShotgun.dmi'
			sound_wav=60
			at=3
			cost=2663
			gunpower_level_cost=200
			reloadtime_level_cost=200
			upgrade_mc=list(1=6)
			upgrade_fr=list(1=13,2=12.5,3=11,4=10)
			upgrade_fp=list(1=15,2=16,3=17,4=18)
			upgrade_rs=list(1=22,2=16)
			upgrade_ac=list(1=100)
			accuracy_level=1
			can_upgrade_ac=0
			ammo_path=/obj/Pickup/Items/Ammo_Shotgun
			stype = 4
			spread = 1
		Sawnoff
			name = "Sawnoff"
			icon = 'Shotguns.dmi'
			icon_state = "Sawnoff"
			clip=2
			mclip=2
			maxammo=MAXSGAMMO
			firerate=11
			fire_power=12
			reload_time=20
			accuracy=100
			reload_sound=SOUND_SAWNOFF_RELOAD
			shell_reload_sound=SOUND_SHELL_IN
			fire_sound=SOUND_SAWNOFF_FIRE
			ammo_type="12 Gauge Shells"
			flicker="ShootingHandgun"
			overlay_add='Sawnoff.dmi'
			sound_wav=60
			at=3
			cost=2560
			gunpower_level_cost=200
			reloadtime_level_cost=200
			firerate_level_cost=200
			can_upgrade_cc=0
			clip_level=1
			upgrade_mc=list(1=2)
			upgrade_fr=list(1=10,2=9.5,3=8)
			upgrade_fp=list(1=13,2=14,3=15,4=16,5=17)
			upgrade_rs=list(1=18,2=17,3=16,4=14,5=12)
			upgrade_ac=list(1=100)
			accuracy_level=1
			can_upgrade_ac=0
			ammo_path=/obj/Pickup/Items/Ammo_Shotgun
			duableg=1
			stype = 4
			spread = 1
		Vulture_Assault_Shotgun
			name = "Vulture Assault Shotgun"
			icon = 'Shotguns.dmi'
			icon_state = "Vas"
			clip=10
			mclip=10
			maxammo = MAXSGAMMO
			firerate=10
			fire_power=16
			reload_time=55
			accuracy=100
			reload_sound=SOUND_PUMP_1
			shell_reload_sound=SOUND_SHELL_IN
			fire_sound=SOUND_SAWNOFF_FIRE
			ammo_type="12 Gauge Shells"
			flicker="ShootingShotgun"
			overlay_add='VultureShotgun.dmi'
			sound_wav=60
			at=3
			cost=8000
			gunpower_level_cost=200
			reloadtime_level_cost=200
			upgrade_mc=list(1=15)
			upgrade_fr=list(1=9,2=8,3=7)
			upgrade_fp=list(1=20)
			upgrade_rs=list(1=50)
			upgrade_ac=list(1=100)
			accuracy_level=1
			can_upgrade_ac=0
			ammo_path=/obj/Pickup/Items/Ammo_Shotgun
			stype = 4
			spread = 1
			clip_round = 1
		JackHammer_Assault_Shotgun
			name = "JackHammer Assualt Shotgun"
			icon = 'Shotguns.dmi'
			icon_state = "Jhas"
			clip=13
			mclip=13
			maxammo = MAXSGAMMO
			firerate=13
			fire_power=10
			reload_time=35
			accuracy=100
			reload_sound=SOUND_PUMP_1
			shell_reload_sound=SOUND_SHELL_IN
			fire_sound=SOUND_SAWNOFF_FIRE
			ammo_type="12 Gauge Shells"
			flicker="ShootingShotgun"
			overlay_add='JackShotgun.dmi'
			sound_wav=60
			at=3
			cost=8000
			gunpower_level_cost=200
			reloadtime_level_cost=200
			upgrade_mc=list(1=20)
			upgrade_fr=list(1=12,2=11,3=10)
			upgrade_fp=list(1=12)
			upgrade_rs=list(1=30)
			upgrade_ac=list(1=100)
			accuracy_level=1
			can_upgrade_ac=0
			ammo_path=/obj/Pickup/Items/Ammo_Shotgun
			stype = 4
			spread = 1
			clip_round = 1
		Striker
			name = "Striker"
			icon = 'Shotguns.dmi'
			icon_state = "Striker"
			clip=25
			mclip=25
			maxammo = MAXSGAMMO
			firerate=13
			fire_power=10
			reload_time=70
			accuracy=100
			reload_sound=SOUND_PUMP_1
			shell_reload_sound=SOUND_SHELL_IN
			fire_sound=SOUND_SAWNOFF_FIRE
			ammo_type="12 Gauge Shells"
			flicker="ShootingShotgun"
			overlay_add='StrikerShotgun.dmi'
			sound_wav=60
			at=3
			cost=8000
			gunpower_level_cost=200
			reloadtime_level_cost=200
			upgrade_mc=list(1=30)
			upgrade_fr=list(1=12,2=11,3=10)
			upgrade_fp=list(1=11,2=12,3=13,4=15)
			upgrade_rs=list(1=65)
			upgrade_ac=list(1=100)
			accuracy_level=1
			can_upgrade_ac=0
			ammo_path=/obj/Pickup/Items/Ammo_Shotgun
			stype = 4
			spread = 1
			clip_round = 1
			verb/Change_Fire()
				set src in usr
				set category = null
				var/mob/player/client/M=usr
				var/list/firel=list("Single-Action"=4,"Double-Action"=5)
				var/answer=firel[input(M,"Change fire to?","Switch")as null|anything in firel]
				if(!answer||!(src in M))return
				src.stype=answer
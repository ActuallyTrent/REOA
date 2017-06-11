obj/Pickup
	Guns
		Flame_Thrower
			name = "Flame Round Thrower"
			icon_state = "FlameThrower"
			icon = 'Others.dmi'
			clip = 50
			mclip = 50
			maxammo = MAXROCKETAMMO
			firerate = 5
			fire_power = 0
			reload_time = 1000
			accuracy = 100
			reload_sound = SOUND_RELOADING_2
			fire_sound = SOUND_ROCKET
			ammo_path = null
			ammo_type = "None"
			flicker = "ShootingHandgun"
			overlay_add = 'RocketLauncher.dmi'
			sound_wav = 65
			at = 7
			cost = 7000
			is_discard = 1
			can_upgrade_ac = 0
			can_upgrade_fr = 0
			can_upgrade_rs = 0
			can_upgrade_fp = 0
			firerate_level = 1
			gunpower_level = 1
			reloadtime_level = 1
			accuracy_level=1
			upgrade_mc = list(1=100)
			upgrade_fr = list(1=5)
			upgrade_fp = list(1=0)
			upgrade_rs = list(1=1000)
			upgrade_ac = list(1=100)
			projectile = /obj/projectiles/flame
		Ice_Thrower
			name = "Ice Round Thrower"
			icon_state = "IceThrower"
			icon = 'Others.dmi'
			clip = 50
			mclip = 50
			maxammo = MAXROCKETAMMO
			firerate = 5
			fire_power = 0
			reload_time = 1000
			accuracy = 100
			reload_sound = SOUND_RELOADING_2
			fire_sound = SOUND_ROCKET
			ammo_path = null
			ammo_type = "None"
			flicker = "ShootingHandgun"
			overlay_add = 'RocketLauncher.dmi'
			sound_wav = 65
			at = 7
			cost = 7000
			is_discard = 1
			can_upgrade_ac = 0
			can_upgrade_fr = 0
			can_upgrade_rs = 0
			can_upgrade_fp = 0
			firerate_level = 1
			gunpower_level = 1
			reloadtime_level = 1
			accuracy_level=1
			upgrade_mc = list(1=100)
			upgrade_fr = list(1=5)
			upgrade_fp = list(1=0)
			upgrade_rs = list(1=1000)
			upgrade_ac = list(1=100)
			projectile = /obj/projectiles/freeze
		Acid_Thrower
			name = "Acid Round Thrower"
			icon_state = "AcidThrower"
			icon = 'Others.dmi'
			clip = 50
			mclip = 50
			maxammo = MAXROCKETAMMO
			firerate = 5
			fire_power = 0
			reload_time = 1000
			accuracy = 100
			reload_sound = SOUND_RELOADING_2
			fire_sound = SOUND_ROCKET
			ammo_path = null
			ammo_type = "None"
			flicker = "ShootingHandgun"
			overlay_add = 'RocketLauncher.dmi'
			sound_wav = 65
			at = 7
			cost = 7000
			is_discard = 1
			can_upgrade_ac = 0
			can_upgrade_fr = 0
			can_upgrade_rs = 0
			can_upgrade_fp = 0
			firerate_level = 1
			gunpower_level = 1
			reloadtime_level = 1
			accuracy_level=1
			upgrade_mc = list(1=100)
			upgrade_fr = list(1=5)
			upgrade_fp = list(1=0)
			upgrade_rs = list(1=1000)
			upgrade_ac = list(1=100)
			projectile = /obj/projectiles/acid
		Minigun
			name = "Minigun"
			icon = 'Others.dmi'
			icon_state = "Minigun"
			clip=200
			mclip=200
			maxammo = MAXNATOAMMO
			firerate=1
			fire_power=30
			reload_time=60
			accuracy=50
			reload_sound=SOUND_RELOADING_3
			fire_sound=SOUND_SUB_MAC
			ammo_type="5.56mm NatO Rounds"
			flicker="ShootingShotgun"
			overlay_add='minigun.dmi'
			sound_wav=50
			at=5
			cost=10000
			clip_level_cost=800
			gunpower_level_cost=500
			upgrade_mc=list(1=400)
			upgrade_fp=list(1=33,2=36,3=39,4=42,5=50,6=75)
			upgrade_rs=list(1=59,2=58,3=57,4=56,5=55)
			upgrade_fr=list(1=0.5,2=0.1)
			upgrade_ac=list(1=60)
			ammo_path=/obj/Pickup/Items/Ammo_Heavy_Machinegun
		Rocket_Launcher
			name = "Rocket Launcher"
			icon_state = "RL"
			icon = 'Launchers.dmi'
			clip = 2
			mclip = 2
			maxammo = MAXROCKETAMMO
			firerate = 12
			fire_power = 0
			reload_time = 38
			accuracy = 100
			reload_sound = SOUND_RELOADING_2
			fire_sound = SOUND_ROCKET
			ammo_path = null
			ammo_type = "Rockets"
			flicker = "ShootingHandgun"
			overlay_add = 'RocketLauncher.dmi'
			sound_wav = 65
			at = 7
			cost = 5900
			is_discard = 1
			can_upgrade_ac = 0
			can_upgrade_fr = 0
			can_upgrade_rs = 0
			can_upgrade_fp = 0
			can_upgrade_cc = 0
			clip_level = 1
			firerate_level = 1
			gunpower_level = 1
			reloadtime_level = 1
			accuracy_level=1
			upgrade_mc = list(1=2)
			upgrade_fr = list(1=12)
			upgrade_fp = list(1=0)
			upgrade_rs = list(1=38)
			upgrade_ac = list(1=100)
			projectile = /obj/projectiles/rocket
		FlameThrower
			name = "Flame Thrower"
			icon_state = "fthrower"
			icon = 'Others.dmi'
			clip = 100
			mclip = 100
			maxammo = MAXFLAME
			firerate = 1
			fire_power = 0
			reload_time = 50
			accuracy = 100
			reload_sound = SOUND_RELOADING_2
			fire_sound = SOUND_ROCKET
			ammo_path = /obj/Pickup/Items/Ammo_FlameT
			ammo_type = "Propane"
			flicker = "ShootingShotgun"
			overlay_add = 'Flamethrower.dmi'
			sound_wav = 65
			at = 7
			cost = 45000
			is_discard = 1
			can_upgrade_ac = 0
			can_upgrade_fr = 0
			can_upgrade_rs = 0
			can_upgrade_fp = 0
			can_upgrade_cc = 0
			clip_level = 1
			firerate_level = 1
			gunpower_level = 1
			reloadtime_level = 1
			accuracy_level=1
			upgrade_mc = list(1=100)
			upgrade_fr = list(1=1)
			upgrade_fp = list(1=0)
			upgrade_rs = list(1=50)
			upgrade_ac = list(1=100)
			laser = /obj/projectiles/fire
			laserlength = 5
		Tarantula
			name = "Tarantula laser chaingun"
			icon_state = "laser"
			icon = 'Others.dmi'
			clip = 100
			mclip = 100
			maxammo = MAXROCKETAMMO
			firerate = 1
			fire_power = 0
			reload_time = 1
			accuracy = 100
			reload_sound = SOUND_RELOADING_2
			fire_sound = SOUND_ROCKET
			ammo_path = null
			ammo_type = "None"
			flicker = "ShootingMachineL"
			overlay_add = 'Protecta.dmi'
			sound_wav = 65
			at = 7
			cost = 60000
			is_discard = 1
			can_upgrade_ac = 0
			can_upgrade_fr = 0
			can_upgrade_rs = 0
			can_upgrade_fp = 0
			can_upgrade_cc = 0
			clip_level = 1
			firerate_level = 1
			gunpower_level = 1
			reloadtime_level = 1
			accuracy_level=1
			upgrade_mc = list(1=100)
			upgrade_fr = list(1=1)
			upgrade_fp = list(1=0)
			upgrade_rs = list(1=1)
			upgrade_ac = list(1=100)
			laser = /obj/projectiles/Laser
			laserlength = 25
		firefly
			name = "Firefly laser rifle"
			icon_state = "FF"
			icon = 'Others.dmi'
			clip = 10
			mclip = 10
			maxammo = MAXROCKETAMMO
			firerate = 10
			fire_power = 0
			reload_time = 1
			accuracy = 100
			reload_sound = SOUND_RELOADING_2
			fire_sound = SOUND_ROCKET
			ammo_path = null
			ammo_type = "None"
			flicker = "ShootingMachineL"
			overlay_add = 'Protecta.dmi'
			sound_wav = 65
			at = 7
			cost = 40000
			is_discard = 1
			can_upgrade_ac = 0
			can_upgrade_fr = 0
			can_upgrade_rs = 0
			can_upgrade_fp = 0
			firerate_level = 1
			gunpower_level = 1
			reloadtime_level = 1
			accuracy_level=1
			upgrade_mc = list(1=20,2=30,3=40,4=50)
			upgrade_fr = list(1=10)
			upgrade_fp = list(1=0)
			upgrade_rs = list(1=1)
			upgrade_ac = list(1=100)
			laser = /obj/projectiles/Laser
			laserlength = 50
		Grenade_Launcher
			name = "Grenade Launcher"
			icon_state = "Grenade Launcher"
			icon = 'Launchers.dmi'
			clip = 2
			mclip = 6
			maxammo = MAXNADEAMMO
			firerate = 16
			fire_power = 0
			reload_time = 28
			accuracy = 100
			reload_sound = SOUND_RELOADING_2
			fire_sound = SOUND_GLAUNCHER
			ammo_path = null
			ammo_type = "Explosive/Acid/Flame/Freeze Rounds"
			flicker = "ShootingShotgun"
			overlay_add = 'GrenadeLauncher.dmi'
			sound_wav = 65
			at = 7
			cost = 5200
			is_discard = 1
			can_upgrade_ac = 0
			can_upgrade_fr = 0
			can_upgrade_rs = 0
			can_upgrade_fp = 0
			can_upgrade_cc = 0
			clip_level = 1
			firerate_level = 1
			gunpower_level = 1
			reloadtime_level = 1
			accuracy_level=1
			upgrade_mc = list(1=6)
			upgrade_fr = list(1=16)
			upgrade_fp = list(1=0)
			upgrade_rs = list(1=28)
			upgrade_ac = list(1=100)
			projectile = /obj/projectiles/explosive
			grenade_launcher = 1
			verb
				Change_Ammo()
					set category = "Commands"
					set src in usr
					set category = null
					var/mob/player/client/M=usr
					if(!(src in M))return
					if(!M.gamein||M.reloading||GameOver)return
					src.identify_ammo(M,1)
					var/list/sammo = list("Flame\[[M.ammo["Flame Rounds"]]]" = /obj/projectiles/flame, "Acid\[[M.ammo["Acid Rounds"]]]" = /obj/projectiles/acid, "Freeze\[[M.ammo["Freeze Rounds"]]]" = /obj/projectiles/freeze, "Explosive\[[M.ammo["Explosive Rounds"]]]" = /obj/projectiles/explosive)
					var/answer = sammo[input(M,"Change ammo type to?","Change Ammo")as null|anything in sammo]
					if(!answer||!(src in M))return
					src.projectile = answer
					src.identify_ammo(M)
					if(M.weapon && M.weapon == src)
						src.suffix="[src.clip]/[src.mclip]"
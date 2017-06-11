obj/Pickup
	Guns
		Glock_18
			name = "Glock 18"
			icon_state = "Glock 18"
			icon = 'Handguns.dmi'
			clip=15
			mclip=15
			maxammo = MAXLHAMMO
			firerate=8
			fire_power=27
			reload_time=18
			accuracy=90
			reload_sound=SOUND_M92F_CUSTOM_HANDGUN_RELOAD
			fire_sound=SOUND_GLOCK18_FIRE
			ammo_path=/obj/Pickup/Items/Ammo_Light_Handgun
			ammo_type="9mm Parabellum Rounds"
			flicker="ShootingHandgun"
			overlay_add='Glock18.dmi'
			sound_wav=65
			duableg=1
			at=1
			cost=2200
			clip_level_cost=300
			upgrade_mc=list(1=17,2=19,3=31,4=33)
			upgrade_fr=list(1=7.5,2=7,3=6.5,4=6,5=5)
			upgrade_fp=list(1=28,2=29,3=30,4=31,5=32,6=33,7=34)
			upgrade_rs=list(1=17,2=16,3=15.5,4=14,5=10)
			upgrade_ac=list(1=95)
			verb/Change_Fire()
				set src in usr
				set category = null
				var/mob/player/client/M=usr
				if(src.mclip<=30){M<<"You need a extended clip of '30'.";return}
				var/list/firel=list("Single Shot"=3,"3-Burst Shot"=2)
				var/answer=firel[input(M,"Change fire to?","Switch")as null|anything in firel]
				if(!answer)return
				if(!(src in M))return
				src.stype=answer
		GDI_Handgun
			name = "GDI Handgun"
			icon_state = "Handgun_G"
			icon = 'Handguns.dmi'
			clip=10
			mclip=10
			maxammo = MAXLHAMMO
			firerate=8
			fire_power=35
			reload_time=18
			accuracy=95
			reload_sound=SOUND_M92F_CUSTOM_HANDGUN_RELOAD
			fire_sound=SOUND_GLOCK18_FIRE
			ammo_path=/obj/Pickup/Items/Ammo_Light_Handgun
			ammo_type="9mm Parabellum Rounds"
			flicker="ShootingHandgun"
			overlay_add='gd.dmi'
			sound_wav=65
			duableg=1
			at=1
			cost=2200
			clip_level_cost=300
			upgrade_mc=list(1=12)
			upgrade_fr=list(1=7.5)
			upgrade_fp=list(1=50)
			upgrade_rs=list(1=15)
			upgrade_ac=list(1=97,2=99)
		Nod_Handgun
			name = "Nod Handgun"
			icon_state = "Handgun_N"
			icon = 'Handguns.dmi'
			clip=30
			mclip=30
			maxammo = MAXLHAMMO
			firerate=4
			fire_power=27
			reload_time=18
			accuracy=90
			reload_sound=SOUND_M92F_CUSTOM_HANDGUN_RELOAD
			fire_sound=SOUND_GLOCK18_FIRE
			ammo_path=/obj/Pickup/Items/Ammo_Light_Handgun
			ammo_type="9mm Parabellum Rounds"
			flicker="ShootingHandgun"
			overlay_add='Nodde.dmi'
			sound_wav=65
			duableg=1
			at=1
			cost=2200
			clip_level_cost=300
			upgrade_mc=list(1=38)
			upgrade_fr=list(1=2)
			upgrade_fp=list(1=34)
			upgrade_rs=list(1=10)
			upgrade_ac=list(1=95)
			verb/Change_Fire()
				set src in usr
				set category = null
				var/mob/player/client/M=usr
				if(src.mclip<=30){M<<"You need a extended clip of '30'.";return}
				var/list/firel=list("Single Shot"=3,"3-Burst Shot"=2)
				var/answer=firel[input(M,"Change fire to?","Switch")as null|anything in firel]
				if(!answer)return
				if(!(src in M))return
				src.stype=answer
		M92F_Custom_Handgun
			name = "M92F Custom Handgun"
			icon = 'Handguns.dmi'
			icon_state = "M92F Custom Handgun"
			clip=8
			mclip=8
			maxammo = MAXLHAMMO
			firerate=7.50
			fire_power=30
			reload_time=13
			accuracy=90
			reload_sound=SOUND_M92F_CUSTOM_HANDGUN_RELOAD
			fire_sound=SOUND_M92F_CUSTOM_HANDGUN_FIRE
			ammo_path=/obj/Pickup/Items/Ammo_Light_Handgun
			ammo_type="9mm Parabellum Rounds"
			flicker="ShootingHandgun"
			overlay_add='CustomH.dmi'
			sound_wav=60
			duableg=1
			at=1
			cost=1845
			upgrade_mc=list(1=10,2=12,3=14,4=16)
			upgrade_fr=list(1=7,2=6.5,3=6,4=5.5,5=4.6)
			upgrade_fp=list(1=31,2=32,3=33,4=34,5=35,6=36)
			upgrade_rs=list(1=11,2=9.5,3=8.5,4=7)
			upgrade_ac=list(1=95)
		VP07
			name = "VP07"
			icon = 'Handguns.dmi'
			icon_state = "VP07"
			clip=10
			mclip=10
			maxammo = MAXLHAMMO
			firerate=9.50
			fire_power=28
			reload_time=14
			accuracy=90
			reload_sound=SOUND_M92F_CUSTOM_HANDGUN_RELOAD
			fire_sound=SOUND_M92F_CUSTOM_HANDGUN_FIRE
			ammo_path=/obj/Pickup/Items/Ammo_Light_Handgun
			ammo_type="9mm Parabellum Rounds"
			flicker="ShootingHandgun"
			overlay_add='VP07.dmi'
			sound_wav=60
			duableg=1
			at=1
			cost=1858
			upgrade_mc=list(1=12,2=14,3=16,4=18,5=20)
			upgrade_fr=list(1=8,2=7.5,3=7,4=6.5,5=6)
			upgrade_fp=list(1=29,2=30,3=31,4=32,5=33,6=34)
			upgrade_rs=list(1=13,2=12,3=11.5,4=10,5=8)
			upgrade_ac=list(1=95)
		Magnum
			name = "Desert Eagle 5.0AE"
			icon = 'Handguns.dmi'
			icon_state = "Mag"
			clip=7
			mclip=7
			maxammo = MAXHHAMMO
			clip_level=1
			gunpower_level_cost=200
			firerate=14
			fire_power=175
			reload_time=34
			accuracy=80
			reload_sound=SOUND_RELOADING_2
			fire_sound=SOUND_DESERT_EAGLE
			ammo_path=/obj/Pickup/Items/Ammo_Heavy_Handgun
			ammo_type=".357 Magnum Rounds"
			flicker="ShootingHandgun"
			overlay_add='DEagle.dmi'
			sound_wav=50
			at=2
			stype=3
			cost=2653
			upgrade_mc=list(1=7)
			upgrade_fr=list(1=13,2=12,3=11,4=10,5=8)
			upgrade_fp=list(1=185,2=190,3=200,4=210,5=220)
			upgrade_rs=list(1=32,2=26,3=24,4=20,5=18)
			upgrade_ac=list(1=85)
			can_upgrade_cc = 0
		MagnumN
			name = "Commando Elite Magnum (N)"
			icon = 'Handguns.dmi'
			icon_state = "NodMag"
			clip=7
			mclip=7
			maxammo = MAXHHAMMO
			clip_level=1
			gunpower_level_cost=200
			firerate=14
			fire_power=175
			reload_time=34
			accuracy=80
			reload_sound=SOUND_RELOADING_2
			fire_sound=SOUND_DESERT_EAGLE
			ammo_path=/obj/Pickup/Items/Ammo_Heavy_Handgun
			ammo_type=".357 Magnum Rounds"
			flicker="ShootingHandgun"
			overlay_add='HandgunN.dmi'
			sound_wav=50
			at=2
			stype=3
			cost=5000
			upgrade_mc=list(1=7)
			upgrade_fr=list(1=5)
			upgrade_fp=list(1=250)
			upgrade_rs=list(1=18)
			upgrade_ac=list(1=85)
			can_upgrade_cc = 0
		MagnumG
			name = "Commando Elite Magnum (G)"
			icon = 'Handguns.dmi'
			icon_state = "GDIMag"
			clip=7
			mclip=7
			maxammo = MAXHHAMMO
			clip_level=1
			gunpower_level_cost=200
			firerate=14
			fire_power=175
			reload_time=34
			accuracy=80
			reload_sound=SOUND_RELOADING_2
			fire_sound=SOUND_DESERT_EAGLE
			ammo_path=/obj/Pickup/Items/Ammo_Heavy_Handgun
			ammo_type=".357 Magnum Rounds"
			flicker="ShootingHandgun"
			overlay_add='GDIde.dmi'
			sound_wav=50
			at=2
			stype=3
			cost=5000
			upgrade_mc=list(1=10)
			upgrade_fr=list(1=8)
			upgrade_fp=list(1=250)
			upgrade_rs=list(1=18)
			upgrade_ac=list(1=85)
			can_upgrade_cc = 0
		m357
			name = ".357 Magnum"
			icon = 'Handguns.dmi'
			icon_state = "357"
			clip=12
			mclip=12
			maxammo = MAXHHAMMO
			clip_level=1
			gunpower_level_cost=200
			firerate=14
			fire_power=175
			reload_time=34
			accuracy=60
			reload_sound=SOUND_RELOADING_2
			fire_sound=SOUND_DESERT_EAGLE
			ammo_path=/obj/Pickup/Items/Ammo_Heavy_Handgun
			ammo_type=".357 Magnum Rounds"
			flicker="ShootingHandgun"
			overlay_add='DEagle.dmi'
			sound_wav=50
			at=2
			stype=3
			cost=4500
			upgrade_mc=list(1=12)
			upgrade_fr=list(1=13,2=12,3=11,4=10,5=8)
			upgrade_fp=list(1=185,2=190,3=200,4=210,5=230)
			upgrade_rs=list(1=32,2=26,3=24,4=20,5=18)
			upgrade_ac=list(1=60)
			can_upgrade_cc = 0
			can_upgrade_ac = 0
		ScorpP
			name = "Scorpion Pistol"
			icon = 'Handguns.dmi'
			icon_state = "ScorpP"
			clip=20
			mclip=20
			maxammo = MAXHHAMMO
			clip_level=1
			gunpower_level_cost=200
			firerate=8
			fire_power=100
			reload_time=34
			accuracy=60
			reload_sound=SOUND_RELOADING_2
			fire_sound=SOUND_DESERT_EAGLE
			shell_reload_sound=SOUND_SPAZ_12_RELOAD
			ammo_path=/obj/Pickup/Items/Ammo_Heavy_Handgun
			ammo_type=".357 Magnum Rounds"
			flicker="ShootingHandgun"
			overlay_add='VP07.dmi'
			sound_wav=50
			at=2
			stype=3
			cost=20000
			upgrade_mc=list(1=20)
			upgrade_fr=list(1=5)
			upgrade_fp=list(1=115)
			upgrade_rs=list(1=18)
			upgrade_ac=list(1=80)
			can_upgrade_cc = 0
			can_upgrade_ac = 0
			verb/Change_Fire()
				set category = null
				set src in usr
				set category = null
				var/mob/player/client/M=usr
				if(!(src in M))return
				if(!M.gamein||M.reloading||GameOver||GameOn == 0||GameOn == 1)return
				if(M.weapon == src)
					var/i=input(usr,"?","?")as null|anything in list("Shotgun","Handgun")
					if(i)
						if(i=="Shotgun")
							src.spread = 1
						else
							src.spread = 0
		Preymant
			name = "Preying Mantis Assult Pistol"
			icon = 'Handguns.dmi'
			icon_state = "Mantispis"
			clip=15
			mclip=15
			maxammo = MAXHHAMMO
			clip_level=1
			gunpower_level_cost=200
			firerate=8
			fire_power=100
			reload_time=34
			accuracy=1000
			reload_sound=SOUND_RELOADING_2
			fire_sound=SOUND_DESERT_EAGLE
			shell_reload_sound=SOUND_SPAZ_12_RELOAD
			ammo_path=/obj/Pickup/Items/Ammo_Heavy_Handgun
			ammo_type=".357 Magnum Rounds"
			flicker="ShootingHandgun"
			overlay_add='BHp.dmi'
			sound_wav=50
			at=2
			stype=3
			cost=20000
			upgrade_mc=list(1=15)
			upgrade_fr=list(1=5)
			upgrade_fp=list(1=115)
			upgrade_rs=list(1=18)
			upgrade_ac=list(1=1000)
			can_upgrade_cc = 0
			can_upgrade_ac = 0
			verb/Change_Fire()
				set category = null
				set src in usr
				set category = null
				var/mob/player/client/M=usr
				if(!(src in M))return
				if(!M.gamein||M.reloading||GameOver||GameOn == 0||GameOn == 1)return
				if(M.weapon == src)
					var/i=input(usr,"?","?")as null|anything in list("Shotgun","Handgun")
					if(i)
						if(i=="Shotgun")
							src.spread = 1
						else
							src.spread = 0

		Flacon
			name = "GDI Falcon Auto HandCannon"
			icon = 'Handguns.dmi'
			icon_state = "Falcon"
			clip=5
			mclip=5
			maxammo = MAXHHAMMO
			clip_level=1
			gunpower_level_cost=200
			firerate=50
			fire_power=175
			reload_time=34
			accuracy=30
			reload_sound=SOUND_RELOADING_2
			fire_sound=SOUND_DESERT_EAGLE
			shell_reload_sound=SOUND_SPAZ_12_RELOAD
			fire_sound=SOUND_SPAZ_12_FIRE
			ammo_path=/obj/Pickup/Items/Ammo_Heavy_Handgun
			ammo_type=".357 Magnum Rounds"
			flicker="ShootingHandgun"
			overlay_add='GDIde.dmi'
			sound_wav=50
			at=2
			stype=3
			cost=70000
			upgrade_mc=list(1=5)
			upgrade_fr=list(1=40)
			upgrade_fp=list(1=1300)
			upgrade_rs=list(1=10)
			upgrade_ac=list(1=30)
			can_upgrade_cc = 0
			can_upgrade_ac = 0
			verb/Change_Fire()
				set category = null
				set src in usr
				set category = null
				var/mob/player/client/M=usr
				if(!(src in M))return
				if(!M.gamein||M.reloading||GameOver||GameOn == 0||GameOn == 1)return
				if(M.weapon == src)
					var/i=input(usr,"?","?")as null|anything in list("Shotgun","Handgun")
					if(i)
						if(i=="Shotgun")
							src.spread = 1
						else
							src.spread = 0


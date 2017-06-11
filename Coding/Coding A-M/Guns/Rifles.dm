obj/Pickup
	Guns
		AK_47
			name = "AK-47"
			icon = 'Rifles.dmi'
			icon_state = "AKA"
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
		Assualt_Rifle
			name = "Assault Rifle"
			icon = 'Rifles.dmi'
			icon_state = "Assault Rifle"
			clip=32
			mclip=32
			cancombine = 1
			maxammo = MAXNATOAMMO
			firerate=1
			fire_power=26
			reload_time=28
			accuracy=70
			reload_sound=SOUND_UMP45_BOLTPULL
			fire_sound=SOUND_ASSULT_RIFLE_FIRE
			ammo_type="5.56mm NatO Rounds"
			flicker="ShootingMachineH"
			overlay_add='AssualtRifle.dmi'
			sound_wav=75
			at=5
			cost=2320
			clip_level_cost=280
			upgrade_mc=list(1=34,2=36,3=38)
			upgrade_fp=list(1=25.5,2=26,3=26.5,4=27,5=28,6=29,7=30,8=31)
			upgrade_rs=list(1=26,2=25,3=23,4=21,5=18)
			upgrade_fr=list(1=1)
			upgrade_ac=list(1=70)
			accuracy_level=1
			can_upgrade_ac = 0
			can_upgrade_fr = 0
			firerate_level=1
			ammo_path=/obj/Pickup/Items/Ammo_Heavy_Machinegun
			verb/Change_Fire()
				set src in usr
				set category = null
				var/mob/player/client/M=usr
				var/list/firel=list("Single Shot"=1,"3-Burst Shot"=2,"Full-Auto"=3)
				if(src.combined)
					firel+="Grenade Launcher"
					firel["Grenade Launcher"]="GL"
				var/answer=firel[input(M,"Change fire to?","Switch")as null|anything in firel]
				if(!answer||!(src in M))return
				if(isnum(answer))
					if(src.projectile)
						src.removegl(src.clip,src.mclip,src.maxammo,src.ammo_type,M)
					src.stype=answer
				else if(answer=="GL")
					if(!M.gamein||M.reloading||GameOver||GameOn == 0||GameOn == 1)return
					src.addgl(src.clip,src.mclip,src.maxammo,src.ammo_type,50,50,M)
		AK_Carbine
			name = "AK47 with Gp30"
			icon = 'Rifles.dmi'
			icon_state = "AKGL"
			clip=30
			mclip=30
			maxammo = MAXNATOAMMO
			firerate=1
			fire_power=26
			reload_time=26
			accuracy=70
			cancombine = 1
			reload_sound=SOUND_UMP45_BOLTPULL
			fire_sound=SOUND_M4A1_FIRE
			ammo_type="5.56mm NatO Rounds"
			flicker="ShootingMachineH"
			overlay_add='AK-47.dmi'
			sound_wav=55
			at=5
			cost=2315
			clip_level_cost=260
			upgrade_mc=list(1=32,2=34,3=36)
			upgrade_fp=list(1=26.5,2=27,3=27.5,4=28,5=29,6=31)
			upgrade_rs=list(1=24,2=23,3=21,4=20,5=16)
			upgrade_fr=list(1=1)
			upgrade_ac=list(1=70)
			accuracy_level=1
			can_upgrade_ac = 0
			can_upgrade_fr = 0
			firerate_level=1
			ammo_path=/obj/Pickup/Items/Ammo_Heavy_Machinegun
			verb/Change_Fire()
				set src in usr
				set category = null
				var/mob/player/client/M=usr
				var/list/firel=list("Single Shot"=1,"3-Burst Shot"=2,"Full-Auto"=3)
				if(src.combined)
					firel+="Grenade Launcher"
					firel["Grenade Launcher"]="GL"
				var/answer=firel[input(M,"Change fire to?","Switch")as null|anything in firel]
				if(!answer||!(src in M))return
				if(isnum(answer))
					if(src.projectile)
						src.removegl(src.clip,src.mclip,src.maxammo,src.ammo_type,M)
					src.stype=answer
				else if(answer=="GL")
					if(!M.gamein||M.reloading||GameOver||GameOn == 0||GameOn == 1)return
					src.addgl(src.clip,src.mclip,src.maxammo,src.ammo_type,50,50,M)
					src.addgl(src.clip,src.mclip,src.maxammo,src.ammo_type,50,50,M)
		M4_Carbine
			name = "M4 with M203"
			icon = 'Rifles.dmi'
			icon_state = "M4A1 Carbine"
			clip=30
			mclip=30
			maxammo = MAXNATOAMMO
			firerate=1
			fire_power=26
			reload_time=26
			accuracy=70
			cancombine = 1
			reload_sound=SOUND_UMP45_BOLTPULL
			fire_sound=SOUND_M4A1_FIRE
			ammo_type="5.56mm NatO Rounds"
			flicker="ShootingMachineH"
			overlay_add='M4A1Carbine.dmi'
			sound_wav=55
			at=5
			cost=2315
			clip_level_cost=260
			upgrade_mc=list(1=32,2=34,3=36)
			upgrade_fp=list(1=26.5,2=27,3=27.5,4=28,5=29,6=31)
			upgrade_rs=list(1=24,2=23,3=21,4=20,5=16)
			upgrade_fr=list(1=1)
			upgrade_ac=list(1=70)
			accuracy_level=1
			can_upgrade_ac = 0
			can_upgrade_fr = 0
			firerate_level=1
			ammo_path=/obj/Pickup/Items/Ammo_Heavy_Machinegun
			verb/Change_Fire()
				set src in usr
				set category = null
				var/mob/player/client/M=usr
				var/list/firel=list("Single Shot"=1,"3-Burst Shot"=2,"Full-Auto"=3)
				if(src.combined)
					firel+="Grenade Launcher"
					firel["Grenade Launcher"]="GL"
				var/answer=firel[input(M,"Change fire to?","Switch")as null|anything in firel]
				if(!answer||!(src in M))return
				if(isnum(answer))
					if(src.projectile)
						src.removegl(src.clip,src.mclip,src.maxammo,src.ammo_type,M)
					src.stype=answer
				else if(answer=="GL")
					if(!M.gamein||M.reloading||GameOver||GameOn == 0||GameOn == 1)return
					src.addgl(src.clip,src.mclip,src.maxammo,src.ammo_type,50,50,M)
					src.addgl(src.clip,src.mclip,src.maxammo,src.ammo_type,50,50,M)


		M16
			name = "M16"
			icon = 'Rifles.dmi'
			icon_state = "M16"
			clip=32
			mclip=32
			maxammo = MAXNATOAMMO
			firerate=1
			fire_power=27
			reload_time=28
			accuracy=70
			reload_sound=SOUND_RELOADING_2
			fire_sound=SOUND_M4
			ammo_type="5.56mm NatO Rounds"
			flicker="ShootingMachineH"
			overlay_add='M16.dmi'
			sound_wav=50
			at=5
			cost=2305
			clip_level_cost=250
			upgrade_mc=list(1=34,2=36)
			upgrade_fp=list(1=27.5,2=28,3=28.5,4=29,5=30,6=31)
			upgrade_rs=list(1=26,2=25,3=23,4=21,5=17)
			upgrade_fr=list(1=1)
			upgrade_ac=list(1=70)
			accuracy_level=1
			can_upgrade_ac = 0
			can_upgrade_fr = 0
			firerate_level=1
			ammo_path=/obj/Pickup/Items/Ammo_Heavy_Machinegun
		AUG
			name ="AUG"
			icon = 'Rifles.dmi'
			icon_state = "AUG"
			clip=32
			mclip=32
			maxammo = MAXNATOAMMO
			firerate=1
			fire_power=26
			reload_time=24
			accuracy=70
			reload_sound=SOUND_M3_PUMP
			fire_sound=SOUND_AUG_1
			ammo_type="5.56mm NatO Rounds"
			flicker="ShootingMachineH"
			overlay_add='AUG.dmi'
			sound_wav=55
			at=5
			cost=2314
			clip_level_cost=300
			upgrade_mc=list(1=36,2=42)
			upgrade_fp=list(1=26.5,2=27,3=27.5,4=29,5=30)
			upgrade_rs=list(1=22,2=20,3=18,4=17,5=14)
			upgrade_fr=list(1=1)
			upgrade_ac=list(1=70)
			accuracy_level=1
			can_upgrade_ac = 0
			can_upgrade_fr = 0
			firerate_level=1
			ammo_path=/obj/Pickup/Items/Ammo_Heavy_Machinegun
		rap
			name = "Rapter Assualt Rifle"
			icon = 'Rifles.dmi'
			icon_state = "raptor"
			clip=20
			mclip=20
			maxammo = MAXNATOAMMO
			firerate=1
			fire_power=250
			reload_time=31
			accuracy=70
			reload_sound=SOUND_BOLT_REL
			fire_sound=SOUND_G3SG1_1
			ammo_type="5.56mm NatO Rounds"
			flicker="ShootingMachineH"
			overlay_add='gg.dmi'
			sound_wav=70
			at=5
			cost=98700
			clip_level_cost=19900
			upgrade_mc=list(1=40)
			upgrade_fp=list(1=450)
			upgrade_rs=list(1=21)
			upgrade_fr=list(1=1)
			upgrade_ac=list(1=70)
			accuracy_level=1
			can_upgrade_ac = 0
			can_upgrade_fr = 0
			firerate_level=1
			ammo_path=/obj/Pickup/Items/Ammo_Heavy_Machinegun
		gdi_rifle
			name = "Quickshot Rifle"
			icon = 'Rifles.dmi'
			icon_state = "GDI_gun"
			clip=10
			mclip=10
			maxammo = MAXNATOAMMO
			firerate=0.1
			fire_power=250
			reload_time=15
			accuracy=100
			reload_sound=SOUND_BOLT_REL
			fire_sound=SOUND_G3SG1_1
			ammo_type="5.56mm NatO Rounds"
			flicker="ShootingMachineH"
			overlay_add='GDI gun.dmi'
			sound_wav=70
			at=5
			cost=20000
			clip_level_cost=10000
			upgrade_mc=list(1=20)
			upgrade_fp=list(1=300)
			upgrade_rs=list(1=10)
			upgrade_fr=list(1=0.1)
			upgrade_ac=list(1=100)
			accuracy_level=1
			can_upgrade_ac = 0
			can_upgrade_fr = 0
			firerate_level=1
			ammo_path=/obj/Pickup/Items/Ammo_Heavy_Machinegun
		nod_rifle
			name = "Shin Battle Rifle Elite"
			icon = 'Rifles.dmi'
			icon_state = "Assault Rifle_N"
			clip=33
			mclip=33
			maxammo = MAXNATOAMMO
			firerate=1
			fire_power=100
			reload_time=15
			accuracy=100
			reload_sound=SOUND_BOLT_REL
			fire_sound=SOUND_G3SG1_1
			ammo_type="5.56mm NatO Rounds"
			flicker="ShootingMachineH"
			overlay_add='SBE.dmi'
			sound_wav=70
			at=5
			cost=20000
			clip_level_cost=10000
			upgrade_mc=list(1=45)
			upgrade_fp=list(1=200)
			upgrade_rs=list(1=10)
			upgrade_fr=list(1=1)
			upgrade_ac=list(1=100)
			accuracy_level=1
			can_upgrade_ac = 0
			can_upgrade_fr = 0
			firerate_level=1
			ammo_path=/obj/Pickup/Items/Ammo_Heavy_Machinegun
		scop
			name = "Scorpion Assualt Rifle"
			icon = 'Rifles.dmi'
			icon_state = "Scorp"
			clip=10
			mclip=10
			maxammo = MAXNATOAMMO
			firerate=1
			fire_power=150
			reload_time=21
			accuracy=70
			reload_sound=SOUND_BOLT_REL
			fire_sound=SOUND_G3SG1_1
			ammo_type="5.56mm NatO Rounds"
			flicker="ShootingMachineH"
			overlay_add='shin.dmi'
			sound_wav=70
			at=5
			cost=98700
			cancombine = 1
			clip_level_cost=19900
			upgrade_mc=list(1=40)
			upgrade_fp=list(1=350)
			upgrade_rs=list(1=11)
			upgrade_fr=list(1=1)
			upgrade_ac=list(1=70)
			accuracy_level=1
			can_upgrade_ac = 0
			can_upgrade_fr = 0
			firerate_level=1
			ammo_path=/obj/Pickup/Items/Ammo_Heavy_Machinegun
		G36C
			name = "G36C"
			icon = 'Rifles.dmi'
			icon_state = "G36C"
			clip=30
			mclip=30
			maxammo = MAXNATOAMMO
			firerate=1
			accuracy=70
			fire_power=48
			reload_time=48
			reload_sound=SOUND_BOLT_REL
			fire_sound=SOUND_G3SG1_1
			ammo_type="5.56mm NatO Rounds"
			flicker="ShootingMachineH"
			overlay_add='g36.dmi'
			sound_wav=70
			at=5
			cost=2338
			clip_level_cost=1900
			upgrade_mc=list(1=36)
			upgrade_fp=list(1=62.5,2=73,3=74,4=75,5=75.5,6=76)
			upgrade_rs=list(1=24,2=22,3=20,4=17,5=10)
			upgrade_fr=list(1=1)
			upgrade_ac=list(1=70)
			accuracy_level=1
			can_upgrade_ac = 0
			can_upgrade_fr = 0
			firerate_level=1
			ammo_path=/obj/Pickup/Items/Ammo_Heavy_Machinegun
		Nod_gun
			name = "Nod Assult Rifle"
			icon = 'Rifles.dmi'
			icon_state = "Nod_gun"
			clip=40
			mclip=40
			maxammo = MAXNATOAMMO
			firerate=1
			accuracy=70
			fire_power=28
			reload_time=28
			reload_sound=SOUND_BOLT_REL
			fire_sound=SOUND_G3SG1_1
			ammo_type="5.56mm NatO Rounds"
			flicker="ShootingMachineH"
			overlay_add='Nod gun.dmi'
			sound_wav=70
			at=5
			cost=10000
			clip_level_cost=1220
			upgrade_mc=list(1=46)
			upgrade_fp=list(1=44)
			upgrade_rs=list(1=15)
			upgrade_fr=list(1=1)
			upgrade_ac=list(1=70)
			accuracy_level=1
			can_upgrade_ac = 0
			can_upgrade_fr = 0
			firerate_level=1
			ammo_path=/obj/Pickup/Items/Ammo_Heavy_Machinegun
		blackhandgun
			name = "Black hand Assult Rifle"
			icon = 'Rifles.dmi'
			icon_state = "Black"
			clip=40
			mclip=40
			maxammo = MAXNATOAMMO
			firerate=1
			accuracy=70
			fire_power=28
			reload_time=28
			reload_sound=SOUND_BOLT_REL
			fire_sound=SOUND_G3SG1_1
			ammo_type="5.56mm NatO Rounds"
			flicker="ShootingMachineH"
			overlay_add='Nod gun.dmi'
			sound_wav=70
			at=5
			cost=19000
			clip_level_cost=2300
			upgrade_mc=list(1=60)
			upgrade_fp=list(1=130)
			upgrade_rs=list(1=15)
			upgrade_fr=list(1=1)
			upgrade_ac=list(1=70)
			accuracy_level=1
			can_upgrade_ac = 0
			can_upgrade_fr = 0
			firerate_level=1
			ammo_path=/obj/Pickup/Items/Ammo_Heavy_Machinegun
		shadow
			name = "Shadow Battle Rifle"
			icon = 'Rifles.dmi'
			icon_state = "BHgun"
			clip=30
			mclip=30
			maxammo = MAXNATOAMMO
			firerate=1
			accuracy=70
			fire_power=100
			reload_time=10
			reload_sound=SOUND_BOLT_REL
			fire_sound=SOUND_G3SG1_1
			ammo_type="5.56mm NatO Rounds"
			flicker="ShootingMachineH"
			overlay_add='SL8.dmi'
			sound_wav=70
			at=5
			cost=57000
			clip_level_cost=5300
			upgrade_mc=list(1=60)
			upgrade_fp=list(1=200)
			upgrade_rs=list(1=15)
			upgrade_fr=list(1=1)
			upgrade_ac=list(1=70)
			accuracy_level=1
			can_upgrade_ac = 0
			can_upgrade_fr = 0
			firerate_level=1
			ammo_path=/obj/Pickup/Items/Ammo_Heavy_Machinegun
		G3SG1
			name = "G3A3"
			icon = 'Rifles.dmi'
			icon_state = "G3A3"
			clip=20
			mclip=20
			maxammo = MAXNATOAMMO
			firerate=1
			fire_power=28
			reload_time=28
			accuracy=70
			reload_sound=SOUND_BOLT_REL
			fire_sound=SOUND_G3SG1_1
			ammo_type="5.56mm NatO Rounds"
			flicker="ShootingMachineH"
			overlay_add='G3SG1.dmi'
			sound_wav=70
			at=5
			cost=2318
			cancombine = 1
			clip_level_cost=300
			upgrade_mc=list(1=26)
			upgrade_fp=list(1=28.5,2=29,3=30,4=31,5=32,6=34)
			upgrade_rs=list(1=26,2=24,3=22,4=20,5=17)
			upgrade_fr=list(1=1)
			upgrade_ac=list(1=70)
			accuracy_level=1
			can_upgrade_ac = 0
			can_upgrade_fr = 0
			firerate_level=1
			ammo_path=/obj/Pickup/Items/Ammo_Heavy_Machinegun
			verb/Change_Fire()
				set src in usr
				set category = null
				var/mob/player/client/M=usr
				var/list/firel=list("Single Shot"=1,"3-Burst Shot"=2,"Full-Auto"=3)
				if(src.combined)
					firel+="Grenade Launcher"
					firel["Grenade Launcher"]="GL"
				var/answer=firel[input(M,"Change fire to?","Switch")as null|anything in firel]
				if(!answer||!(src in M))return
				if(isnum(answer))
					if(src.projectile)
						src.removegl(src.clip,src.mclip,src.maxammo,src.ammo_type,M)
					src.stype=answer
				else if(answer=="GL")
					if(!M.gamein||M.reloading||GameOver||GameOn == 0||GameOn == 1)return
					src.addgl(src.clip,src.mclip,src.maxammo,src.ammo_type,50,50,M)
		GDI_Carbine
			name = "GDI Assualt rifle with Kestrel laucher "
			icon = 'Rifles.dmi'
			icon_state = "GGL"
			clip=30
			mclip=30
			maxammo = MAXNATOAMMO
			firerate=1
			fire_power=26
			reload_time=26
			accuracy=70
			cancombine = 1
			reload_sound=SOUND_UMP45_BOLTPULL
			fire_sound=SOUND_M4A1_FIRE
			ammo_type="5.56mm NatO Rounds"
			flicker="ShootingMachineH"
			overlay_add='AK-47.dmi'
			sound_wav=55
			at=5
			cost=15000
			clip_level_cost=1220
			upgrade_mc=list(1=46)
			upgrade_fp=list(1=44)
			upgrade_rs=list(1=15)
			upgrade_fr=list(1=1)
			upgrade_ac=list(1=70)
			accuracy_level=1
			can_upgrade_ac = 0
			can_upgrade_fr = 0
			firerate_level=1
			ammo_path=/obj/Pickup/Items/Ammo_Heavy_Machinegun
			verb/Change_Fire()
				set src in usr
				set category = null
				var/mob/player/client/M=usr
				var/list/firel=list("Single Shot"=1,"3-Burst Shot"=2,"Full-Auto"=3)
				if(src.combined)
					firel+="Grenade Launcher"
					firel["Grenade Launcher"]="GL"
				var/answer=firel[input(M,"Change fire to?","Switch")as null|anything in firel]
				if(!answer||!(src in M))return
				if(isnum(answer))
					if(src.projectile)
						src.removegl(src.clip,src.mclip,src.maxammo,src.ammo_type,M)
					src.stype=answer
				else if(answer=="GL")
					if(!M.gamein||M.reloading||GameOver||GameOn == 0||GameOn == 1)return
					src.addgl(src.clip,src.mclip,src.maxammo,src.ammo_type,50,50,M)
		Nod_Carbine
			name = "Nod Assualt rifle With Viper Laucher"
			icon = 'Rifles.dmi'
			icon_state = "AKGL"
			clip=30
			mclip=30
			maxammo = MAXNATOAMMO
			firerate=1
			fire_power=26
			reload_time=26
			accuracy=70
			cancombine = 1
			reload_sound=SOUND_UMP45_BOLTPULL
			fire_sound=SOUND_M4A1_FIRE
			ammo_type="5.56mm NatO Rounds"
			flicker="ShootingMachineH"
			overlay_add='AK-47.dmi'
			sound_wav=55
			at=5
			cost=15000
			clip_level_cost=1220
			upgrade_mc=list(1=46)
			upgrade_fp=list(1=44)
			upgrade_rs=list(1=15)
			upgrade_fr=list(1=1)
			upgrade_ac=list(1=70)
			accuracy_level=1
			can_upgrade_ac = 0
			can_upgrade_fr = 0
			firerate_level=1
			ammo_path=/obj/Pickup/Items/Ammo_Heavy_Machinegun
			verb/Change_Fire()
				set src in usr
				set category = null
				var/mob/player/client/M=usr
				var/list/firel=list("Single Shot"=1,"3-Burst Shot"=2,"Full-Auto"=3)
				if(src.combined)
					firel+="Grenade Launcher"
					firel["Grenade Launcher"]="GL"
				var/answer=firel[input(M,"Change fire to?","Switch")as null|anything in firel]
				if(!answer||!(src in M))return
				if(isnum(answer))
					if(src.projectile)
						src.removegl(src.clip,src.mclip,src.maxammo,src.ammo_type,M)
					src.stype=answer
				else if(answer=="GL")
					if(!M.gamein||M.reloading||GameOver||GameOn == 0||GameOn == 1)return
					src.addgl(src.clip,src.mclip,src.maxammo,src.ammo_type,50,50,M)
mob/player/client/var/hash

proc
	hashme(var/mob/player/client/p)
		var/hashed_var = md5("gkhphimko,bh55427[p.name]jjl;i^ewjoe&sg457672[VersionS]g92^%&$&*%3@^45443541[p.maxitems]237%#%$&**tryer[p.chest_capacity]#$")
		for(var/obj/Pickup/Guns/G in p.item_save)
			hashed_var += md5("[G.combined]*^%&^$%)^56[G.name]fdgh56*^%e3^_%$3421*^#%gjl071230[G.mclip]012379074$0%&*^*^&**^76448412[G.firerate]4784%46#&&#)7844[G.fire_power]6696*&*%)(&(%69821p6[G.reload_time]45612@W$^)^^%&#%^[G.clip_level_cost]#$^%*@#%!%%^#%$W#6[G.clip_level_cost]&^%^*$#%@!$^^%&657005[G.firerate_level_cost]69&^%*$6058966%^#*&%&$#$%@#20971[G.gunpower_level_cost]r909thryue%@%^%&$%&%uio$&$%4757[G.reloadtime_level_cost]slk%*#^&Q#@dsg%#ddd%$#$")
		for(var/obj/Pickup/Guns/G in p.chest)
			hashed_var += md5("[G.combined]*^%&^$%)^fj[G.name]fdh*65^%&^$&^_%$34tykti21*^#%gjl64874674[G.mclip]841367%&#$*^*^&**^764[G.firerate]478%#&&#)-338474[G.fire_power]585&*%_&_&^6673221[G.reload_time]43653^%(^(^_+*&&#%^[G.clip_level_cost]#$^%*@#%!%%%^$W#6[G.clip_level_cost]&^%^*$#%@!$^%^%&%658[G.firerate_level_cost]&58^$#%^#*&%&$#44$%@#21[G.gunpower_level_cost]rthryue%@%^%&$%4757[G.reloadtime_level_cost]slk%*dge%#ddd%$#$")
		hashed_var += md5("*&%4224&%&)*75567653[p.cash]slk%*d#57337^)*%_)[length(p.item_save)]_$^_%#%)52&(%@_$##@$#ddsg[length(p.chest)](*)&(4562")
		return hashed_var
	autosave()
		world<<"<b><font color=[FIRSTCOLOR]>* Auto-Saving..."
		for(var/mob/player/client/p in world)
			if(!p||!p.client)continue
			spawn(){p.save_game(1);p<<"<b><font color=[FIRSTCOLOR]>* ...Game Saved"}


mob/player/client/proc
	savenload_icon(var/i)
		if(i)
			var/savefile/F = new("save/[copytext(src.ckey, 1, 2)]/[src.ckey].save")
			F["Ini_Icon"]<<src.ini_icon
			F["Ini_HIcon"]<<src.ini_hicon
			F["4$###$4"]<<src.save_check
			F["SS@#CC#@SS"]<<src.scommand
		else
			var/N=copytext(src.ckey, 1, 2)
			if(fexists("save/[N]/[src.ckey].save"))
				var/savefile/F = new("save/[N]/[src.ckey].save")
				F["Ini_Icon"]>>src.ini_icon
				F["Ini_HIcon"]>>src.ini_hicon
				F["4$###$4"]>>src.save_check
				F["SS@#CC#@SS"]>>src.scommand
				if(!length(src.scommand))src.scommand = list("F1" = "Zombies!","F2" = "Run!","F3" = "I need ammo!","F4" = "I need healing!","F5" = "","F6" = "","F7" = "","F8" = "")
				if(src.ini_icon)return 1
	reset_game()
		if(!src||!src.client)return
		var/savefile/F = new()
		F["Reset"]<<1
		src.client.Export(F)
		/*if(src.gamein||src.alignment)
			src<<"* You have to be at the title screen to reset your game."
			return
		var/rc = Delete_Savefile(src.key)
		if(rc)
			src.contents=new/list()
			src.chest=new/list()
			src.pick_character()
			src.music=1
			src.cash=0
			src.maxitems=6
			src.chest_capacity=4
			if(src.gender=="female")src.contents+=new/obj/Pickup/Guns/M92F_Custom_Handgun
			else src.contents+=new/obj/Pickup/Guns/VP07
			src.save_game(1)
			src<<"* Save reseted."
		else src<<"* No save to reset."
	*/
	save_game()
		if(!src||!src.client||src.isSaving)return
		src.isSaving=1
		var/savefile/F = new()
		src.item_save = new/list()
		for(var/obj/Pickup/Guns/G in src.contents)
			src.item_save += G
		F["#^&&^#"]<<src.cash
		F["DEDEEDE"]<<src.chest
		F["!!!!!!!"]<<src.item_save
		F["KKLLKK"]<<src.maxitems
		F["NNNNFFFFNNNN"]<<src.chest_capacity
		if(src.class)F["NNFFFFNN"]<<src.class
		src.hash = hashme(src)
		F["*(())*"]<<src.hash
		F["MM**MM"]<<src.music
		F["***&&***"]<<src.chat_color
		F["&*&*&*&*"]<<src.name_color
		F["PREFIX"]<<src.prefix
		F["PREFIXC"]<<src.prefix_color
		F["SG*&*&*GS"]<<src.statgamep
		F["KKLOLOLKK"]<<src.statitem
		F["$$!$$"]<<src.bold
		F["FRUPFR"]<<src.freeupgrade
		src.client.Export(F)
		src.isSaving=0
	load_game()
		if(!src||!src.client)return
		var/client_file = src.client.Import()
		if(client_file)
			var/savefile/F = new(client_file)
			if(!F["Reset"])
				F["#^&&^#"]>>src.cash
				F["DEDEEDE"]>>src.chest
				F["!!!!!!!"]>>src.item_save
				F["KKLLKK"]>>src.maxitems
				F["NNNNFFFFNNNN"]>>src.chest_capacity
				if(F["NNFFFFNN"])F["NNFFFFNN"]>>src.class
				F["*(())*"]>>src.hash
				if(!src.hash||src.hash!=hashme(src)||src.schecker() == 1)
					src.reset_game()
					src<<"<b><font color=red>Error!.... Relog again..."
					del(src)
				F["$$!$$"]>>src.bold
				F["FRUPFR"]>>src.freeupgrade
				F["MM**MM"]>>src.music
				F["***&&***"]>>src.chat_color
				F["PREFIX"]>>src.prefix
				F["PREFIXC"]>>src.prefix_color
				F["&*&*&*&*"]>>src.name_color
				F["SG*&*&*GS"]>>src.statgamep
				F["KKLOLOLKK"]>>src.statitem
				if(length(src.prefix)>5)src.prefix=copytext(src.prefix,1,6)
				if(!src.savenload_icon(null))src.pick_character(1)
				src.contents += src.item_save
				return
		src.pick_character_stats()
		src.pick_character()
		src.music=1
		src.cash=5000
		src.maxitems=6
		if(prob(50))src.contents+=new/obj/Pickup/Guns/M92F_Custom_Handgun
		else src.contents+=new/obj/Pickup/Guns/VP07
		src.save_game()


mob/player/client/proc/pick_character()
	switch(alert(src,"Pick a character from the RE series or play as a custom character?","Pick","RE series","Custom"))
		if("RE series")
			var/confrim = input(src,"Pick a charcter you would like to play as.","Choose")as null|anything in character_list
			if(confrim)
				src.ini_hicon = null
				src.ini_icon = character_list[confrim]
				src.savenload_icon(1)
				return 1
		if("Custom")
			var/list/body_icon = list("Body 1" = 'body2.dmi',"Body 2" = 'body3.dmi',"Body 3" = 'body4.dmi',"Body 4" = 'body5.dmi',"Body 5" = 'body6.dmi')
			var/confrim = input(src,"Choose a body for your character.","Choose")as null|anything in body_icon
			var/list/head_icon = list("Head 1" = 'head2.dmi',"Head 2" = 'head3.dmi',"Head 3" = 'head4.dmi',"Head 4" = 'head5.dmi',"Head 5" = 'head6.dmi',"Head 6" = 'head7.dmi',"Head 7" = 'head8.dmi')
			var/confrim2 = input(src,"Choose a head for your character.","Choose")as null|anything in head_icon
			if(confrim && confrim2)
				src.ini_icon = body_icon[confrim]
				src.ini_hicon = head_icon[confrim2]
				src.savenload_icon(1)
				return 1

//LOAD THEM INTO GAME!!!
mob/player/client/proc/load()
	if(!src||!src.client)return
	src.verbs-=/mob/Ogame/verb/Observe
	if(!locate(/obj/Special/Item/Detonator) in src.contents)src.contents+=new/obj/Special/Item/Detonator
	for(var/obj/Pickup/Guns/G in src.contents)
		G.clip=G.mclip
		G.suffix=null
	src.load_character_stats()
	src.load_character_start_items()
	if(GameOn == 1 && (length(src.contents)-1)<=(src.maxitems-1))
		for(var/obj/Pickup/Guns/G in src.contents)
			if(src.items>=src.maxitems)break
			if(G.ammo_path)
				var/obj/Pickup/Items/A = new G.ammo_path
				if(src.ammolimits["[A.name]"]<=0){del(A);continue}
				A.ammount=src.ammolimits["[A.name]"]
				A.suffix="x[A.ammount]"
				src.contents+=A
				src.update_items(1)
	src.maxhealth=14
	src.health=src.maxhealth
	src.overlays += src.hpbar
	src.client.eye = src
	src.watch = 0
	src.see_in_dark=4
	src.sight=null
	if(src.ini_hicon)
		var/obj/O = new
		O.icon = src.ini_hicon
		O.layer = FLOAT_LAYER-1
		src.overlays += O
	src.icon = src.ini_icon
	src.icon_state = "normal"
	if(src.AV_Icon)src.AV_Icon.icon = src.ini_icon
	if(src.LS_Icon)src.LS_Icon.icon = 'lifespan(1).dmi'
	src.hideunhide_hud(1,1,null)
	src.hideunhide_hud(2,2,"Clip")
	src.hideunhide_hud(2,2,"Clip2")
	src.addname("[src.key]")
	src.update_items(1)
	world<<"<b><font color=[SECCOLOR]>([src]) has joined the game"
	world.log<<"<b><font color=[SECCOLOR]>([src]) has joined the game"
	src.invisibility=0
	src.density=1

mob/player/client/proc/load_character_stats()
	switch(src.class)
		if("Default")
			src.ammolimits = list("Propane" = 1, "MediPack" = 1, "Ammo Supply Pack" = 1, "Demolitions Supply Pack" = 1,"GDI Backup Radio" = 1, "Nod Backup Radio" = 1, "Nod Quick Set up Barricade Pack" = 1, "Launcher Parts" = 1,"Gas Tank" = 1,"Spray" = 1,"T-Cure" = 1,"C4" = 3,"Trip Wire" = 3,"Land Mine"=4,"Grenade"=6,"Molotov"=3,"9mm Parabellum Rounds" = 3,".357 Magnum Rounds" = 1,"12 Gauge Shells" = 2,".45 ACP Rounds" = 2, "5.56mm NatO Rounds" = 2, "7.62x54mmR Rounds" = 2, ".50 CC Rounds" = 2, "Flame Rounds" = 2, "Freeze Rounds" = 2, "Acid Rounds" = 2, "Explosive Rounds" = 2)
			src.walkdelay=2
			src.maxhealth=14
			src.commandmax=2
			src.resist_inf=75
			src.ammo = list("Propane" = 50, "9mm Parabellum Rounds" = 90,\
							 ".357 Magnum Rounds" = 35,\
							 "12 Gauge Shells" = 100,\
							 ".45 ACP Rounds" = 500,\
							 "5.56mm NatO Rounds" = 800, \
							 "7.62x54mmR Rounds" = 300, \
							 ".50 CC Rounds" = 30,\
							 "Rockets" = 2, \
							 "Flame Rounds" = 4, \
							 "Freeze Rounds" = 4, \
							 "Acid Rounds" = 4, \
							 "Explosive Rounds" = 4)
		if("Medic")
			//Medic Class
			src.ammolimits = list("Propane" = 1,"MediPack" = 3, "Ammo Supply Pack" = 1, "Demolitions Supply Pack" = 1,"GDI Backup Radio" = 1, "Nod Backup Radio" = 1, "Nod Quick Set up Barricade Pack" = 1, "Launcher Parts" = 1,"Gas Tank" = 1,"Spray" = 5,\
							  "T-Cure" = 4,\
							  "C4" = 0,\
							  "Trip Wire" = 0,\
							  "Land Mine"=3,\
							  "Grenade"=3,\
							  "Molotov"=1,\
							  "9mm Parabellum Rounds" = 5,\
							  ".357 Magnum Rounds" = 3,\
							  "12 Gauge Shells" = 0,\
							  ".45 ACP Rounds" = 2,\
							  "5.56mm NatO Rounds" = 1,\
							  "7.62x54mmR Rounds" = 1,\
							  ".50 CC Rounds" = 2,\
							  "Flame Rounds" = 2,\
							  "Freeze Rounds" = 2,\
							  "Acid Rounds" = 2,\
							  "Explosive Rounds" = 2)
			src.ammo = list("Propane" = 50,"9mm Parabellum Rounds" = 90,\
							 ".357 Magnum Rounds" = 35,\
							 "12 Gauge Shells" = 80,\
							 ".45 ACP Rounds" = 600,\
							 "5.56mm NatO Rounds" = 500, \
							 "7.62x54mmR Rounds" = 300, \
							 ".50 CC Rounds" = 30,\
							 "Rockets" = 2, \
							 "Flame Rounds" = 4, \
							 "Freeze Rounds" = 4, \
							 "Acid Rounds" = 4, \
							 "Explosive Rounds" = 4)
			src.walkdelay=2
			src.maxhealth=10
			src.commandmax=1
			src.resist_inf=60
		if("Arms Specialist")
			//Heavy Weapons Class
			src.ammolimits = list("Propane" = 1,"MediPack" = 1, "Ammo Supply Pack" = 3, "Demolitions Supply Pack" = 2,"GDI Backup Radio" = 1, "Nod Backup Radio" = 1, "Nod Quick Set up Barricade Pack" = 1, "Launcher Parts" = 1,"Gas Tank" = 1,"Spray" = 0,\
							  "T-Cure" = 1,\
							  "C4" = 0,\
							  "Trip Wire" = 2,\
							  "Land Mine"=3,\
							  "Grenade"=6,\
							  "Molotov"=3,\
							  "9mm Parabellum Rounds" = 0,\
							  ".357 Magnum Rounds" = 1,\
							  "12 Gauge Shells" = 4,\
							  ".45 ACP Rounds" = 2,\
							  "5.56mm NatO Rounds" = 4,\
							  "7.62x54mmR Rounds" = 0,\
							  ".50 CC Rounds" = 0,\
							  "Flame Rounds" = 3,\
							  "Freeze Rounds" = 2,\
							  "Acid Rounds" = 2,\
							  "Explosive Rounds" = 3)
			src.ammo = list("Propane" = 500,"9mm Parabellum Rounds" = 50,\
							 ".357 Magnum Rounds" = 20,\
							 "12 Gauge Shells" = 130,\
							 ".45 ACP Rounds" = 500,\
							 "5.56mm NatO Rounds" = 1100, \
							 "7.62x54mmR Rounds" = 300, \
							 ".50 CC Rounds" = 30,\
							 "Rockets" = 2, \
							 "Flame Rounds" = 4, \
							 "Freeze Rounds" = 4, \
							 "Acid Rounds" = 4, \
							 "Explosive Rounds" = 4)
			src.walkdelay=3
			src.maxhealth=18
			src.commandmax=3
			src.resist_inf=80
		if("Demolitions")
			//Demolitions Class
			src.ammolimits = list("Propane" = 3,"MediPack" = 1, "Ammo Supply Pack" = 1, "Demolitions Supply Pack" = 3,"GDI Backup Radio" = 1, "Nod Backup Radio" = 1, "Nod Quick Set up Barricade Pack" = 1, "Launcher Parts" = 1,"Gas Tank" = 1,"Spray" = 0,\
							  "T-Cure" = 0,\
							  "C4" = 5,\
							  "Trip Wire" = 5,\
							  "Land Mine"=8,\
							  "Grenade"=8,\
							  "Molotov"=5,\
							  "9mm Parabellum Rounds" = 0,\
							  ".357 Magnum Rounds" = 2,\
							  "12 Gauge Shells" = 6,\
							  ".45 ACP Rounds" = 0,\
							  "5.56mm NatO Rounds" = 0,\
							  "7.62x54mmR Rounds" = 0,\
							  ".50 CC Rounds" = 0,\
							  "Flame Rounds" = 3,\
							  "Freeze Rounds" = 3,\
							  "Acid Rounds" = 3,\
							  "Explosive Rounds" = 3)
			src.ammo = list("Propane" = 50,"9mm Parabellum Rounds" = 40,\
							 ".357 Magnum Rounds" = 40,\
							 "12 Gauge Shells" = 180,\
							 ".45 ACP Rounds" = 600,\
							 "5.56mm NatO Rounds" = 400, \
							 "7.62x54mmR Rounds" = 300, \
							 ".50 CC Rounds" = 30,\
							 "Rockets" = 2, \
							 "Flame Rounds" = 4, \
							 "Freeze Rounds" = 4, \
							 "Acid Rounds" = 4, \
							 "Explosive Rounds" = 4)
			src.walkdelay=4
			src.maxhealth=22
			src.commandmax=2
			src.resist_inf=65
		if("Infiltrator")
			//Infiltrator Class
			src.ammolimits = list("Propane" = 1,"MediPack" = 1, "Ammo Supply Pack" = 1, "Demolitions Supply Pack" = 1,"GDI Backup Radio" = 1, "Nod Backup Radio" = 1, "Nod Quick Set up Barricade Pack" = 1, "Launcher Parts" = 1,"Gas Tank" = 1,"Spray" = 1,\
							  "T-Cure" = 0,\
							  "C4" = 0,\
							  "Trip Wire" = 3,\
							  "Land Mine"=2,\
							  "Grenade"=2,\
							  "Molotov"=1,\
							  "9mm Parabellum Rounds" = 4,\
							  ".357 Magnum Rounds" = 1,\
							  "12 Gauge Shells" = 0,\
							  ".45 ACP Rounds" = 2,\
							  "5.56mm NatO Rounds" = 0,\
							  "7.62x54mmR Rounds" = 3,\
							  ".50 CC Rounds" = 4,\
							  "Flame Rounds" = 0,\
							  "Freeze Rounds" = 3,\
							  "Acid Rounds" = 3,\
							  "Explosive Rounds" = 0)
			src.ammo = list("Propane" = 50,"9mm Parabellum Rounds" = 115,\
							 ".357 Magnum Rounds" = 35,\
							 "12 Gauge Shells" = 40,\
							 ".45 ACP Rounds" = 400,\
							 "5.56mm NatO Rounds" = 300, \
							 "7.62x54mmR Rounds" = 300, \
							 ".50 CC Rounds" = 30,\
							 "Rockets" = 2, \
							 "Flame Rounds" = 4, \
							 "Freeze Rounds" = 4, \
							 "Acid Rounds" = 4, \
							 "Explosive Rounds" = 4)
			src.walkdelay=1
			src.maxhealth=12
			src.commandmax=1
			src.resist_inf=80
		if("Commander")
			//Commander Class
			src.ammolimits = list("Propane" = 1,"MediPack" = 1, "Ammo Supply Pack" = 3, "Demolitions Supply Pack" = 1,"GDI Backup Radio" = 1, "Nod Backup Radio" = 1, "Nod Quick Set up Barricade Pack" = 1, "Oil" = 0, "Launcher Parts" = 1,"Gas Tank" = 1,"Spray" = 1,"T-Cure" = 1,"C4" = 1,"Trip Wire" = 1,"Land Mine"=4,"Grenade"=3,"Molotov"=1,"9mm Parabellum Rounds" = 3,".357 Magnum Rounds" = 1,"12 Gauge Shells" = 2,".45 ACP Rounds" = 2, "5.56mm NatO Rounds" = 2, "7.62x54mmR Rounds" = 2, ".50 CC Rounds" = 2, "Flame Rounds" = 2, "Freeze Rounds" = 2, "Acid Rounds" = 2, "Explosive Rounds" = 2)
			src.ammo = list("Propane" = 50,"9mm Parabellum Rounds" = 90,\
							 ".357 Magnum Rounds" = 35,\
							 "12 Gauge Shells" = 100,\
							 ".45 ACP Rounds" = 500,\
							 "5.56mm NatO Rounds" = 800, \
							 "7.62x54mmR Rounds" = 300, \
							 ".50 CC Rounds" = 30,\
							 "Rockets" = 2, \
							 "Flame Rounds" = 4, \
							 "Freeze Rounds" = 4, \
							 "Acid Rounds" = 4, \
							 "Explosive Rounds" = 4)
			src.walkdelay=2
			src.maxhealth=12
			src.commandmax=4
			src.resist_inf=75
		if("Engineer")
			//Engineer Class
			src.ammolimits = list("Propane" = 1,"MediPack" = 1, "Ammo Supply Pack" = 1, "Demolitions Supply Pack" = 0,"Engineer Supply Pack" = 2, "GDI Backup Radio" = 1, "Nod Backup Radio" = 1, "Nod Quick Set up Barricade Pack" = 1, "Oil" = 0, "Launcher Parts" = 1,"Gas Tank" = 1,"Hammer" = 40, "Turret" = 1, "Spray" = 1,"T-Cure" = 1,"C4" = 1,"Trip Wire" = 1,"Land Mine"=1,"Grenade"=1,"Molotov"=0,"9mm Parabellum Rounds" = 1,".357 Magnum Rounds" = 0,"12 Gauge Shells" = 1,".45 ACP Rounds" = 0, "5.56mm NatO Rounds" = 0, "7.62x54mmR Rounds" = 1, ".50 CC Rounds" = 1, "Flame Rounds" = 1, "Freeze Rounds" = 0, "Acid Rounds" = 0, "Explosive Rounds" = 0)
			src.ammo = list("Propane" = 50,"9mm Parabellum Rounds" = 30,\
							 ".357 Magnum Rounds" = 35,\
							 "12 Gauge Shells" = 50,\
							 ".45 ACP Rounds" = 200,\
							 "5.56mm NatO Rounds" = 200, \
							 "7.62x54mmR Rounds" = 200, \
							 ".50 CC Rounds" = 40,\
							 "Rockets" = 4, \
							 "Flame Rounds" = 6, \
							 "Freeze Rounds" = 6, \
							 "Acid Rounds" = 6, \
							 "Explosive Rounds" = 6)
			src.walkdelay=2
			src.maxhealth=10
			src.commandmax=1
			src.resist_inf=90
		if("Pyromaniac")
			//Pyromaniac Class
			src.ammolimits = list("Propane" = 4,"MediPack" = 1, "Ammo Supply Pack" = 1, "Demolitions Supply Pack" = 1,"GDI Backup Radio" = 1, "Nod Backup Radio" = 1, "Nod Quick Set up Barricade Pack" = 1, "Oil" = 30, "Launcher Parts" = 1,"Gas Tank" = 3,"Hammer" = 0, "Turret" = 0, "Spray" = 1,"T-Cure" = 1,"C4" = 3,"Trip Wire" = 3,"Land Mine"=5,"Grenade"=4,"Molotov"=7,"9mm Parabellum Rounds" = 3,".357 Magnum Rounds" = 2,"12 Gauge Shells" = 4,".45 ACP Rounds" = 2, "5.56mm NatO Rounds" = 2, "7.62x54mmR Rounds" = 1, ".50 CC Rounds" = 2, "Flame Rounds" = 6, "Freeze Rounds" = 0, "Acid Rounds" = 0, "Explosive Rounds" = 8)
			src.ammo = list("Propane" = 100,"9mm Parabellum Rounds" = 50,\
							 ".357 Magnum Rounds" = 35,\
							 "12 Gauge Shells" = 100,\
							 ".45 ACP Rounds" = 400,\
							 "5.56mm NatO Rounds" = 600, \
							 "7.62x54mmR Rounds" = 200, \
							 ".50 CC Rounds" = 40,\
							 "Rockets" = 10, \
							 "Flame Rounds" = 10, \
							 "Freeze Rounds" = 6, \
							 "Acid Rounds" = 6, \
							 "Explosive Rounds" = 10)
			src.walkdelay=3
			src.maxhealth=15
			src.commandmax=3
			src.resist_inf=70
	if(src.grenade >= src.ammolimits["Grenade"])
		src.grenade = src.ammolimits["Grenade"]
	if(src.molotov >= src.ammolimits["Molotov"])
		src.molotov = src.ammolimits["Molotov"]
	if(src.mine >= src.ammolimits["Land Mine"])
		src.mine = src.ammolimits["Land Mine"]

mob/player/client/proc/load_character_start_items()
	if((length(src.contents)-1)>=(src.maxitems)||GameOn != 1)return
	switch(src.class)
		if("Default"||"Commander")
			for(var/obj/Pickup/Guns/G in src.contents)
				if(src.items>=src.maxitems)break
				if(G.ammo_path)
					var/obj/Pickup/Items/A = new G.ammo_path
					if(src.ammolimits["[A.name]"]<=0){del(A);continue}
					A.ammount=src.ammolimits["[A.name]"]
					A.suffix="x[A.ammount]"
					src.contents+=A
					src.update_items(1)
		if("Medic")
			//Medic Class
			var/obj/Pickup/Items/S = new/obj/Pickup/Items/Spray
			S.ammount = 3
			S.suffix="x[S.ammount]"
			src.contents+=S
			src.update_items(1)
			if((length(src.contents)-1)<=(src.maxitems-1))
				var/obj/Pickup/Items/T = new/obj/Pickup/Items/TCure
				T.ammount = 2
				T.suffix="x[T.ammount]"
				src.contents+=T
				src.update_items(1)
		if("Engineer")
			//Medic Class
			var/obj/Pickup/Items/S = new/obj/Pickup/Items/Hammer
			S.ammount = 20
			S.suffix="x[S.ammount]"
			src.contents+=S
			src.update_items(1)
			if((length(src.contents)-1)<=(src.maxitems-1))
				var/obj/Pickup/Items/T = new/obj/Pickup/Items/Turret
				T.ammount = 1
				src.contents+=T
				src.update_items(1)
			if((length(src.contents)-1)<=(src.maxitems-1))
				var/obj/Pickup/Items/T = new/obj/Pickup/Items/QS/Engie_Pack
				T.ammount = 1
				src.contents+=T
				src.update_items(1)
		if("Arms Specialist")
			for(var/obj/Pickup/Guns/G in src.contents)
				if(src.items>=src.maxitems)break
				if(G.ammo_path)
					var/obj/Pickup/Items/A = new G.ammo_path
					if(src.ammolimits["[A.name]"]<=0){del(A);continue}
					A.ammount=src.ammolimits["[A.name]"]
					A.suffix="x[A.ammount]"
					src.contents+=A
					src.update_items(1)
		if("Demolitions")
			var/obj/Pickup/Items/C = new/obj/Pickup/Items/C4
			C.ammount = 2
			C.suffix="x[C.ammount]"
			src.contents+=C
			src.update_items(1)
			if((length(src.contents)-1)<=(src.maxitems-1))
				var/obj/Pickup/Items/T = new/obj/Pickup/Items/TripWire
				T.ammount = 2
				T.suffix="x[T.ammount]"
				src.contents+=T
				src.update_items(1)
			src.grenade=5
			src.mine=5
		if("Infiltrator")
			src.contents+= new/obj/Pickup/Items/Spray
			src.update_items(1)
			if((length(src.contents)-1)<=(src.maxitems-1))
				src.contents+=new/obj/Pickup/Items/TripWire
				src.update_items(1)
		if("Pyromaniac")
			var/obj/Pickup/Items/S = new/obj/Pickup/Items/gastanker
			S.ammount = 3
			S.suffix="x[S.ammount]"
			src.contents+=S
			src.update_items(1)
			src.molotov=7
			if((length(src.contents)-1)<=(src.maxitems-1))
				var/obj/Pickup/Items/T = new/obj/Pickup/Items/oil_dispensor
				src.contents+=T
				src.update_items(1)

mob/player/client/proc/pick_character_stats()
	again
	switch(tm_option(src,null,"Which class would you like to specialze in?","Select!","300x340",list("Default","Medic","Arms Specialist","Demolitions","Infiltrator","Commander","Engineer","Pyromaniac"),"select list"))
		if("1")
			var/descri={"
Default<br>
------------------------<br>
Health: **<br>
Speed: **<br>
Command: **<br>
Items per slot:<br>
--------Heal----<br>
----- Spray: 1<br>
----- T-cure: 1<br>
--------Ammo----<br>
----- 9mm Parabellum: 3<br>
----- .357 Magnum: 1<br>
----- 12 Gauge Shells: 2<br>
----- .45 ACP: 2<br>
----- 5.56mm NatO: 2<br>
----- .50 CC: 0<br>
----- (Flame/Explosive): 2<br>
----- (Acid/Freeze): 2<br>
--------Explosive----<br>
----- Grenades: 6<br>
----- Molotovs: 3<br>
----- Mines: 4<br>
----- C4: 3<br>
----- Trip-Wire: 3<br>
Start Items:<br>
----* Extra Ammo<br>
-------------------------<br>
Description:<br>
The Default is a well balanced class making him/she useful.<br>
-------------------------<br>
<br>
Would you like to choose this class?<br>
							"}
			switch(tm_option(src,null,"[descri]","Select!","300x340",list("Yes","No"),"select list"))
				if("2")goto again
				else
					src.class="Default"
					src<<"Your class will be changed to 'Default' class the next time you join."



		if("2")
			var/descri={"
Medic<br>
------------------------<br>
Health: *<br>
Speed: **<br>
Command: *<br>
Items per slot:<br>
--------Heal----<br>
----- Spray: 3<br>
----- T-cure: 2<br>
--------Ammo----<br>
----- 9mm Parabellum: 5<br>
----- .357 Magnum: 3<br>
----- 12 Gauge Shells: 0<br>
----- .45 ACP: 2<br>
----- 5.56mm NatO: 1<br>
----- .50 CC: 2<br>
----- (Flame/Explosive): 2<br>
----- (Acid/Freeze): 2<br>
--------Explosive----<br>
----- Grenades: 3<br>
----- Molotovs: 1<br>
----- Mines: 3<br>
----- C4: 0<br>
----- Trip-Wire: 0<br>
Start Items:<br>
----* Spray x2<br>
----* T-cure<br>
-------------------------<br>
Description:<br>
The Medic is able to resist infections better than others and always starts with 2 sprays and 1 T-cure.<br>
-------------------------<br>
<br>
Would you like to choose this class?<br>
							"}
			switch(tm_option(src,null,"[descri]","Select!","300x340",list("Yes","No"),"select list"))
				if("2")goto again
				else
					src.class="Medic"
					src<<"Your class will be changed to 'Medic' class the next time you join."


		if("3")
			var/descri={"
Arms Specialist<br>
------------------------<br>
Health: ***<br>
Speed: *<br>
Command: ***<br>
Items per slot:<br>
--------Heal----<br>
----- Spray: 0<br>
----- T-cure: 1<br>
--------Ammo----<br>
----- 9mm Parabellum: 0<br>
----- .357 Magnum: 1<br>
----- 12 Gauge Shells: 4<br>
----- .45 ACP: 2<br>
----- 5.56mm NatO: 4<br>
----- .50 CC: 0<br>
----- (Flame/Explosive): 3<br>
----- (Acid/Freeze): 2<br>
--------Explosive----<br>
----- Grenades: 6<br>
----- Molotovs: 3<br>
----- Mines: 3<br>
----- C4: 0<br>
----- Trip-Wire: 2<br>
Start Items:<br>
----* Extra Ammo<br>
-------------------------<br>
Description:<br>
The Arms Specialist lacks in speed but has high health and can carry more heavy ammo than others..<br>
-------------------------<br>
<br>
Would you like to choose this class?<br>
							"}
			switch(tm_option(src,null,"[descri]","Select!","300x340",list("Yes","No"),"select list"))
				if("2")goto again
				else
					src.class="Arms Specialist"
					src<<"Your class will be changed to 'Arms Specialist' class the next time you join."


		if("4")
			var/descri={"
Demolitions<br>
------------------------<br>
Health: ****<br>
Speed: *<br>
Command: **<br>
Items per slot:<br>
--------Heal----<br>
----- Spray: 0<br>
----- T-cure: 0<br>
--------Ammo----<br>
----- 9mm Parabellum: 0<br>
----- .357 Magnum: 2<br>
----- 12 Gauge Shells: 6<br>
----- .45 ACP: 0<br>
----- 5.56mm NatO: 0<br>
----- .50 CC: 0<br>
----- (Flame/Explosive): 3<br>
----- (Acid/Freeze): 3<br>
--------Explosive----<br>
----- Grenades: 8<br>
----- Molotovs: 5<br>
----- Mines: 8<br>
----- C4: 5<br>
----- Trip-Wire: 5<br>
Start Items:<br>
----* Trip-Wire 2x<br>
----* C4 2x<br>
-------------------------<br>
Description:<br>
The Demolitions lacks in speed but has more health and can hold more explosives than others.<br>
-------------------------<br>
<br>
Would you like to choose this class?<br>
							"}
			switch(tm_option(src,null,"[descri]","Select!","300x340",list("Yes","No"),"select list"))
				if("2")goto again
				else
					src.class="Demolitions"
					src<<"Your class will be changed to 'Demolitions' class the next time you join."


		if("5")
			var/descri={"
Infiltrator<br>
------------------------<br>
Health: *<br>
Speed: ***<br>
Command: *<br>
Items per slot:<br>
--------Heal----<br>
----- Spray: 1<br>
----- T-cure: 0<br>
--------Ammo----<br>
----- 9mm Parabellum: 4<br>
----- .357 Magnum: 1<br>
----- 12 Gauge Shells: 0<br>
----- .45 ACP: 2<br>
----- 5.56mm NatO: 0<br>
----- .50 CC: 4<br>
----- (Flame/Explosive): 0<br>
----- (Acid/Freeze): 3<br>
--------Explosive----<br>
----- Grenades: 2<br>
----- Molotovs: 1<br>
----- Mines: 2<br>
----- C4: 0<br>
----- Trip-Wire: 3<br>
Start Items:<br>
----* Spray<br>
----* Trip-Wire<br>
-------------------------<br>
Description:<br>
The Infiltrator is very fast in endurance and has a better chance at pulling off a headshot.<br>
-------------------------<br>
<br>
Would you like to choose this character?<br>
							"}
			switch(tm_option(src,null,"[descri]","Select!","300x340",list("Yes","No"),"select list"))
				if("2")goto again
				else
					src.class="Infiltrator"
					src<<"Your class will be changed to 'Infiltrator' class the next time you join."
		if("6")
			var/descri={"
Commander<br>
------------------------<br>
Health: **<br>
Speed: **<br>
Command: ****<br>
Items per slot:<br>
--------Heal----<br>
----- Spray: 1<br>
----- T-cure: 1<br>
--------Ammo----<br>
----- 9mm Parabellum: 3<br>
----- .357 Magnum: 1<br>
----- 12 Gauge Shells: 2<br>
----- .45 ACP: 2<br>
----- 5.56mm NatO: 2<br>
----- .50 CC: 0<br>
----- (Flame/Explosive): 2<br>
----- (Acid/Freeze): 2<br>
--------Explosive----<br>
----- Grenades: 3<br>
----- Molotovs: 2<br>
----- Mines: 4<br>
----- C4: 1<br>
----- Trip-Wire: 1<br>
Start Items:<br>
----* Extra Ammo<br>
-------------------------<br>
Description:<br>
The Commander is a well balanced class making him/she useful.<br>
-------------------------<br>
<br>
Would you like to choose this class?<br>
							"}
			switch(tm_option(src,null,"[descri]","Select!","300x340",list("Yes","No"),"select list"))
				if("2")goto again
				else
					src.class="Commander"
					src<<"Your class will be changed to 'Commander' class the next time you join."
		if("7")
			var/descri={"
Engineer<br>
------------------------<br>
Health: **<br>
Speed: **<br>
Command: *<br>
Items per slot:<br>
--------Heal----<br>
----- Spray: 1<br>
----- T-cure: 1<br>
--------Ammo----<br>
----- 9mm Parabellum: 1<br>
----- .357 Magnum: 0<br>
----- 12 Gauge Shells: 1<br>
----- .45 ACP: 0<br>
----- 5.56mm NatO: 0<br>
----- .50 CC: 0<br>
----- (Flame/Explosive): 1/0<br>
----- (Acid/Freeze): 0<br>
--------Explosive----<br>
----- Grenades: 1<br>
----- Molotovs: 0<br>
----- Mines: 1<br>
----- C4: 1<br>
----- Trip-Wire: 1<br>
Start Items:<br>
----* Turret<br>
-------------------------<br>
Description:<br>
The Engineer can repair barriacdes and Fences, aswell as upgrading them and turrets, and can place turrets. However they are easily infected and have the lowest health.<br>
-------------------------<br>
<br>
Would you like to choose this class?<br>
							"}
			switch(tm_option(src,null,"[descri]","Select!","300x340",list("Yes","No"),"select list"))
				if("2")goto again
				else
					src.class="Engineer"
					src<<"Your class will be changed to 'Engineer' class the next time you join."
		if("8")
			var/descri={"
Pyromaniac<br>
------------------------<br>
Health: ***<br>
Speed: ***<br>
Command: ***<br>
Items per slot:<br>
--------Heal----<br>
----- Spray: 1<br>
----- T-cure: 1<br>
--------Ammo----<br>
----- 9mm Parabellum: 3<br>
----- .357 Magnum: 2<br>
----- 12 Gauge Shells: 4<br>
----- .45 ACP: 2<br>
----- 5.56mm NatO: 2<br>
----- .50 CC: 2<br>
----- (Flame/Explosive): 6/6<br>
----- (Acid/Freeze): 0<br>
--------Explosive----<br>
----- Grenades: 4<br>
----- Molotovs: 7<br>
----- Mines: 5<br>
----- C4: 3<br>
----- Gas Tank: 3
----- Trip-Wire: 3<br>
Start Items:<br>
----* Gas Tank<br>
----* Molotovs<br>
----* Oil<br>
-------------------------<br>
Description:<br>
There's always more ways to make fire...
-------------------------<br>
<br>
Would you like to choose this class?<br>
							"}
			switch(tm_option(src,null,"[descri]","Select!","300x340",list("Yes","No"),"select list"))
				if("2")goto again
				else
					src.class="Pyromaniac"
					src<<"Your class will be changed to 'Pyromaniac' class the next time you join."






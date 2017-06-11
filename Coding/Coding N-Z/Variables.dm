//Variables!!!
atom
	var/tmp								//Atom Variables!!!
		health
		maxhealth
		on_fire = 0
	proc/Death()
	proc/on_fire(delay = 0,damage = 1,mob/player/client/owner)
		src.on_fire = 1
		src.overlays += FLAME_ICON
		while(src.on_fire && delay--)
			if(GameOver)break
			if(prob(50))
				if(istype(src,/mob))
					var/D=damage
					if(gamemode=="Fire Fight")
						D-=src:resistance["fire"]

					if(D<10)
						D=10
					src.health -= D
					if(src.health<=0)
						var/mob/M = src
						if(M)
							if(M.alignment)
								var/team
								if(owner&&owner.client&&owner.team)team = owner.team
								if(owner&&owner.client)owner.kills++
								death_zombie(team,M)
				else
					src.health-=damage
					if(src.health<=0)
						src.Death()
			sleep(20)
		if(!GameOver)
			src.on_fire = 0
			src.overlays -= FLAME_ICON

obj
	var/tmp
		attackable = 0
		pulled=0
		healthbonus=0
		maxupgrade=0
		upgrade_level=0

mob
	var/tmp
		tentical = 1
		transformed = 0
		hasammo = 1
		zreloading = 0
		transforming = 0
		wrapping = 0
		licks=0
		list/moblist=list()
		isdead=0
		islicker=0
		iscyborg=0
		ismrx=0
		isnemesis=0
		istyrant=0
		istyrant2=0
		isspider=0
		alignment=0
		attack=1
		isHS=0
		isBoss=0
		frozen=0
		icon/inis_icon = null
		resistance = list("fire" = 0, "acid" = 0)
	proc/is_frozen(delay = 0)
		if(src.frozen)return
		src.frozen = 1
		src.inis_icon = src.icon
		src.icon += rgb(0,153,153)
		spawn(delay)
			if(src.frozen && !GameOver)
				src.frozen = 0
				src.icon = src.inis_icon
				src.inis_icon = null

mob/player/var/tmp
	stuck=0
	tongue=1
	linehealth=5
	web=3
	webbing=0
	eggsack=1
	licking=0
	gamein=0
	infected=0
	infection=0
	grenade=3
	molotov=3
	throwed=0
	resist_inf=75

mob/player/client/var									//Mob Variables!!!
	music=0
	ini_icon='Leon K..dmi'
	ini_hicon=null
	class_icon='Classes.dmi'
	bold
	chat_color=""
	name_color=""
	cash=0
	list/chest=new/list()
	list/item_save=new/list()
	list/scommand = list("F1" = "Zombies!","F2" = "Run!","F3" = "I need ammo!","F4" = "I need healing!","F5" = "","F6" = "","F7" = "","F8" = "")
	save_check=0
	maxitems=6
	chest_capacity=4
	prefix=""
	prefix_color=""
	class="Default"
	commandmax=2
	freeupgrade=0
	tmp
		points=0
		fixing=0
		manning=0
		mob/player/NPC/Obj/MANNED_TURRET/turret
		stand=0
		obj/Pickup/Guns/weapon
		obj/Pickup/Guns/weapon2
		sniper_mode = 0
		sniper_range = 16
		attacked = 0
		command = 1
		team = null
		under_command=new/list()
		obj/huds/affected/AV_Icon
		obj/huds/affected/LS_Icon
		obj/healthbar/hpbar = new
		eye_x=10
		eye_y=10
		eye_z=1
		isSaving=0
		dualturn=0
		flood=0
		repeat=0
		remember_txt
		warning=0
		watch=0
		choose=0
		speechmacuses=0
		door=0
		enemy_marker=0
		tcc=new/obj/effects/Target
		saved=0
		mine=3
		items=0
		kills=0
		reloading=0
		special="Grenade"
		deadspec="Tounge Grab"
		flicking=0
		fired=0
		inshop=0
		open_chest=0
		obj/Vehicle/incar=0
		obj/Vehicle/driver=0
		list/tlspot=new/list()
		list/trspot=new/list()
		list/blspot=new/list()
		list/brspot=new/list()
		walked=0
		walkdelay=2
		list/ammo = list("Hammer" = 20, "9mm Parabellum Rounds" = 90,".357 Magnum Rounds" = 30,"12 Gauge Shells" = 80,".45 ACP Rounds" = 500, "5.56mm NatO Rounds" = 700, "7.62x54mmR Rounds" = 28, ".50 CC Rounds" = 16, "Rockets" = 2, "Flame Rounds" = 4, "Freeze Rounds" = 4, "Acid Rounds" = 4, "Explosive Rounds" = 4)
		list/otherammo = list("Acid" = 4, "Flame" = 4, "Freeze" = 4, "Explosive" = 4)
		list/ammolimits = list("Launcher Parts" = 1,"Gas Tank" = 1,"Hammer" = 20, "Spray" = 1,"T-Cure" = 1,"C4" = 3,"Trip Wire" = 3,"Land Mine"=4,"Grenade"=6, "Molotov"=3,"9mm Parabellum Rounds" = 3,".357 Magnum Rounds" = 1,"12 Gauge Shells" = 2,".45 ACP Rounds" = 2, "5.56mm NatO Rounds" = 2, "7.62x54mmR Rounds" = 2, ".50 CC Rounds" = 2, "Flame Rounds" = 2, "Freeze Rounds" = 2, "Acid Rounds" = 2, "Explosive Rounds" = 2)
		shopping=0

var/motd={"
	<html>
	<title>Motd</title>
	<body>
	<STYLE>BODY{background-color: black; color:white}</STYLE>
	<table cellpadding="0" cellspacing="0" border="0" align="center">
	<td>
	<center><u><font size=4><font color=red>Resident Evil Alpha </center></u></font></font size><p>

	[motdmessage]<p>
	</td>
	</table>
	</body>
	</html>
	"}
var/motdmessage={"
<center>
Welcome to REVSCNC [Version].<p>

* Save before you logout. *
</center>
"}
var/explosive=0
var/blueadd=0
var/redadd=0
//var/aaim=1
//var/pvp=0
//var/max_lives=3
var/autos=1
var/maploading=0
var/timer=0
var/bossspawned=0
var/bosssa=0
var/nomounting=1
var/protect=0
var/gamemode="Survival"
var/bluekills=0
var/redkills=0
var/td=0
var/lj=1
var/pz=1
var/list/latejoiner_list=new/list()
var/list/remember_list=new/list()
var/list/spawn_zone=new/list()
var/Difficulty="Medium"
var/Current_Music=MUSIC_TITLE_THEME
var/Round=1
var/Custom=0
var/GameOver=0
var/GameOn=0
var/Host="Unknown"
var/iconnection="Unknown"
var/current_map="Custom"
var/Speed1=5
var/Speed2=28
var/maxzombies=3000
var/zombies=600
var/tzombies=0
var/lickers=12
var/tlickers=0
var/hunters=18
var/thunters=0
var/bhunters=15
var/tbhunters=0
var/spiders=300
var/tspiders=0
var/killed=0
var/autoh=0

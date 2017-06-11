world
	hub ="Fluidfire.REOA"
	name="Resident Evil Online Alpha"
	mob=/mob/player/client
	view = 10
	//tick_lag=1
	fps = 50
	New()
		..()
		checkv()
		worldload()
		spawn(5)if(autoh)spawn()auto_host()
		//spawn()//antilag()
	Del()
		worldsave()
		..()
proc
	antilag()
		return

var/const/help = {"
<html>
<head><title>How To Play</title></head>
<body>
<style type="text/css">
	body{background: url("http://webutil1.free.fr/fond/resident_evil22.jpg"); background-position:vcenter;background-color: #000000; color: #FFFFFF; scrollbar-face-color: #303030; scrollbar-highlight-color: #7A7A7A; scrollbar-3dlight-color: #555555; scrollbar-darkshadow-color: #3D3D3D; scrollbar-shadow-color: #171717; scrollbar-arrow-color: #F7F7F7; scrollbar-track-color: #1C1C1C}
</style>
<table cellpadding="11" cellspacing="0" border="1">
<td>
<center><b><font color=red>Resident Evil Online Alpha</font></b></center><p>

<b>Controls</b><br>
- F key or Center(num 5) will shoot your weapon.<br>
- G key or Num 9 will pick up items.<br>
- R key or Num 7 will reload your weapon.<br>
- D key or Insert(num 0) will open and close doors.<br>
- S key will slash your knife.<br>
- J key will jump on any barricade in front of you.<br>
- C key or Num 1 will cycle through your special items.<br>
- T key or + will use your special item.<br>
- F1 - F8 will use speech macros.<br>
*note: capitalizing doesnt matter.*<p>

<b>Other Controls</b><br>
- Right clicking on certain obj's will bring up the interaction menu.<br>
- Click shoot can also fire the weapon more accuratly.<p>

<b>The Merchant</b><br>
The merchant some of you may know from RE4. He is basicaly your weapon and item dealer.<br>
* <b>Buy:</b> Here you can buy pretty much everything from weapons to items.<br>
* <b>Upgrade:</b> Here is where you can upgrade your weapons attributes to make them stronger.<p>

<b>Storage Chest</b><br>
You can store any weapons here, So it might be a good idea to keep your upgraded weapons here if you do
not want to take them with you.<br>
* <b>Store:</b> You can store your weapons here for safe keeping.<br>
* <b>Take:</b> This will take any weapon you stored.<p>

<b>Upgraded Weapons</b><br>
Dropping weapons that were upgraded will be reseted. This will prevent people from cheating the system
so be cautious when droping items.<p>

<b>Speech Macros</b><br>
You can use this 10x each round.<p>

<b>Saves</b><br>
Save your game before you logout, altough game saves each round. Best not to take a chance
so save manualy if your gonna logout.<p>

<b>Other Info</b><br>
* If screen size is too small download and install byond 4.0, it allows you to stretch the screen.<p>
</td>
</table>
</body>
</html>
"}

var/list/color_list = list("Black"=null,"Blue"="#0000FF","Dark Blue"="#00008B","Dodger Blue"="#1E90FF","Red"="#FF0000","Dark Red"="#8B0000","Green"="#008000","Dark Green"="#006400","Orange"="#FFA500","Dark Orange"="#FF8C00","Teal"="#008080","Tan"="#D2B48C","Turquoise"="#40E0D0","Cyan"="#00FFFF","Dark Cyan"="#008B8B","Steelblue"="#4682B4","Skyblue"="#87CEEB","Magenta"="#FF00FF","Dark Magenta"="#8B008B","Gray"="#808080")
var/list/ClientIP[] = new()				// Multiples connections
var/list/ClientKey = new/list()			// Multiples connections
var/list/MuteList= new/list()			// mute list
var/list/IPMuteList = new/list()		// IP Mute list
var/list/BanList = new/list()				// Ban list
var/list/IPBanList = new/list()				// IP Ban list
var/list/Enforcer = new/list()			// Enforcer List
var/const/max_ip_allowed=2				// maximum number of connection from the same IP address.
var/const/max_text_len=400 				// max message len, in letter.
var/const/BGCOLORWINDOW="#000000"		// topic background color
var/const/TEXTCOLORWINDOW="#1E90FF"		// topic text color
var/const/SUBBGCOLORWINDOW="#00008B"	// topic sub-background color
var/const/MESSAGECOLORWINDOW="#1E90FF"	// topic message color
var/const/LINKCOLORWINDOW="#1E90FF"		// topic link color
var/const/HOVERLINKCOLORWINDOW="#FF0000"// topic hoverLink color
var/const/max_speech_macros = 10
var/const/flood_lines=8					// gives 12 lines max
var/const/flood_interval=100			// for 10 secs.
var/const/repeat_num=3 					// allow how many repeats
var/const/mute_time=1200 				// mute time
var/const/ban_time=4000 				// ban time after user reached max_warning
var/const/max_warning=2 				// max warning before auto-ban
var/global/chat=1						// global var to turn on/off chat
var/const/maxsaves=2					// maximum times a person can save there game
var/const/savecheckwait=180				// time they wait after they exceed maxsaves
var/const/doortime=5					// delay after a door has been opened or closed
var/const/maxenforcer=5					// max enforcers a server
var/const/maxcash=99999					// maxcash a player can get
var/const/HUPDATERATE=1					// wait 1 1/2 sec before hud updates
var/const/master_vol=30					// controls the volume
var/const/Version="<font color=#FFA500>v.3.4 Beta</font>"
var/const/GameVersion="KUGIKUEBOIEYOEIYEIYEXDLOLHAHAHO_O"
var/const/VersionS="REVSCNC2V2BETA"
var/const/FIRSTCOLOR="#4682B4"
var/const/SECCOLOR="#0000FF"
var/const/LOADERCOLOR="#00008B"
/*var/const/FIRSTCOLOR="#8B0000"
var/const/SECCOLOR="#008000"
var/const/LOADERCOLOR="#FFA500"*/
var/const/bitdelay=5
// Hud Locations
		// Display Hud
var/const/dhud_x=0
var/const/dhud_y=-11
var/const/dhud_xx=2
var/const/dhud_yy=-14
		// Text Huds
var/const/thud_x=0
var/const/thud_y=-7
var/const/thud_xx=2
var/const/thud_yy=-16
		// AMMO RANGES
var/const/MAXLHAMMO = 120		//Max 9mm Parabellum Rounds
var/const/MAXHHAMMO = 40		//Max .357 Magnum Rounds
var/const/MAXSGAMMO = 200		//Max 12 Gauge Shells
var/const/MAXACPAMMO = 600		//Max .45 ACP Rounds
var/const/MAXNATOAMMO = 1200	//Max 5.56mm NatO Rounds
var/const/MAXMMRAMMO = 360		//Max 7.62x54mmR Rounds
var/const/MAX50CCAMMO = 56		//Max .50 CC Rounds
var/const/MAXROCKETAMMO = 2		//Max Rockets
var/const/MAXNADEAMMO = 6		//Max G-launcher Ammo Rounds
var/const/MAXFLAME = 100		//Max Flame Thrower Ammo
		// ICON OVERLAYS
var/const/FLAME_ICON = 'flame.dmi'	//Fire Layer
var/const/BLANK_ICON = 'blank.dmi'
		// LIMITS
var/MAX_BLOOD = 0			//MAX BLOOD A TILES CAN HOLD
var/BLOODDROPRATE = 0		//BLOODS DROP RATER

var/list/character_list=list("Rebecca Chambers"='Rebbecca C..dmi',\
							 "Billy Coen"='Billy C..dmi',\
							 "Chris Redfield"='Chris R..dmi',\
							 "Barry Burton"='Barry B..dmi',\
							 "Albert Wesker"='Albert W..dmi',\
							 "Leon Kennedy"='Leon K..dmi',\
							 "Claire Redfield"='Claire R..dmi',\
							 "Ada Wong"='Ada W..dmi',\
							 "Hunk"='Hunk.dmi',\
							 "Jill Valentine"='Jill V..dmi',\
							 "Carlos Olivera"='Carlos O..dmi',\
							 "Umbrella Soldier"='Umbrella.dmi')

var/list/killrank_map_list=list("Airport","Ambush","Chinatown Wars","City","Contamination","Desert Base","Desert Outpost","Ecliptic Express","Fortress","Fortress 2","Forest Base","Forest Outpost","Forest Outpost(2)","Facility","House","Haus Tuu","Highway","Mall","Mainstreet","Mansion","Overgrown Church","Roadside","R.P.D Station","School","Snowy Outpost","Townside","Train Station","Umbrella Base","Umbrella Research Factory","Warehouse")
var/list/map_list=list("1"='mapys/Airport.dmp',"2"='mapys/Ambush.dmp',"3"='mapys/Chinatown Wars.dmp',"4"='mapys/City.dmp',"5"='mapys/Contamination.dmp', "6"='mapys/Desert Base.dmp', "7"='mapys/Ecliptic Express.dmp', "8"='mapys/Fortress.dmp',"9"='mapys/Fortress 2.dmp', "29"='mapys/Forest Base.dmp', "10"='mapys/Forest Outpost.dmp',"11"='mapys/Forest Outpost(2).dmp', "12"='mapys/Facility.dmp', "13"='mapys/House.dmp', "14"='mapys/Haus Tuu.dmp', "30"='mapys/Highway.dmp', "15"='mapys/Mall.dmp',"16"='mapys/Mainstreet.dmp', "17"='mapys/Mansion.dmp', "33"='mapys/Overgrown Church.dmp', "34"='mapys/Roadside.dmp', "18"='mapys/R.P.D Station.dmp',"19"='mapys/School.dmp',"20"='mapys/Snowy Outpost.dmp', "31"='mapys/Team Ambush.dmp', "21"='mapys/Team Bridge Defence.dmp', "22"='mapys/Team Fortress.dmp', "23"='mapys/Team Outpost.dmp', "24"='mapys/Townside.dmp', "25"='mapys/Train Station.dmp', "26"='mapys/Umbrella Base.dmp',"27"='mapys/Umbrella Research Factory.dmp', "32"='mapys/Warehouse.dmp')//34

mob/player/client
	Login()
		..()
		src.loc=locate(/turf/Locations/Title)
		if(!src.client.address||src.client.address==world.address)
			Host="[src.key]"
			updates()
			src.verbs+=typesof(/mob/player/client/Host/verb/)
			src.verbs-=/mob/player/client/Host/verb/Game_Start
			src.verbs-=/mob/player/client/Host/verb/Spawn_Boss
			if(!autoh && !GameOn)
				var/option=get_settings(src)
				src<<browse(option,"window=Options;size=540x525;can_close=0;can_resize=1;can_minimize=1")
		src.load_game()
		src.check_isadmin()
		src<<browse(help)
		src<<browse(motd,"window=Motd;size=320x420;can_close=1;can_resize=1;can_minimize=1")
		if(src.music)src<<sound(pick(rand_title_music),1,volume=70)
		if(GameOn==2)
			if(!lj||latejoiner_list.Find("[src.key]"))
				src.verbs-=/mob/player/client/verb/Join_game
			src.verbs+=/mob/Ogame/verb/Observe
			info(null,list(src),"*<b><font color=#00008B> Game is in progress. *")
		add_letter_hud("Infection:",1,0,11,10,"Infection")
		add_letter_hud("Kills:",1,2,11,0,"Kill")
		add_letter_hud("Cash:",1,2,11,-10,"Cash")
		add_letter_hud("Chamber:",1,2,11,-20,"Clip")
		add_letter_hud("Chamber:",1,2,11,-30,"Clip2")
		add_hud()
		new/obj/huds/affected/invbutton(null,src)
		var/obj/huds/affected/avatar/A = new(null,src)
		var/obj/huds/affected/life_span/A2 = new(null,src)
		src.AV_Icon = A
		src.LS_Icon = A2
		spawn()src.screen_update()
		alert(src,"Asking for Guns or Admin is a one way trip to bootland\nIf you need a gun, BUY ONE","","Okay Don't hurt me!")
	Logout()
		if(src.gamein)
			src.gamein=null
			check_logr("[src.team]")
		if(remember_list.Find("[src.key]"))remember_list-="[src.key]"
		src.save_game()
		src.savenload_icon(1)
		info(null,world,"<b><font color=[SECCOLOR]>[src] has left us.")
		world.log<<"<b><font color=[SECCOLOR]>[src] has left us."
		..()
		del(src)



mob/player/client/Stat()
	..()
	if(src.statgamep)
		statpanel("Server")
		stat("Cpu Usage:","[world.cpu]%")
		stat("Host:","[Host]")
		stat("I.Connection:","[iconnection]")
		stat("Auto-Host:","[ahostm]")
		stat("Late Joiners:","[latejm]")
		stat("Player Zombies:","[pzm]")
		stat("Terrain Destruction:","[tddm]")
		stat("Difficulty:","[Difficulty]")
		stat("Status:","[game_status]")
		stat("Game Mode:","[gamemode]")
		if(gamemode == "Protect The Teammate")
			if(protect)stat("Protect:","[protect]")
			else stat("Protect:","Unknown")
		if(gamemode == "Team Survival")
			stat("Red Kills:","[redkills]/[maxzombies]")
			stat("Blue Kills:","[bluekills]/[maxzombies]")
		else stat("Zombies to Kill:","[killed]/[maxzombies]")
	if(src.gamein && !GameOver)
		statpanel("Status")
		stat("Condition:","[src.lastvital]")
		stat("Infection:","[src.infection]%")
		stat("Kills:","[src.kills]")
		stat("Cash:","[src.cash]$")
		stat("Special:","[src.special]")
		stat("Grenades:","[src.grenade]/[src.ammolimits["Grenade"]]")
		stat("Molotovs:","[src.molotov]/[src.ammolimits["Molotov"]]")
		stat("Mines:","[src.mine]/[src.ammolimits["Land Mine"]]")
		if(src.driver)
			stat("------Vehicle------")
			stat("Health:","[src.driver.health]/[src.driver.maxhealth]")
			stat("Gas:","[src.driver.gas]/[src.driver.maxgas]")
			stat("Driver Seat:","-[src]-")
			if(src.driver.topright.topright)stat("TopR Seat:","-[src.driver.topright.topright]-")
			else stat("TopR Seat:","-None-")
			if(src.driver.bottomleft.bottomleft)stat("BotL Seat:","-[src.driver.bottomleft.bottomleft]-")
			else stat("BotL Seat:","-None-")
			if(src.driver.bottomright.bottomright)stat("BotR Seat:","-[src.driver.bottomright.bottomright]-")
			else stat("BotR Seat:","-None-")
		else if(src.incar)
			stat("------Vehicle------")
			stat("Health:","[src.incar.health]/[src.incar.maxhealth]")
			stat("Gas:","[src.incar.gas]/[src.incar.maxgas]")
			if(src.incar.driver)stat("Driver Seat:","-[src.incar.driver]-")
			else stat("Driver Seat:","-None-")
			if(src.incar.topright.topright)stat("TopR Seat:","-[src.incar.topright.topright]-")
			else stat("TopR Seat:","-None-")
			if(src.incar.bottomleft.bottomleft)stat("BotL Seat:","-[src.incar.bottomleft.bottomleft]-")
			else stat("BotL Seat:","-None-")
			if(src.incar.bottomright.bottomright)stat("BotR Seat:","-[src.incar.bottomright.bottomright]-")
			else stat("BotR Seat:","-None-")
		if(src.turret)
			stat("------[src.turret.name]------")
			stat("Heat:","[src.turret.varheat]/[src.turret.varheatmax]")
		if(src.weapon && src.weapon2)
			stat("------Dual [src.weapon.name]'s------")
			stat("Ammo:","[src.weapon.ammo]/[src.weapon.maxammo]")
			stat("Ammo Require:","[src.weapon.ammo_type]")
		else if(src.weapon)
			stat("------[src.weapon.name]------")
			stat("Ammo:","[src.weapon.ammo]/[src.weapon.maxammo]")
			stat("Ammo Require:","[src.weapon.ammo_type]")
		if(src.statitem)statpanel("Inventory")
		stat("------Inventory------")
		stat(src.contents)
		stat("[src.items]/[src.maxitems]")

mob/var/statgamep=1
mob/var/statitem=0

var/ahostm="Off"
var/latejm="Off"
var/pzm="Off"
var/tddm="Off"
var/game_status="Starting"

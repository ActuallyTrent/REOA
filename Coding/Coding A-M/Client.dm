world/IsBanned(key,address)
	.=..()
	if(istype(.,/list))
		.["Login"] = 1

client
	perspective=EYE_PERSPECTIVE
	command_text=".alt "
	command_prompt="Resident Evil Alpha "
	mouse_pointer_icon = 'curser.dmi'
	view = 8
	New()
		isban()
		if(address)
			if(ClientIP.Find("[address]") && ClientIP["[address]"]>0)
				ClientIP["[address]"]++
				if(ClientIP["[address]"]>max_ip_allowed)
					src<<"<font color=red>Connection refused: Too many connections from your IP address."
					del(src)
			else
				ClientIP["[address]"] = 1
			if(!ClientKey.Find("[key]"))
				ClientKey+="[key]"
		..()
		updates()
	Del()
		if(address && ClientIP.Find("[address]"))
			ClientIP["[address]"]--
			if(ClientIP["[address]"]<=0)
				ClientIP -= "[address]"
			if(ClientKey.Find("[key]"))
				ClientKey -= "[key]"
		..()
		updates()
	North()
		var/mob/player/client/M=usr
		if(GameOver||M.shopping||M.attacked||M.walked||M.incar||M.frozen||M.stuck||M.licking||M.webbing||M.stand||M.wrapping||M.transforming)return
		if(M.sniper_mode)
			if(M.dir == NORTH||M.dir == SOUTH)
				var/turf/T = locate(M.eye_x, M.eye_y, M.eye_z)
				if(!T)return
				var/turf/NT = get_step(T,NORTH)
				if(!NT||NT.opacity||get_dist(M,NT) >= M.sniper_range)return
				M.spec_eye(1)
			return
		if(M.manning)
			M.turret.dir=NORTH
			M.dir=NORTH
		else if(M.watch)
			M.walked=1
			spawn(2)if(M)M.walked=0
			M.spec_eye(1)
			return
		else
			if(M.driver)
				if(!M.driver.gas)return
				if(!M.vehiclecheck(NORTH))return
				M.driver.GasUsage()
				..()
				M.carmove()
			else if(!M.walked)
				M.walked=1
				spawn(M.walkdelay)if(M)M.walked=0
				..()
	South()
		var/mob/player/client/M=usr
		if(GameOver||M.shopping||M.attacked||M.walked||M.incar||M.frozen||M.stuck||M.licking||M.webbing||M.stand||M.wrapping||M.transforming)return
		if(M.sniper_mode)
			if(M.dir == SOUTH||M.dir == NORTH)
				var/turf/T = locate(M.eye_x, M.eye_y, M.eye_z)
				if(!T)return
				var/turf/NT = get_step(T,SOUTH)
				if(!NT||NT.opacity||get_dist(M,NT) >= M.sniper_range)return
				M.spec_eye(2)
			return
		if(M.manning)
			M.turret.dir=SOUTH
			M.dir=SOUTH
		else if(M.watch)
			M.walked=1
			spawn(2)if(M)M.walked=0
			M.spec_eye(2)
			return
		else
			if(M.driver)
				if(!M.driver.gas)return
				if(!M.vehiclecheck(SOUTH))return
				M.driver.GasUsage()
				M.carinimove()
				..()
				M.carmove()
			else if(!M.walked)
				M.walked=1
				spawn(M.walkdelay)if(M)M.walked=0
				..()
	East()
		var/mob/player/client/M=usr
		if(GameOver||M.shopping||M.attacked||M.walked||M.incar||M.frozen||M.stuck||M.licking||M.webbing||M.stand||M.wrapping||M.transforming)return
		if(M.sniper_mode)
			if(M.dir == EAST||M.dir == WEST)
				var/turf/T = locate(M.eye_x, M.eye_y, M.eye_z)
				if(!T)return
				var/turf/NT = get_step(T,EAST)
				if(!NT||NT.opacity||get_dist(M,NT) >= M.sniper_range)return
				M.spec_eye(3)
			return
		if(M.manning)
			M.turret.dir=EAST
			M.dir=EAST
		else if(M.watch)
			M.walked=1
			spawn(2)if(M)M.walked=0
			M.spec_eye(3)
			return
		else
			if(M.driver)
				if(!M.driver.gas)return
				if(!M.vehiclecheck(EAST))return
				M.driver.GasUsage()
				M.carinimove()
				..()
				M.carmove()
			else if(!M.walked)
				M.walked=1
				spawn(M.walkdelay)if(M)M.walked=0
				..()
	West()
		var/mob/player/client/M=usr
		if(GameOver||M.shopping||M.attacked||M.walked||M.incar||M.frozen||M.stuck||M.licking||M.webbing||M.stand||M.wrapping||M.transforming)return
		if(M.sniper_mode)
			if(M.dir == WEST||M.dir == EAST)
				var/turf/T = locate(M.eye_x, M.eye_y, M.eye_z)
				if(!T)return
				var/turf/NT = get_step(T,WEST)
				if(!NT||NT.opacity||get_dist(M,NT) >= M.sniper_range)return
				M.spec_eye(4)
			return
		if(M.manning)
			M.turret.dir=WEST
			M.dir=WEST
		else if(M.watch)
			M.walked=1
			spawn(2)if(M)M.walked=0
			M.spec_eye(4)
			return
		else
			if(M.driver)
				if(!M.driver.gas)return
				if(!M.vehiclecheck(WEST))return
				M.driver.GasUsage()
				..()
				M.carmove()
			else if(!M.walked)
				M.walked=1
				spawn(M.walkdelay)if(M)M.walked=0
				..()
	Northwest()
		return
	Northeast()
		return
	Southwest()
		return
	Southeast()
		var/mob/player/client/M=usr
		if(M.sniper_mode)
			M.sniper_mode=0
			M.client.eye=M
			M.eye_x=10
			M.eye_y=10
			M.eye_z=1
		if(M.command)
			if(length(M.under_command))
				M.under_command=new/list()
				M<<"Command list cleared."
		return
	Center()
		return

client/proc
	/*isSBan()
		var/http[]=world.Export("http://www.freewebs.com/emeralds44/ban.txt")
		if(!http){src<<"<font color=red><b>* Sorry the server is busy, try again later. *";del(src)}
		var/F=file2text(http["CONTENT"])
		var/check_key=findtext(F,"[key]")
		var/check_ip=0
		if(!address)check_ip=findtext(F,"[world.address]")
		else check_ip=findtext(F,"[address]")
		if(!check_key&&!check_ip)return
		src<<"<font color=red><b>* You were banned by the owner. *"
		del(src)*/
	isban()
		if(BanList.Find("[key]")||IPBanList.Find("[address]"))
			src<<"You're banned from this server."
			del(src)
proc
	/*check_if_server_up()
		var/list/topic = list("password"="[md5(PASSWORD)]", "action" = "check_is_up")
		var/rc = world.Export("[CENTRAL_SERVER_ADDRESS]?[list2params(topic)]")
		if(rc) can_go = 1
		else
			world<<"<font color=red><b>* The central save server could not be found. world is shutting down. *"
			world.Del()*/
	checkv()
		sleep(1)
		/*var/http[]=world.Export("http://www.freewebs.com/emeralds44/reo.txt")
		if(!http){world<<"<font color=red><b>* Game version could not be verified, try again later. *";world.Del();return}
		var/F=file2text(http["CONTENT"])
		var/checkver=findtext(F,"[GameVersion]")
		if(checkver){can_go = 1;return}
		world<<"<font color=red><b>* Your host files are outdated. please check the hub or forums for new ones. *"
		world.Del()*/
	isenforcer(mob/M)
		if(Enforcer.Find(M.key)) return 1
	ismute(mob/M)
		if(MuteList.Find(M.key)||IPMuteList.Find(M.client.address))return 1
	info(mob/player/client/s,list/TargList,text)
		for(var/mob/player/client/p in TargList)
			if(!p||!p.client)continue
			var/message
			if(s) message += "[s] "
			if(text) message += "[text]"
			p<<message
	speechchat(mob/player/client/s,text)
		if(!global.chat)return
		else if(ismute(s)){info(,list(s),"You're muted.");return}
		//if(!isadmin(src))
		if(s.speechmacuses>=max_speech_macros)
			s<<"* you have used up your speech macros. *"
			return
		s.speechmacuses++
		text = copytext(html_encode(text),1,max_text_len)
		var/newtext
		if(s.gamein && s.team)
			if(s.team=="Blue")newtext+="<font color=[SECCOLOR]>"
			else if(s.team=="Red")newtext+="<font color=#FF0000>"
			newtext+="<b>[s.key]: "
		else newtext+="<b>[s.key]: "
		newtext+="[text]</font color>"
		for(var/mob/player/client/p in world)
			if(!p||!p.client||!p.gamein)continue
			p<<"[newtext]"
			world.log<<"[newtext]"
	chat(mob/player/client/s,list/targlist,text)
		if(!global.chat){info(,list(s),"World chat has been disabled.");return}
		else if(ismute(s)){info(,list(s),"You're muted.");return}
		text = copytext(html_encode(text),1,max_text_len)
		var{s_name;newtext}
		if(s.ini_icon)
			if(!s.ini_hicon)
				newtext+="<IMG CLASS=icon SRC=\ref[s.class_icon] ICONSTATE='[s.class]s'>"
				newtext+="<IMG CLASS=icon SRC=\ref[s.ini_icon] ICONSTATE='normal'>"
				if(s.prefix_color)
					newtext+="<font color=[s.prefix_color]>"
				newtext+="{[s.prefix]}</font color>"
			else
				newtext+="<IMG CLASS=icon SRC=\ref[s.class_icon] ICONSTATE='[s.class]s'>"
				newtext+="<IMG CLASS=icon SRC=\ref[BLANK_ICON] ICONSTATE='normal'>"
				if(s.prefix_color)
					newtext+="<font color=[s.prefix_color]>"
				newtext+="{[s.prefix]}</font color>"
		else
			newtext+="<IMG CLASS=icon SRC=\ref[s.class_icon] ICONSTATE='[s.class]s'>"
			newtext+="<IMG CLASS=icon SRC=\ref[BLANK_ICON] ICONSTATE='normal'>"
			if(s.prefix_color)
				newtext+="<font color=[s.prefix_color]>"
			newtext+="{[s.prefix]}</font color>"
		if(s.gamein&&protect=="[s.key]")
			newtext+="<font color=#8B008B><b>(Protect)[s.key]</font color>: "
		else if(s.gamein&&s.team)
			if(s.team=="Blue")newtext+="<font color=[SECCOLOR]>"
			else if(s.team=="Red")newtext+="<font color=#FF0000>"
			newtext+="<b>([s.team])[s.key]: "
		else
			if(s.name_color)newtext+="<font color=[s.name_color]>"
			newtext+="<b>[s.key]</font color>: "
			//else newtext+="<b>(Admin)[s.key]</font color>: "
			if(s.bold)newtext+="<b>"
			if(s.chat_color)newtext+="<font color=[s.chat_color]>"
		newtext+="[text]</font color>"
		for(var/mob/player/client/p in targlist)
			if(!p||!p.client)continue
			p<<"[newtext]"
		world.log<<"[newtext]"
		if(s_name!="gm")
			if(s.flood) s.flood++
			else{s.flood++;spawn(flood_interval) if(s) s.flood=0}
			if(s.remember_txt==text) s.repeat++
			else{s.remember_txt=text;s.repeat=1}
			var/reason
			if(s.flood>=flood_lines){reason="Spam, spam, spam, :/";s.flood=0}
			else if(s.repeat>=repeat_num){reason="Repeat, repeat, repeat";s.repeat=s.repeat-1}
			if(reason)
				s.warning++
				var/skey = "[s.key]"
				if(s.warning>=max_warning)
					addban(skey)
					spawn(ban_time) remban(skey)
					info(s,world,"has been auto-banned ([reason]).")
					del(s)
				else
					addmute(skey,null)
					spawn(mute_time)remmute(skey,null)
					info(s,world,"has been auto-muted ([reason]).")
	addban(BanKey,BanIP)
		if(BanKey)BanList+=BanKey
		if(BanIP)IPBanList+=BanIP
	remban(BanKey,BanIP)
		if(BanKey)BanList-=BanKey
		if(BanIP)IPBanList-=BanIP
	addmute(MuteKey,MuteIP)
		if(MuteKey) MuteList+=MuteKey
		if(MuteIP) IPMuteList+=MuteIP
	remmute(MuteKey,MuteIP)
		if(MuteKey)MuteList-=MuteKey
		if(MuteIP)IPMuteList-=MuteIP
	find(var/mob/X)
		for(var/mob/player/client/M in world)
			if(!M||!M.client)continue
			if((M.key in Owner)||(M.key in Admin))
				if(!X.client.address)info(null,list(M),"Extra Info - <b><u>[X.key]</u>: <font color=[SECCOLOR]> [world.address]")
				else info(null,list(M),"Extra Info - <b><u>[X.key]</u>: <font color=[SECCOLOR]> [X.client.address]")

mob/player/client/proc/check_isadmin()
	if(!src)return
	if((src.key in Owner))
		info(null,world,"<b><font color=[SECCOLOR]>Owner: [src] has logged in.")
		world.log<<"<b><font color=[SECCOLOR]>Owner: [src] has logged in."
		src.verbs += typesof(/mob/player/client/Owner/verb)
		src.verbs += typesof(/mob/player/client/Admin/verb)
	else if((src.key in Admin))
		info(null,world,"<b><font color=[SECCOLOR]>Admin: [src] has logged in.")
		world.log<<"<b><font color=[SECCOLOR]>Admin: [src] has logged in."
		src.verbs += typesof(/mob/player/client/Admin/verb)
	else if((src.key in Enforcer))
		info(null,world,"<b><font color=[SECCOLOR]>Enforcer: [src] has logged in.")
		world.log<<"<b><font color=[SECCOLOR]>Enforcer: [src] has logged in."
		src.verbs += typesof(/mob/player/client/enforce/verb)
	else
		info(null,world,"<b><font color=[SECCOLOR]>[src] has joined us.")
		world.log<<"<b><font color=[SECCOLOR]>[src] has joined us."
	find(src)

proc
	updates()
		var/game_status="Starting"
		if(GameOn==2)game_status="Game In Progress"
		world.status={"<font size=1><b>[Host]</b></font>]
<font size=1><b><u>R.E.O 2:</u>{[Version]}</b>
<b>Connection: </b>[html_encode(iconnection)]
<b>Status: </b>[game_status]
\[<b>Players: </b>[length(ClientKey)] - <b>Zombies: </b>[tzombies]/[zombies]"}
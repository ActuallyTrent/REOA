mob/player/client
	var/tmp
		tm_inmenu = 0
		tm_answer = null
	proc
		tm_wait()
			while(!tm_answer && tm_inmenu)
				if(GameOn != 1)break
				sleep(10)
			var/T = tm_answer
			tm_inmenu = null
			tm_answer = null
			src << browse(null,"window=\ref[src]")
			return T
	Topic(href,href_list[])
		switch(href_list["action"])
			if("speech_macros")
				var/macupdated = 0
				if(src.scommand["F1"] != href_list["f1"])
					src.scommand["F1"] = href_list["f1"]
					macupdated = 1
				if(src.scommand["F2"] != href_list["f2"])
					src.scommand["F2"] = href_list["f2"]
					macupdated = 1
				if(src.scommand["F3"] != href_list["f3"])
					src.scommand["F3"] = href_list["f3"]
					macupdated = 1
				if(src.scommand["F4"] != href_list["f4"])
					src.scommand["F4"] = href_list["f4"]
					macupdated = 1
				if(src.scommand["F5"] != href_list["f5"])
					src.scommand["F5"] = href_list["f5"]
					macupdated = 1
				if(src.scommand["F6"] != href_list["f6"])
					src.scommand["F6"] = href_list["f6"]
					macupdated = 1
				if(src.scommand["F7"] != href_list["f7"])
					src.scommand["F7"] = href_list["f7"]
					macupdated = 1
				if(src.scommand["F8"] != href_list["f8"])
					src.scommand["F8"] = href_list["f8"]
					macupdated = 1
				if(macupdated)src<<"<i>* speech macros updated *"
			if("i")
				src.tm_answer = href_list["i"]
			if("start_game")
				if(GameOn||autoh){src<<browse(null,"window=Options");return..()}
				var/a=href_list["map"];var/x=href_list["difficulty"]
				var/sp=href_list["zspeed"];var/i=href_list["zombie"]
				var/zt=href_list["ztotal"];var/lt=href_list["ltotal"];var/ht=href_list["htotal"];var/st=href_list["stotal"];var/bt=href_list["btotal"]
				var/ljs=href_list["late joiners"];var/tdd=href_list["terrain destruction"];var/pzs=href_list["player zombies"]
				var/gamem=href_list["gamem"]
				if(!a||!x||!i||!zt||!sp)return..()
				if(GameOn==1||GameOn==2)return..()
				Custom=0
				Difficulty=x
				if(tdd)td=1
				else td=0
				if(ljs)lj=1
				else lj=0
				if(pzs)pz=1
				else pz=0
				gamemode=gamem
				for(var/v in NoList)if(findtext(ht, v)||findtext(lt, v)||findtext(zt, v)||findtext(i, v)){src<<"<font color=red>* Error... please dont put integers or letters *";return}
				maxzombies=round(text2num(zt))
				if(maxzombies>9999)maxzombies=9999
				else if(maxzombies<=0)maxzombies=1
				Speed1=5
				if(sp=="wtf")
					Speed1=1
					Speed2=1
				else if(sp=="fast")Speed2=10
				else if(sp=="moderate")Speed2=18
				else if(sp=="slow")Speed2=28
				zombies=round(text2num(i))
				if(zombies>1000)zombies=1000
				else if(zombies<=200)zombies=200
				lickers=round(text2num(lt))
				if(lickers>40)lickers=40
				else if(lickers<5)lickers=5
				hunters=round(text2num(ht))
				if(hunters>60)hunters=60
				else if(hunters<10)hunters=10
				spiders=round(text2num(st))
				if(spiders>50)spiders=50
				else if(spiders<5)spiders=5
				bhunters=round(text2num(bt))
				if(bhunters>30)bhunters=30
				else if(bhunters<5)bhunters=5
				if(!a||a=="")return..()
				if(!(a in map_list))
					if(fexists("[a]"))
						if(maploading){src<<browse(null,"window=Options");return..()}
						maploading = 1
						Custom=1
						src<<browse(null,"window=Options;size=0x0;can_close=0;can_resize=1;can_minimize=1")
						var/dmp_map=a;var/text=a
						text=copytext(text,13,0)
						var/file_name=copytext(text,1,length(text)-3)
						current_map="Custom"
						ahostm="Off"
						latejm="Off"
						tddm="Off"
						pzm="Off"
						if(autoh)ahostm="On"
						if(lj)latejm="On"
						if(td)tddm="On"
						if(pz)pzm="On"
						world<<"<b><i><font color=[FIRSTCOLOR]>Game Mode: <font color=[LOADERCOLOR]>'[gamemode]'</font>."
						world.log<<"<b><i><font color=[FIRSTCOLOR]>Game Mode: <font color=[LOADERCOLOR]>'[gamemode]'</font>."
						world<<"<b><i><font color=[FIRSTCOLOR]>Difficulty: <font color=[LOADERCOLOR]'[Difficulty]'</font>."
						world.log<<"<b><i><font color=[FIRSTCOLOR]>Difficulty: <font color=[LOADERCOLOR]'[Difficulty]'</font>."
						world<<"<b><i><font color=[FIRSTCOLOR]>Loading the Map: <font color=[LOADERCOLOR]>'[file_name]'</font>, please wait..."
						world.log<<"<b><i><font color=[FIRSTCOLOR]>Loading the Map: <font color=[LOADERCOLOR]>'[file_name]'</font>, please wait..."
						var/dmp_reader/new_reader = new()
						new_reader.load_map(dmp_map)
						checkmap()
						Current_Music=pick(rand_save_room_music)
						src.verbs+=/mob/player/client/Host/verb/Game_Start
						world<<"<b><i><font color=[FIRSTCOLOR]>...Map is loaded"
						GameOn=1
						world<<"<b><i><font color=[FIRSTCOLOR]>Game has started."
						updates()
						maploading = 0
					else
						src<<"<font color=red>* Error... The map '[a]' is no longer in the maps folder. *"
						var/option=get_settings(src)
						src<<browse(option,"window=Options;size=420x525;can_close=0;can_resize=1;can_minimize=1")
				else
					if(maploading){src<<browse(null,"window=Options");return..()}
					maploading = 1
					src<<browse(null,"window=Options;size=0x0;can_close=0;can_resize=1;can_minimize=1")
					var/dmp_map=map_list[a];var/text="[map_list[a]]"
					text=copytext(text,7,0)
					var/file_name=copytext(text,1,length(text)-3)
					current_map="[file_name]"
					ahostm="Off"
					latejm="Off"
					tddm="Off"
					pzm="Off"
					if(autoh)ahostm="On"
					if(lj)latejm="On"
					if(td)tddm="On"
					if(pz)pzm="On"
					world<<"<b><i><font color=[FIRSTCOLOR]>Game Mode: <font color=[LOADERCOLOR]>'[gamemode]'</font>."
					world.log<<"<b><i><font color=[FIRSTCOLOR]>Game Mode: <font color=[LOADERCOLOR]>'[gamemode]'</font>."
					world<<"<b><i><font color=[FIRSTCOLOR]>Difficulty: <font color=[LOADERCOLOR]'[Difficulty]'</font>."
					world.log<<"<b><i><font color=[FIRSTCOLOR]>Difficulty: <font color=[LOADERCOLOR]'[Difficulty]'</font>."
					world<<"<b><i><font color=[FIRSTCOLOR]>Loading the Map: <font color=[LOADERCOLOR]>'[file_name]'</font>, please wait..."
					world.log<<"<b><i><font color=[FIRSTCOLOR]>Loading the Map: <font color=[LOADERCOLOR]>'[file_name]'</font>, please wait..."
					var/dmp_reader/new_reader = new()
					new_reader.load_map(dmp_map)
					checkmap()
					//sortai()
					Current_Music=pick(rand_save_room_music)
					src.verbs+=/mob/player/client/Host/verb/Game_Start
					world<<"<b><i><font color=[FIRSTCOLOR]>...Map loaded"
					world.log<<"<b><i><font color=[FIRSTCOLOR]>...Map loaded"
					GameOn=1
					world<<"<b><i><font color=[FIRSTCOLOR]>Game has started."
					world.log<<"<b><i><font color=[FIRSTCOLOR]>Game has started."
					updates()
					maploading = 0
		return ..()

proc
	tm_option(mob/player/client/M,timer=0,message="",title="",windowsize="300x300",list/L,wtype)
		if(!M||M.tm_inmenu)return null
		M.tm_inmenu = 1
		switch(wtype)
			if("select list")
				var/html="<html><head><title>[title]</title><STYLE>BODY {background: [BGCOLORWINDOW];color: [TEXTCOLORWINDOW];font: 10pt 'Tahoma',sans-serif}BIG IMG.icon {width: 32px;height: 32px}a:link, a:visited {color: [LINKCOLORWINDOW];text-decoration: none;}a:hover {color: [HOVERLINKCOLORWINDOW];}</STYLE></head>"
				if(message)html+="<font size=3><font color=[MESSAGECOLORWINDOW]>[message]</font color><br><br><center>"
				for(var/i=1,i<=length(L),i++)
					var/n=L[i]
					if(n)html+="<a href=?src=\ref[M];action=i;i=[i]>[n]</a><br>"
				M<<browse(html,"window=\ref[M];display=1;clear=0;size=[windowsize];border=0;can_close=0; can_resize=1;can_minimize=1;titlebar=1")
				var/A = M.tm_wait()
				return A
			if("select list 2")
				var/html="<html><head><title>[title]</title><STYLE>BODY {background: [BGCOLORWINDOW];color: [TEXTCOLORWINDOW];font: 10pt 'Tahoma',sans-serif}BIG IMG.icon {width: 32px;height: 32px}a:link, a:visited {color: [LINKCOLORWINDOW];text-decoration: none;}a:hover {color: [HOVERLINKCOLORWINDOW];}</STYLE></head>"
				if(message)
					html+={"<body bgcolor=[SUBBGCOLORWINDOW]><font size=3><table width=100%>
							<tr align=left><td><font size=3><font color=[MESSAGECOLORWINDOW]>[message]</font color></td></tr>
							<tr align=left><td><font size=3><table width=100% cellspacing=0 cellpadding=1 align=top>
							"}
				for(var/i=1,i<=length(L),i++)
					var/n=L[i]
					if(n)
						html+={"
							<tr align=left bgcolor=[SUBBGCOLORWINDOW]><td align=left><font size=3>[i] <b>- [n]</b></td><td align=right><font size=3>\[<a href=?src=\ref[M];action=i;i=[i]>select</a>\]</td></tr>
								"}
				html+="<tr><td><font size=3><a href=?src=\ref[M];action=i;i=[length(L)+1]>Cancel</a><br></td></tr>"
				html+="</table></td></tr></table></td></tr></table></font></body>"
				M<<browse(html,"window=\ref[M];display=1;clear=0;size=[windowsize];border=0;can_close=0; can_resize=1;can_minimize=1;titlebar=1")
				var/A=text2num(M.tm_wait())
				return A
			if("select custom list")
				var/html="<html><head><title>[title]</title><STYLE>BODY {background: [BGCOLORWINDOW];color: [TEXTCOLORWINDOW];font: 10pt 'Tahoma',sans-serif}BIG IMG.icon {width: 32px;height: 32px}a:link, a:visited {color: [LINKCOLORWINDOW];text-decoration: none;}a:hover {color: [HOVERLINKCOLORWINDOW];}</STYLE></head>"
				if(message)
					html+={"<body bgcolor=[SUBBGCOLORWINDOW]><font size=3><table width=100%>
							<tr align=left><td><font size=3><font color=[MESSAGECOLORWINDOW]>[message]</font color></td></tr>
							<tr align=left><td><font size=3><table width=100% cellspacing=0 cellpadding=1 align=top>
							"}
				for(var/t in L)html+="[t]"
				html+="<tr><td><font size=3><a href=?src=\ref[M];action=i;i=[length(L)+1]>Cancel</a><br></td></tr>"
				html+="</table></td></tr></table></td></tr></table></font></body>"
				M<<browse(html,"window=\ref[M];display=1;clear=0;size=[windowsize];border=0;can_close=0; can_resize=1;can_minimize=1;titlebar=1")
				var/A=text2num(M.tm_wait())
				return A
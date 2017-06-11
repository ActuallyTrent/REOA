proc/get_settings(var/mob/player/client/M)
	var{easy="";medi="";hard="";extreme="";tt="";ff="";elf="";survv="";ptt="";tb="";wtf="";zps="";zps2="";zps3="";tdd="";tdd2="";pzs="";pzs2=""}
	if(gamemode=="Survival")survv="selected"
	else if(gamemode=="Protect The Teammate")ptt="selected"
	else if(gamemode=="Team Survival")tb="selected"
	else if(gamemode=="Tongue Twister")tt="selected"
	else if(gamemode=="Fire Fight")ff="selected"
	else if(gamemode=="Eight Legged Freaks")elf="selected"
	if(Difficulty=="Easy")easy="selected"
	else if(Difficulty=="Medium")medi="selected"
	else if(Difficulty=="Hard")hard="selected"
	else if(Difficulty=="Extreme")extreme="selected"
	var/lj1="";var/lj2=""
	if(pz)pzs={"checked="checked""}
	else pzs2={"checked="checked""}
	if(lj)lj1={"checked="checked""}
	else lj2={"checked="checked""}
	if(td)tdd={"checked="checked""}
	else tdd2={"checked="checked""}
	if(Speed2==1)wtf="selected"
	else if(Speed2==10)zps="selected"
	else if(Speed2==18)zps2="selected"
	else if(Speed2==28)zps3="selected"
	var/maps=new/list()
	for(var/i in flist("custom_maps/"))
		var/file_extension=copytext(i,length(i)-2,0)
		if(file_extension=="dmp")maps+="custom_maps/[i]"
	var/option={"
		<html>
		<head>
		<title>Options</title>
		</head>
		<body>
		<form method=get action=''>
		<input type=hidden name=src value=\ref[M]>
		<style type="text/css">
			body{background: url("http://webutil1.free.fr/fond/resident_evil22.jpg"); background-position:vcenter; background-color: black; color: white}
			input{background-color: white ;color: black; border-color: grey}
			select{background-color: white ;color: black}
			radio{background-color: black; color: black}
		</style>
		<center><big><b><u>Options</u></b></big></center>
		<br>
		<table cellpadding="3" cellspacing="0" border="1" align="center">
		<td>
		<table cellpadding="3" cellspacing="0" border="0" align="center">
		<tr>
		"}
	option+={"<tr>
			<td>Map: </td><td><select name=map><option value="" selected>- - - - - - - -</option>
			"}
	for(var/i=1,i<=length(map_list),i++)
		var/mapping=map_list[i]
		var/mapper=map_list[mapping]
		var/text=copytext("[mapper]",7,0)
		var/file_name=copytext(text,1,length(text)-3)
		option+={"
			<option value="[map_list[i]]">[file_name]</option>
			"}
	if(length(maps))
		option+={"
			<option value="">- - - - - - - -</option>
			"}
		for(var/i in maps)
			var/text=i
			text=copytext(text,13,0)
			var/file_name=copytext(text,1,length(text)-3)
			option+={"<option value="[i]">[file_name]</option>"}
	option+="</select></td></tr>"
	option+={"<tr><td>Diffculty: </td><td><select name=difficulty>
			<option value="Easy" [easy]>Easy</option>
			<option value="Medium" [medi]>Medium</option>
			<option value="Hard" [hard]>Hard</option>
			<option value="Extreme" [extreme]>Extreme</option>
			</select></td></tr>"}
	option+={"<tr><td>Game Mode: </td><td><select name=gamem>
			<option value="Tongue Twister" [tt]>Tongue Twister</option>
			<option value="Eight Legged Freaks" [elf]>Eight Legged Freaks</option>
			<option value="Survival" [survv]>Survival</option>
			<option value="Fire Fight" [ff]>Fire Fight</option>
			<option value="Protect The Teammate" [ptt]>Protect The Teammate</option>
			<option value="Team Survival" [tb]>Team Survival</option>
			</select></td></tr>"}
	option+={"
			<tr>
				<td>Player Zombies:</td><td>On <input type="radio" [pzs] name="player zombies" value="1"> - Off <input type="radio" [pzs2] name="player zombies" value=""></td>
			</tr>
			<tr>
				<td>Late Joiners:</td><td>On <input type="radio" [lj1] name="late joiners" value="1"> - Off <input type="radio" [lj2] name="late joiners" value=""></td>
			</tr>
			<tr>
				<td>Terrain Destruction:</td><td>On <input type="radio" [tdd] name="terrain destruction" value="1"> - Off <input type="radio" [tdd2] name="terrain destruction" value=""></td>
			</tr>
			"}
	option+={"
		<tr>
			<td>Zombies:</td><td><input type="text" name="zombie" value="[zombies]" maxlength="4"></td>
		</tr>
		<tr>
			<td>Lickers:</td><td><input type="text" name="ltotal" value="[lickers]" maxlength="2"></td>
		</tr>
		<tr>
			<td>Hunters:</td><td><input type="text" name="htotal" value="[hunters]" maxlength="2"></td>
		</tr>
		<tr>
			<td>Spiders:</td><td><input type="text" name="stotal" value="[spiders]" maxlength="3"></td>
		</tr>
		<tr>
			<td>Hunter Betas:</td><td><input type="text" name="btotal" value="[bhunters]" maxlength="2"></td>
		</tr>
		<tr>
			<td>Zombie speed: </td><td><select name=zspeed>
			<option value="wtf" [wtf]>Wtf</option>
			<option value="fast" [zps]>Fast</option>
			<option value="moderate" [zps2]>Moderate</option>
			<option value="slow" [zps3]>Slow</option>
			</select></td>
		</tr>
		<tr>
			<td>Zombies to Kill:</td><td><input type="text" name="ztotal" value="[maxzombies]" maxlength="6"></td>
		</tr>
		</tr>
		</td>
		</table>
		<input type="hidden" name="action" value="start_game">
		<center><input type="submit" value="Submit"> - <input type="reset" value="Reset"></center>
		</table>
		</form>
		</body>
		</html>
		"}
	return option

var/list/NoList=list(".","|",",","`","~","+","=","-",")","(","*","&","^","%","$","#","@","!","}","{",";",":","'","/","<",">"," ","q","w","e","r","t","y","u","i","o","p","a","s","d","f","g","h","j","k","l","z","x","c","v","b","n","m")

var/list
	Owner = list("Floo Fire","Fluidfire")
	Admin = list("Pichu9906","Raizon","Nickzor","Lloyd Asplund","SGT.blackyoshi","S.T.A.R.STediz", "Kozuma3")
mob/player/client/Login()
	..()
	var/mob/player/client/M = src
	if(M.key in Owner)
		M.verbs-=typesof(/mob/player/client/Admin/verb)
		M.verbs+=typesof(/mob/player/client/Owner/verb)
	else if(M.key in Admin)
		M.verbs+=typesof(/mob/player/client/Admin/verb)
		M.verbs-=typesof(/mob/player/client/Owner/verb)
	else
		M.verbs-=typesof(/mob/player/client/Admin/verb)
		M.verbs-=typesof(/mob/player/client/Owner/verb)

//BANS
mob/player/client/Login()
	..()
	if(src.key=="Fluffykins")
		src<<"You have been banned permanantly from this game for Mine spawning repeatedly even after being told not no. Next time you see a rule, stick to it or prepare for more banning"
		del(src)
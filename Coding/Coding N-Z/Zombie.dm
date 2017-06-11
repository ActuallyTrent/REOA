

mob/Monster
	mouse_opacity=0
	density=1
	alignment=1
	var/tmp
		mob/player/client/target
		turn = 1
		checks = 0
		sleeper = 0
	//	obj/dantum/dt = null
	proc
		Walk()
		Get_Target()
			var/list/get=new/list()
			for(var/mob/player/client/M in world)
				if(!M||!M.client)continue
				if(protect){if(M.gamein&&protect==M.key){get+=M;break}}
				else {if(M.gamein)get+=M}
			if(!length(get))return
			src.target=pick(get)
		//search(probabilty=0,soundm=0)
//			if(!src.checked)
//				if(checks<maxchecks)
//					checks++
//					src.checked=1
		//	for(var/mob/player/M in oview(src))
		//		if(!M.gamein)continue
		//		//if(!soundm)soundmoan(M)
		//		if(!src.target||get_dist(src,M)<get_dist(src,src.target))
		//			src.target=M
//					spawn(rand(2,6))checks--
//			else src.checked=0
	//Del()
	//	if(dt)
	//		dt.counter --
	//	..()
//var/checks=0
var/const/maxchecks=4


mob/player/client
	var/tmp
		list
			hud_infectionh=list(new/obj/huds/affected/text(4,10,11,10,"Infection"),new/obj/huds/affected/text(4,18,11,10,"Infection"),new/obj/huds/affected/text(4,26,11,10,"Infection"),new/obj/huds/affected/text(4,32,11,10,"Infection"))
			hud_killsh=list(new/obj/huds/affected/text(3,2,11,0,"Kill"),new/obj/huds/affected/text(3,10,11,0,"Kill"),new/obj/huds/affected/text(3,18,11,0,"Kill"),new/obj/huds/affected/text(3,26,11,0,"Kill"),new/obj/huds/affected/text(3,32,11,0,"Kill"))
			hud_cashh=list(new/obj/huds/affected/text(3,-4,11,-10,"Cash"),new/obj/huds/affected/text(3,4,11,-10,"Cash"),new/obj/huds/affected/text(3,12,11,-10,"Cash"),new/obj/huds/affected/text(3,20,11,-10,"Cash"),new/obj/huds/affected/text(3,28,11,-10,"Cash"),new/obj/huds/affected/text(3,36,11,-10,"Cash"))
			hud_ammoh=list(new/obj/huds/affected/text(4,-6,11,-20,"Clip"),new/obj/huds/affected/text(4,2,11,-20,"Clip"),new/obj/huds/affected/text(4,10,11,-20,"Clip"),new/obj/huds/affected/text(4,18,11,-20,"Clip"),new/obj/huds/affected/text(4,26,11,-20,"Clip"),new/obj/huds/affected/text(4,34,11,-20,"Clip"),new/obj/huds/affected/text(4,42,11,-20,"Clip"))
			hud_ammoh2=list(new/obj/huds/affected/text(4,-6,11,-30,"Clip2"),new/obj/huds/affected/text(4,2,11,-30,"Clip2"),new/obj/huds/affected/text(4,10,11,-30,"Clip2"),new/obj/huds/affected/text(4,18,11,-30,"Clip2"),new/obj/huds/affected/text(4,26,11,-30,"Clip2"),new/obj/huds/affected/text(4,34,11,-30,"Clip2"),new/obj/huds/affected/text(4,42,11,-30,"Clip2"))
			updatehlist=new/list()
		lastinfn=1000
		lastkilln=100000
		lastcashn=100000
		lastclipn=100000
		lastclipn2=100000
		lastvital="Fines"
	proc
		add_hud()
			if(!src||!src.client)return
			var/list/Mlist=new/list()
			Mlist+=src.hud_infectionh
			Mlist+=src.hud_killsh
			Mlist+=src.hud_cashh
			Mlist+=src.hud_ammoh
			Mlist+=src.hud_ammoh2
			for(var/obj/huds/affected/H in Mlist)
				src.client.screen+=H
		add_letter_hud(var/text,X,XX,Y,YY,T)
			if(!text||!src.client)return
			var/ini_xx=0
			for(var/i=1,i<=length(text),i++)
				var/obj/huds/affected/H = new/obj/huds/affected/text(X,(XX+ini_xx),Y,YY,"[T]")
				if(ini_xx>=31){X++;ini_xx-=22}
				else ini_xx+=9
				H.icon_state="[copytext(text,i,i+1)]"
				src.client.screen+=H
		update_hud(utype=0)
			if(!src||!src.client||!utype)return
			if(("[utype]" in src.updatehlist))return
			src.updatehlist+="[utype]"
			spawn(HUPDATERATE)
				if(GameOver||!src.gamein)return
				switch(utype)
					if(1)
						if(length(src.hud_infectionh))
							var/inf="[src.infection]%"
							for(var/i=1,i<=length(src.hud_infectionh),i++)
								var/obj/huds/affected/H=src.hud_infectionh[i]
								H.icon_state="[copytext(inf,i,i+1)]"
					if(2)
						if(length(src.hud_killsh))
							var/kil="[src.kills]"
							for(var/i=1,i<=length(src.hud_killsh),i++)
								var/obj/huds/affected/H=src.hud_killsh[i]
								H.icon_state="[copytext(kil,i,i+1)]"
					if(3)
						if(length(src.hud_cashh))
							var/cas="[copytext("[round(src.cash)]",1,6)]$"
							for(var/i=1,i<=length(src.hud_cashh),i++)
								var/obj/huds/affected/H=src.hud_cashh[i]
								H.icon_state="[copytext(cas,i,i+1)]"
					if(4)
						if(length(src.hud_ammoh))
							if(!src.weapon)return
							var/cli="[src.weapon.clip]/[src.weapon.mclip]"
							for(var/i=1,i<=length(src.hud_ammoh),i++)
								var/obj/huds/affected/H=src.hud_ammoh[i]
								H.icon_state="[copytext(cli,i,i+1)]"
					if(5)
						if(length(src.hud_ammoh2))
							if(!src.weapon2)return
							var/cli="[src.weapon2.clip]/[src.weapon2.mclip]"
							for(var/i=1,i<=length(src.hud_ammoh2),i++)
								var/obj/huds/affected/H=src.hud_ammoh2[i]
								H.icon_state="[copytext(cli,i,i+1)]"
				if(("[utype]" in src.updatehlist))
					src.updatehlist-="[utype]"
		reset_hud()
			if(!src||!src.client)return
			var/list/Mlist=new/list()
			Mlist+=src.hud_infectionh
			Mlist+=src.hud_killsh
			Mlist+=src.hud_cashh
			Mlist+=src.hud_ammoh
			Mlist+=src.hud_ammoh2
			for(var/obj/huds/affected/H in Mlist)
				H.icon_state=""
		reset_shud(var/rtype)
			if(!src||!rtype)return
			var/list/Mlist = new/list()
			switch(rtype)
				if("Infection")Mlist+=src.hud_infectionh
				if("Kill")Mlist+=src.hud_killsh
				if("Cash")Mlist+=src.hud_cashh
				if("Clip")Mlist+=src.hud_ammoh
				if("Clip2")Mlist+=src.hud_ammoh2
			for(var/obj/huds/affected/H in Mlist)
				H.icon_state=""
		hideunhide_hud(hutype=0,utype=0,T)
			if(!utype||!hutype||!src.client)return
			switch(hutype)
				if(1)
					switch(utype)
						if(1){for(var/obj/huds/affected/H in src.client.screen)H.invisibility=0}
						if(2){for(var/obj/huds/affected/H in src.client.screen)if(H.screen_tag == T)H.invisibility=0}
				if(2)
					switch(utype)
						if(1){for(var/obj/huds/affected/H in src.client.screen)H.invisibility=2}
						if(2){for(var/obj/huds/affected/H in src.client.screen)if(H.screen_tag == T)H.invisibility=2}
		inventoryo(itype=0)
			if(!itype||!src.client)return
			if(itype == 1)
				var/X=6
				var/itemlength=src.maxitems
				if(itemlength>8)itemlength=8
				for(var/i=1,i<=itemlength,i++)
					var/obj/huds/not_affected/itembox/O=new/obj/huds/not_affected/itembox
					O.screen_loc="[(X+++dhud_x)]:[(0+dhud_xx)],[(13+dhud_y)]:[(-13+dhud_yy)]"
					src.client.screen+=O
			else if(itype ==2)
				for(var/obj/huds/not_affected/H in src.client.screen)
					del(H)
		updateihud(itype=0,inidelete=0)
			if(!itype||!src.client)return
			if(itype == 1)
				if(inidelete)
					for(var/obj/I in src.client.screen)
						if(istype(I,/obj/Pickup))
							src.client.screen-=I
							I.layer=initial(I.layer)
						else if(istype(I,/obj/huds/not_affected/suffix_text))
							del(I)
				var/X=6
				for(var/obj/Pickup/P in src.contents)
					P.screen_loc="[(X+++dhud_x)]:[(0+dhud_xx)],[(13+dhud_y)]:[(-13+dhud_yy)]"
					P.layer=MOB_LAYER+100000
					src.client.screen+=P
					if(!P.suffix)continue
					var/text2show="[P.suffix]"
					var/cc=-44
					if(istype(P,/obj/Pickup/Guns))
						text2show="~"
						cc+=4
					for(var/i=1,i<=length(text2show),i++)
						var/obj/huds/not_affected/suffix_text/H = new/obj/huds/not_affected/suffix_text
						H.icon_state="[copytext(text2show,i,i+1)]"
						H.screen_loc="[(X+dhud_x)]:[(cc+dhud_xx)],[(13+dhud_y)]:[(-13+dhud_yy)]"
						src.client.screen+=H
						cc+=4
			else if(itype == 2)
				for(var/obj/Pickup/H in src.client.screen)
					H.layer=initial(H.layer)
					src.client.screen-=H
obj
	huds
		layer=MOB_LAYER+99999
		mouse_opacity=0
		invisibility=2
		var/screen_tag
		affected
			text
				icon='hud_text.dmi'
				New(x,xx,y,yy,t)
					screen_loc="[(x+thud_x)]:[(xx+thud_xx)],[(y+thud_y)]:[(yy+thud_yy)]"
					screen_tag=t
					..()
			life_span
				icon='lifespan(1).dmi'
				icon_state="1"
				name="life-span"
				mouse_opacity=1
				New(loc,mob/player/client/M)
					if(!M)del(src)
					src.screen_loc="[(2+dhud_x)]:[(21+dhud_xx)],[(13+dhud_y)]:[(-2+dhud_yy)]"
					var/obj/H = new/obj
					H.icon_state="2"
					H.pixel_x=32
					H.layer=MOB_LAYER+99999
					var/obj/H2 = new/obj
					H2.icon_state="3"
					H2.pixel_x=64
					H2.layer=MOB_LAYER+99999
					var/obj/H3 = new/obj
					H3.icon_state="4"
					H3.pixel_y=-32
					H3.layer=MOB_LAYER+99999
					var/obj/H4 = new/obj
					H4.icon_state="5"
					H4.pixel_x=32
					H4.pixel_y=-32
					H4.layer=MOB_LAYER+99999
					var/obj/H5 = new/obj
					H5.icon_state="6"
					H5.pixel_x=64
					H5.pixel_y=-32
					H5.layer=MOB_LAYER+99999
					src.overlays+=H
					src.overlays+=H2
					src.overlays+=H3
					src.overlays+=H4
					src.overlays+=H5
					if(M.client)M.client.screen+=src
					..()
			avatar
				screen_tag="Avatar"
				icon_state="1"
				mouse_opacity=1
				name="hud"
				New(loc,mob/player/client/M)
					if(!M)del(src)
					src.screen_loc="[(1+dhud_x)]:[(2+dhud_xx)],[(13+dhud_y)]:[(-2+dhud_yy)]"
					var/obj/H = new/obj
					H.icon_state="2"
					H.pixel_x=32
					H.layer=MOB_LAYER+99999
					var/obj/H2 = new/obj
					H2.icon_state="3"
					H2.pixel_y=-32
					H2.layer=MOB_LAYER+99999
					var/obj/H3 = new/obj
					H3.icon_state="4"
					H3.pixel_x=32
					H3.pixel_y=-32
					H3.layer=MOB_LAYER+99999
					src.overlays+=H
					src.overlays+=H2
					src.overlays+=H3
					if(M.client)M.client.screen+=src
					..()
			invbutton
				screen_tag="Inventory"
				icon_state="invbutton"
				name="inv-button"
				icon='ibox.dmi'
				mouse_opacity=1
				New(loc,mob/player/client/M)
					if(!M)del(src)
					src.screen_loc="[(6+dhud_x)]:[(-12+dhud_xx)],[(13+dhud_y)]:[(-13+dhud_yy)]"
					var/obj/H = new/obj
					H.icon_state="invbutton2"
					H.pixel_y=32
					H.layer=MOB_LAYER+99999
					src.overlays+=H
					if(M.client)M.client.screen+=src
					..()
				Click()
					var/mob/player/client/M=usr
					if(GameOver||!M.gamein)return
					if(!M.inventory)
						M.inventory=1
						M.inventoryo(1)
						M.updateihud(1)
					else
						M.inventory=0
						M.updateihud(2)
						M.inventoryo(2)
		not_affected
			itembox
				icon='ibox.dmi'
				icon_state="box"
				name="inventory"
				mouse_opacity=1
				invisibility=0
				screen_tag="Inventory"
				New()
					..()
			suffix_text
				icon='text.dmi'
				screen_tag="Inventory"
				invisibility=0
				layer=MOB_LAYER+100001
				New()
					..()
			/*compass
				screen_tag="Compass"
				icon_state="compass"
				icon='compass.dmi'
				mouse_opacity=0
				invisibility=2
				screen_loc="15:0,1:0"
				layer=MOB_LAYER+99999
				New()
					..()*/
mob/player/client/var/tmp/inventory=0


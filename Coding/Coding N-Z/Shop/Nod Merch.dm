/******MERCHANT******/
obj/NPC
	Nod_Merchant
		var/tmp/list
			buylistweapon=newlist(/obj/Pickup/Guns/Tarantula, /obj/Pickup/Guns/firefly,/obj/Pickup/Guns/Nod_Carbine,/obj/Pickup/Guns/nod_rifle,/obj/Pickup/Guns/JackHammer_Assault_Shotgun, /obj/Pickup/Guns/Preymant, /obj/Pickup/Guns/ScorpP , /obj/Pickup/Guns/Nod_Handgun ,/obj/Pickup/Guns/MagnumN, /obj/Pickup/Guns/skorp, /obj/Pickup/Guns/shadow, /obj/Pickup/Guns/blackhandgun, /obj/Pickup/Guns/Nod_gun, /obj/Pickup/Guns/scop , /obj/Pickup/Guns/FiftyCaliber_N)
			buylistitem=newlist(/obj/Pickup/Items/QS/Barricade_N,/obj/Pickup/Items/QS/Radio_N,/obj/Pickup/Items/Launcher_Parts,/obj/Pickup/Items/Hammer,/obj/Pickup/Items/Turret,/obj/Pickup/Items/Ammo_Light_Handgun,/obj/Pickup/Items/Ammo_Heavy_Handgun,/obj/Pickup/Items/Ammo_Shotgun,/obj/Pickup/Items/Ammo_Light_Machinegun,/obj/Pickup/Items/Ammo_Heavy_Machinegun,/obj/Pickup/Items/Ammo_Sniper,/obj/Pickup/Items/Ammo_Sniper2,/obj/Pickup/Items/Ammo_Acid,/obj/Pickup/Items/Ammo_Flame,/obj/Pickup/Items/Ammo_Freeze,/obj/Pickup/Items/Ammo_Explosive,/obj/Pickup/Items/Spray,/obj/Pickup/Items/TCure,/obj/Pickup/Items/C4,/obj/Pickup/Items/TripWire)
		name="Nod Merchant"
		icon='Merchant.dmi'
		icon_state="normal_N"
		density=1
		verb/Shop()
			set src in oview(1)
			set category = null
			var/mob/player/client/M=usr
			if(M.shopping||M.tm_inmenu)return
			start
			if(!src||!M)return
			if(!(src in oview(1))||GameOn!=1){M.shopping=0;return}
			M.shopping = 1
			switch(tm_option(M,null,"Psst, wanna buy some merchandise?.","Merchant","300x340",list("Buy","Upgrade","Leave"),"select list"))
				if("1")
					buy
					if(!src||!M)return
					if(!(src in oview(1))||GameOn!=1){M.shopping=0;return}
					switch(tm_option(M,null,"Psst, wanna buy some merchandise.","Merchant","300x340",list("Weapons","Items","Cancel"),"select list"))
						if("1")
							if(!src||!M)return
							var/list/List=src.buylistweapon
							var/list/Listing=new/list()
							for(var/i=1,i<=length(List),i++)
								var/obj/Pickup/G=List[i]
								Listing+={"
									<tr align=left bgcolor=[SUBBGCOLORWINDOW]><td align=left><font size=3>[i] <b>- [G.name]</b></td><td align=right><font size=3>\[<a href=?src=\ref[M];action=i;i=[length(Listing)+1]>Buy</a>\]</td></tr>
									<tr align=left bgcolor=[SUBBGCOLORWINDOW]><td colspan=2><font size=3>(-) Cost- [G.cost]</td></tr>
									"}
							var/confirm = tm_option(M,null,"Need a piece?","Merchant","460x400",Listing,"select custom list")
							if(confirm)
								if(confirm<=length(List))
									if(!src||!M)return
									var/obj/Pickup/Guns/G=List[confirm]
									if(G.cost>M.cash){M<<"Not enough cash... stranger....";goto buy}
									if(M.items>=M.maxitems){M<<"Your inventory is full.";goto buy}
									if(M.cc() == 1){M.reset_game();M<<"You hack...";M.Logout();return}
									M.cash-=G.cost
									nums(src,G.cost,"green")
									M.contents+=new G.type
									M.update_items()
									M<<"Hahaha thank you"
									M.save_game()
							goto buy
						if("2")
							if(!src||!M)return
							var/list/List=src.buylistitem
							var/list/Listing=new/list()
							for(var/i=1,i<=length(List),i++)
								var/obj/Pickup/G=List[i]
								Listing+={"
									<tr align=left bgcolor=[SUBBGCOLORWINDOW]><td align=left><font size=3>[i] <b>- [G.name]</b></td><td align=right><font size=3>\[<a href=?src=\ref[M];action=i;i=[length(Listing)+1]>Buy</a>\]</td></tr>
									<tr align=left bgcolor=[SUBBGCOLORWINDOW]><td colspan=2><font size=3>(-) Cost- [G.cost]</td></tr>
									"}
							var/confirm = tm_option(M,null,"Best upgrades this side of the black market","Merchant","410x400",Listing,"select custom list")
							if(confirm)
								if(confirm<=length(List))
									if(!src||!M)return
									var/obj/Pickup/Items/G=List[confirm]
									if(G.cost>M.cash){M<<"Not enough cash... stranger....";goto buy}
									if(M.items>=M.maxitems){M<<"Your inventory is full.";goto buy}
									if(M.cc() == 1){M.reset_game();M<<"You hack...";M.Logout();return}
									if(!M.ammolimits["[G.name]"])return
									if(G.type == /obj/Pickup/Items/TripWire)
										var/obj/Pickup/Items/TripWire/O=locate(G.type) in M.contents
										if(O)
											if(O.ammount>=M.ammolimits["[src.name]"]){M<<"Cant carry anymore [G.name].";goto buy}
											else
												O.ammount++
												O.suffix="x[O.ammount]"
												M.update_items()
												M.cash-=G.cost
												nums(src,G.cost,"green")
												M<<"Hahaha thank you"
												M.save_game()
												goto buy
										else
											M.contents+=new G.type
											M.update_items()
											M.cash-=G.cost
											nums(src,G.cost,"green")
											M<<"Hahaha thank you"
											M.save_game()
											goto buy
									else if(G.type == /obj/Pickup/Items/C4)
										var/obj/Pickup/Items/C4/O=locate(G.type) in M.contents
										if(O)
											if(O.ammount>=M.ammolimits["[G.name]"]){M<<"Cant carry anymore [G.name].";goto buy}
											else
												O.ammount++
												O.suffix="x[O.ammount]"
												M.update_items()
												M.cash-=G.cost
												nums(src,G.cost,"green")
												M<<"Hahaha thank you"
												M.save_game()
												goto buy
										else
											M.contents+=new G.type
											M.update_items()
											M.cash-=G.cost
											nums(src,G.cost,"green")
											M<<"Hahaha thank you"
											M.save_game()
											goto buy
									else if(G.type == /obj/Pickup/Items/TCure)
										var/obj/Pickup/Items/TCure/C=locate(G.type) in M.contents
										if(C)
											if(C.ammount>=M.ammolimits["[G.name]"]){M<<"Cant carry anymore [G.name].";goto buy}
											else
												C.ammount++
												C.suffix="x[C.ammount]"
												M.update_items()
												M.cash-=G.cost
												nums(src,G.cost,"green")
												M<<"Hahaha thank you"
												M.save_game()
												goto buy
										else
											M.contents+=new G.type
											M.update_items()
											M.cash-=G.cost
											nums(src,G.cost,"green")
											M<<"Hahaha thank you"
											M.save_game()
											goto buy
									else
										for(var/obj/Pickup/Items/O in M.contents)
											if(O.type==G.type)
												if(O.ammount<M.ammolimits["[G.name]"])
													O.ammount++
													O.suffix="x[O.ammount]"
													M.update_items()
													M.cash-=G.cost
													nums(src,G.cost,"green")
													M<<"Hahaha thank you"
													M.save_game()
													goto buy
									if(M.ammolimits["[G.name]"]>=0)
										M.contents+=new G.type
										M.update_items()
										M.cash-=G.cost
										nums(src,G.cost,"green")
										M<<"Hahaha thank you"
										M.save_game()
									else
										M<<"Cant carry anymore [G.name]."
							goto buy
					goto start
				if("2")
					upgrade
					if(!src||!M)return
					if(!(src in oview(1))||GameOn!=1){M.shopping=0;return}
					switch(tm_option(M,null,"Best upgrades this side of the black market?","Merchant","300x340",list("Weapon","Other","Cancel"),"select list"))
						if("1")
							if(!src||!M)return
							var/list/List=new/list()
							var/list/Listing=new/list()
							for(var/obj/Pickup/Guns/P in M.contents)
								if(!P.can_upgrade_rs && !P.can_upgrade_fr && !P.can_upgrade_cc && !P.can_upgrade_fp &&!P.can_upgrade_ac)continue
								if(P.clip_level<length(P.upgrade_mc)||P.firerate_level<length(P.upgrade_fr)||P.gunpower_level<length(P.upgrade_fp)||P.reloadtime_level<length(P.upgrade_rs)||P.accuracy_level<length(P.upgrade_ac))
									List+=P
							if(!length(List)){M<<"Nothing to upgrade.";goto upgrade}
							for(var/i=1,i<=length(List),i++)
								var/obj/Pickup/Guns/G=List[i]
								if(G.can_upgrade_fr && G.can_upgrade_ac)
									Listing+={"
										<tr align=left bgcolor=[SUBBGCOLORWINDOW]><td align=left><font size=3>[i] <b>- [G.name]</b></td><td align=right><font size=3>\[<a href=?src=\ref[M];action=i;i=[length(Listing)+1]>Select</a>\]</td></tr>
										<tr align=left bgcolor=[SUBBGCOLORWINDOW]><td colspan=2><font size=3>Lv.([G.clip_level]) <b>Capacity</b>- [G.mclip]</td></tr>
										<tr align=left bgcolor=[SUBBGCOLORWINDOW]><td colspan=2><font size=3>Lv.([G.firerate_level]) <b>Firing Speed</b>- [G.firerate]</td></tr>
										<tr align=left bgcolor=[SUBBGCOLORWINDOW]><td colspan=2><font size=3>Lv.([G.gunpower_level]) <b>FirePower</b>- [G.fire_power]</td></tr>
										<tr align=left bgcolor=[SUBBGCOLORWINDOW]><td colspan=2><font size=3>Lv.([G.reloadtime_level]) <b>Reload Speed</b>- [G.reload_time]</td></tr>
										<tr align=left bgcolor=[SUBBGCOLORWINDOW]><td colspan=2><font size=3>Lv.([G.accuracy_level]) <b>Accuracy</b>- [G.accuracy]</td></tr>
										"}
								else if(G.can_upgrade_fr && !G.can_upgrade_ac)
									Listing+={"
										<tr align=left bgcolor=[SUBBGCOLORWINDOW]><td align=left><font size=3>[i] <b>- [G.name]</b></td><td align=right><font size=3>\[<a href=?src=\ref[M];action=i;i=[length(Listing)+1]>Select</a>\]</td></tr>
										<tr align=left bgcolor=[SUBBGCOLORWINDOW]><td colspan=2><font size=3>Lv.([G.clip_level]) <b>Capacity</b>- [G.mclip]</td></tr>
										<tr align=left bgcolor=[SUBBGCOLORWINDOW]><td colspan=2><font size=3>Lv.([G.firerate_level]) <b>Firing Speed</b>- [G.firerate]</td></tr>
										<tr align=left bgcolor=[SUBBGCOLORWINDOW]><td colspan=2><font size=3>Lv.([G.gunpower_level]) <b>FirePower</b>- [G.fire_power]</td></tr>
										<tr align=left bgcolor=[SUBBGCOLORWINDOW]><td colspan=2><font size=3>Lv.([G.reloadtime_level]) <b>Reload Speed</b>- [G.reload_time]</td></tr>
										"}
								else if(!G.can_upgrade_fr && G.can_upgrade_ac)
									Listing+={"
										<tr align=left bgcolor=[SUBBGCOLORWINDOW]><td align=left><font size=3>[i] <b>- [G.name]</b></td><td align=right><font size=3>\[<a href=?src=\ref[M];action=i;i=[length(Listing)+1]>Select</a>\]</td></tr>
										<tr align=left bgcolor=[SUBBGCOLORWINDOW]><td colspan=2><font size=3>Lv.([G.clip_level]) <b>Capacity</b>- [G.mclip]</td></tr>
										<tr align=left bgcolor=[SUBBGCOLORWINDOW]><td colspan=2><font size=3>Lv.([G.gunpower_level]) <b>FirePower</b>- [G.fire_power]</td></tr>
										<tr align=left bgcolor=[SUBBGCOLORWINDOW]><td colspan=2><font size=3>Lv.([G.reloadtime_level]) <b>Reload Speed</b>- [G.reload_time]</td></tr>
										<tr align=left bgcolor=[SUBBGCOLORWINDOW]><td colspan=2><font size=3>Lv.([G.accuracy_level]) <b>Accuracy</b>- [G.accuracy]</td></tr>
										"}
								else
									Listing+={"
										<tr align=left bgcolor=[SUBBGCOLORWINDOW]><td align=left><font size=3>[i] <b>- [G.name]</b></td><td align=right><font size=3>\[<a href=?src=\ref[M];action=i;i=[length(Listing)+1]>Select</a>\]</td></tr>
										<tr align=left bgcolor=[SUBBGCOLORWINDOW]><td colspan=2><font size=3>Lv.([G.clip_level]) <b>Capacity</b>- [G.mclip]</td></tr>
										<tr align=left bgcolor=[SUBBGCOLORWINDOW]><td colspan=2><font size=3>Lv.([G.gunpower_level]) <b>FirePower</b>- [G.fire_power]</td></tr>
										<tr align=left bgcolor=[SUBBGCOLORWINDOW]><td colspan=2><font size=3>Lv.([G.reloadtime_level]) <b>Reload Speed</b>- [G.reload_time]</td></tr>
										"}
							var/confirm = tm_option(M,null,"Upgrade which piece?","Merchant","350x340",Listing,"select custom list")
							if(confirm)
								if(confirm<=length(List))
									if(!src||!M)return
									var/obj/Pickup/Guns/G=List[confirm]
									if(G&&istype(G,/obj/Pickup/Guns))
										Listing=new/list()
										confirm=0
										if(G.can_upgrade_cc)
											if(G.clip_level>=length(G.upgrade_mc))
												Listing+={"<tr align=left bgcolor=[SUBBGCOLORWINDOW]><td align=left><font size=3>Lv.([G.clip_level]) <b>Cham-Capacity</b> - [G.mclip]</b></td><td align=right><font size=3>\[Maxed\]</td></tr>
														<tr align=left bgcolor=[SUBBGCOLORWINDOW]><td colspan=2><font size=3>(-) Cost- -----</td></tr>"}
											else
												Listing+={"
														<tr align=left bgcolor=[SUBBGCOLORWINDOW]><td align=left><font size=3>Lv.([G.clip_level]) <b>Cham-Capacity</b> - [G.mclip]</b></td><td align=right><font size=3>\[<a href=?src=\ref[M];action=i;i=1>Upgrade</a>\]</td></tr>
														<tr align=left bgcolor=[SUBBGCOLORWINDOW]><td colspan=2><font size=3>(-) Cost- [G.clip_level_cost]</td></tr>"}
										if(G.can_upgrade_fr)
											if(G.firerate_level>=length(G.upgrade_fr))
												Listing+={"<tr align=left bgcolor=[SUBBGCOLORWINDOW]><td align=left><font size=3>Lv.([G.firerate_level]) <b>Firing Speed</b> - [G.firerate]</b></td><td align=right><font size=3>\[Maxed\]</td></tr>
														<tr align=left bgcolor=[SUBBGCOLORWINDOW]><td colspan=2><font size=3>(-) Cost- -----</td></tr>"}
											else
												Listing+={"
													<tr align=left bgcolor=[SUBBGCOLORWINDOW]><td align=left><font size=3>Lv.([G.firerate_level]) <b>Firing Speed</b> - [G.firerate]</b></td><td align=right><font size=3>\[<a href=?src=\ref[M];action=i;i=2>Upgrade</a>\]</td></tr>
													<tr align=left bgcolor=[SUBBGCOLORWINDOW]><td colspan=2><font size=3>(-) Cost- [G.firerate_level_cost]</td></tr>"}
										else
											Listing+={"
												<tr align=left bgcolor=[SUBBGCOLORWINDOW]><td align=left><font size=3>Lv.([G.firerate_level]) <b>Firing Speed</b> - [G.firerate]</b></td><td align=right><font size=3>\[Maxed\]</td></tr>
												<tr align=left bgcolor=[SUBBGCOLORWINDOW]><td colspan=2><font size=3>(-) Cost- -----</td></tr>"}
										if(G.can_upgrade_fp)
											if(G.gunpower_level>=length(G.upgrade_fp))
												Listing+={"<tr align=left bgcolor=[SUBBGCOLORWINDOW]><td align=left><font size=3>Lv.([G.gunpower_level]) <b>FirePower</b> - [G.fire_power]</b></td><td align=right><font size=3>\[Maxed\]</td></tr>
														<tr align=left bgcolor=[SUBBGCOLORWINDOW]><td colspan=2><font size=3>(-) Cost- -----</td></tr>"}
											else
												Listing+={"<tr align=left bgcolor=[SUBBGCOLORWINDOW]><td align=left><font size=3>Lv.([G.gunpower_level]) <b>FirePower</b> - [G.fire_power]</b></td><td align=right><font size=3>\[<a href=?src=\ref[M];action=i;i=3>Upgrade</a>\]</td></tr>
														<tr align=left bgcolor=[SUBBGCOLORWINDOW]><td colspan=2><font size=3>(-) Cost- [G.gunpower_level_cost]</td></tr>"}
										if(G.can_upgrade_rs)
											if(G.reloadtime_level>=length(G.upgrade_rs))
												Listing+={"<tr align=left bgcolor=[SUBBGCOLORWINDOW]><td align=left><font size=3>Lv.([G.reloadtime_level]) <b>Reload Speed</b> - [G.reload_time]</b></td><td align=right><font size=3>\[Maxed\]</td></tr>
														<tr align=left bgcolor=[SUBBGCOLORWINDOW]><td colspan=2><font size=3>(-) Cost- -----</td></tr>"}
											else
												Listing+={"<tr align=left bgcolor=[SUBBGCOLORWINDOW]><td align=left><font size=3>Lv.([G.reloadtime_level]) <b>Reload Speed</b> - [G.reload_time]</b></td><td align=right><font size=3>\[<a href=?src=\ref[M];action=i;i=4>Upgrade</a>\]</td></tr>
														<tr align=left bgcolor=[SUBBGCOLORWINDOW]><td colspan=2><font size=3>(-) Cost- [G.reloadtime_level_cost]</td></tr>"}
										if(G.can_upgrade_ac)
											if(G.accuracy_level>=length(G.upgrade_ac))
												Listing+={"<tr align=left bgcolor=[SUBBGCOLORWINDOW]><td align=left><font size=3>Lv.([G.accuracy_level]) <b>Accuracy</b> - [G.accuracy]</b></td><td align=right><font size=3>\[Maxed\]</td></tr>
														<tr align=left bgcolor=[SUBBGCOLORWINDOW]><td colspan=2><font size=3>(-) Cost- -----</td></tr>"}
											else
												Listing+={"<tr align=left bgcolor=[SUBBGCOLORWINDOW]><td align=left><font size=3>Lv.([G.accuracy_level]) <b>Accuracy</b> - [G.accuracy]</b></td><td align=right><font size=3>\[<a href=?src=\ref[M];action=i;i=7>Upgrade</a>\]</td></tr>
														<tr align=left bgcolor=[SUBBGCOLORWINDOW]><td colspan=2><font size=3>(-) Cost- [G.accuracy_level_cost]</td></tr>"}
										switch(tm_option(M,null,"Upgrade which atribute?","Merchant","500x400",Listing,"select custom list"))
											if(1)
												if(!src||!M)return
												if(G&&length(M.contents)&&M.contents.Find(G))
													if(M.cc() == 1){M.reset_game();M<<"You hack...";M.Logout();return}
													if(G.clip_level_cost>M.cash)
														if(!M.freeupgrade)
															M<<"Not enough cash... stranger...."
															goto start
														else
															M.freeupgrade--
													else
														M.cash-=G.clip_level_cost
														nums(src,G.clip_level_cost,"green")
													switch(G.at)
														if(1){G.clip_level_cost+=80}
														if(2){G.clip_level_cost+=120}
														if(3){G.clip_level_cost+=130}
														if(4){G.clip_level_cost+=150}
														if(5){G.clip_level_cost+=170}
														if(6){G.firerate_level_cost+=160}
													G.clip_level++
													G.mclip=G.upgrade_mc[G.clip_level]
													if(G.suffix)G.suffix="[G.clip]/[G.mclip]"
													M<<"Hahaha thank you."
													M.save_game()
											if(2)
												if(!src||!M)return
												if(G&&length(M.contents)&&M.contents.Find(G))
													if(M.cc() == 1){M.reset_game();M<<"You hack...";M.Logout();return}
													if(G.firerate_level_cost>M.cash)
														if(!M.freeupgrade)
															M<<"Not enough cash... stranger...."
															goto start
														else
															M.freeupgrade--
													else
														M.cash-=G.firerate_level_cost
														nums(src,G.firerate_level_cost,"green")
													switch(G.at)
														if(1){G.firerate_level_cost+=80}
														if(2){G.firerate_level_cost+=160}
														if(3){G.firerate_level_cost+=130}
														if(6){G.firerate_level_cost+=170}
													G.firerate_level++
													G.firerate=G.upgrade_fr[G.firerate_level]
													M<<"Hahaha thank you."
													M.save_game()
											if(3)
												if(!src||!M)return
												if(G&&length(M.contents)&&M.contents.Find(G))
													if(M.cc() == 1){M.reset_game();M<<"You hack...";M.Logout();return}
													if(G.gunpower_level_cost>M.cash)
														if(!M.freeupgrade)
															M<<"Not enough cash... stranger...."
															goto start
														else
															M.freeupgrade--
													else
														M.cash-=G.gunpower_level_cost
														nums(src,G.gunpower_level_cost,"green")
													switch(G.at)
														if(1){G.gunpower_level_cost+=80}
														if(2){G.gunpower_level_cost+=100}
														if(3){G.gunpower_level_cost+=120}
														if(4){G.gunpower_level_cost+=140}
														if(5){G.gunpower_level_cost+=160}
														if(6){G.gunpower_level_cost+=170}
													G.gunpower_level++
													G.fire_power=G.upgrade_fp[G.gunpower_level]
													M<<"Hahaha thank you."
													M.save_game()
											if(4)
												if(!src||!M)return
												if(G&&length(M.contents)&&M.contents.Find(G))
													if(M.cc() == 1){M.reset_game();M<<"You hack...";M.Logout();return}
													if(G.reloadtime_level_cost>M.cash)
														if(!M.freeupgrade)
															M<<"Not enough cash... stranger...."
															goto start
														else
															M.freeupgrade--
													else
														M.cash-=G.reloadtime_level_cost
														nums(src,G.reloadtime_level_cost,"green")
													switch(G.at)
														if(1){G.reloadtime_level_cost+=80}
														if(2){G.reloadtime_level_cost+=120}
														if(3){G.reloadtime_level_cost+=140}
														if(4){G.reloadtime_level_cost+=130}
														if(5){G.reloadtime_level_cost+=150}
														if(6){G.reloadtime_level_cost+=160}
													G.reloadtime_level++
													G.reload_time=G.upgrade_rs[G.reloadtime_level]
													M<<"Hahaha thank you."
													M.save_game()
											if(7)
												if(!src||!M)return
												if(G&&length(M.contents)&&M.contents.Find(G))
													if(M.cc() == 1){M.reset_game();M<<"You hack...";M.Logout();return}
													if(G.accuracy_level_cost>M.cash)
														if(!M.freeupgrade)
															M<<"Not enough cash... stranger...."
															goto start
														else
															M.freeupgrade--
													else
														M.cash-=G.accuracy_level_cost
														nums(src,G.accuracy_level_cost,"green")
													switch(G.at)
														if(1){G.accuracy_level_cost+=80}
														if(2){G.accuracy_level_cost+=120}
														if(3){G.accuracy_level_cost+=140}
														if(4){G.accuracy_level_cost+=130}
														if(5){G.accuracy_level_cost+=150}
														if(6){G.accuracy_level_cost+=160}
													G.accuracy_level++
													G.accuracy=G.upgrade_ac[G.accuracy_level]
													M<<"Hahaha thank you."
													M.save_game()

							goto upgrade
						if("2")
							if(!src||!M)return
							var/list/L=list("<tr align=left bgcolor=[SUBBGCOLORWINDOW]><td align=left><font size=3>1 <b>- Item Space ++</b></td><td align=right><font size=3>\[<a href=?src=\ref[M];action=i;i=1>Upgrade</a>\]</td></tr><tr align=left bgcolor=[SUBBGCOLORWINDOW]><td colspan=2><font size=3>(-) Cost- 8000</td></tr>","<tr align=left bgcolor=[SUBBGCOLORWINDOW]><td align=left><font size=3>2 <b>- Storage Space ++</b></td><td align=right><font size=3>\[<a href=?src=\ref[M];action=i;i=2>Upgrade</a>\]</td></tr><tr align=left bgcolor=[SUBBGCOLORWINDOW]><td colspan=2><font size=3>(-) Cost- 8000</td></tr>")
							switch(tm_option(M,null,"What will you upgrade?","Merchant","410x400",L,"select custom list"))
								if(1)
									if(!src||!M)return
									if(8000>M.cash){M<<"Not enough cash... stranger....";goto upgrade}
									if(M.maxitems>=12){M<<"You can no longer upgrade this.";goto upgrade}
									if(M.cc() == 1){M.reset_game();M<<"You hack...";M.Logout();return}
									M.cash-=8000
									nums(src,8000,"green")
									M.maxitems+=2
									M<<"Hahaha thank you"
									M.save_game()
								if(2)
									if(!src||!M)return
									if(8000>M.cash){M<<"Not enough cash... stranger....";goto upgrade}
									if(M.chest_capacity>=6){M<<"You can no longer upgrade this.";goto upgrade}
									if(M.cc() == 1){M.reset_game();M<<"You hack...";M.Logout();return}
									M.cash-=8000
									nums(src,8000,"green")
									M.chest_capacity+=2
									M<<"Hahaha thank you"
									M.save_game()
							goto upgrade
					goto start
			if(M)
				M.shopping = 0
				M<<"Come back anytime....."
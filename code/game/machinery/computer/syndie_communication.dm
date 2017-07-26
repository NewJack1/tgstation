
// The syndicate communications computer
/obj/machinery/computer/communications/syndicate
	name = "syndicate communications console"
	desc = "A console used for syndicate announcements and emergencies."
	icon_screen = "tcboss"
	icon_keyboard = "tech_key"
	req_access = list(GLOB.access_syndicate_comms)
	circuit = /obj/item/weapon/circuitboard/computer/communications/syndicate
	var/authenticated_syndicate = 0
	var/auth_id_syndicate = "Unknown" //Who is currently logged in?
	var/currmsg_syndicate = 0
	var/message_cooldown_syndicate = 0
	var/ai_message_cooldown_syndicate = 0
	var/const/STATE_DEFAULT_syndicate = 1


	var/stat_msg1_syndicate
	var/stat_msg2_syndicate

	light_color = LIGHT_COLOR_BLUE

/obj/machinery/computer/communications/syndicate/proc/checkCCcooldown_syndicate()
	var/obj/item/weapon/circuitboard/computer/communications/syndicate/CM = circuit
	if(CM.lastTimeUsed + 600 > world.time)
		return FALSE
	return TRUE

/obj/machinery/computer/communications/syndicate/Topic(href, href_list)
	usr.set_machine(src)

	if(!href_list["operation"])
		return
	var/obj/item/weapon/circuitboard/computer/communications/syndicate/CM = circuit
	switch(href_list["operation"])
		// main interface
		if("main")
			src.state = STATE_DEFAULT
			playsound(src, 'sound/machines/terminal_prompt_deny.ogg', 50, 0)
		if("login")
			var/mob/M = usr

			var/obj/item/weapon/card/id/I = M.get_active_held_item()
			if(!istype(I))
				I = M.get_idcard()

			if(I && istype(I))
				if(src.check_access(I))
					authenticated = 1
					auth_id = "[I.registered_name] ([I.assignment])"
					playsound(src, 'sound/machines/terminal_on.ogg', 50, 0)
					if(prob(25))
						for(var/mob/living/silicon/ai/AI in active_ais())
							AI << sound('sound/machines/terminal_alert.ogg', volume = 10) //Very quiet for balance reasons
		if("logout")
			authenticated = 0
			playsound(src, 'sound/machines/terminal_off.ogg', 50, 0)
			src.state = STATE_DEFAULT
		if("MessageSyndicate")
			if(!checkCCcooldown_syndicate())
				to_chat(usr, "<span class='warning'>Arrays recycling.  Please stand by.</span>")
				playsound(src, 'sound/machines/terminal_prompt_deny.ogg', 50, 0)
				return
			var/input = stripped_input(usr, "Please choose a message to transmit to Syndicate Command via quantum entanglement.", "Send a message to Syndicate.", "")
			if(!input || !(usr in view(1,src)) || !checkCCcooldown_syndicate())
				return
			playsound(src, 'sound/machines/terminal_prompt_confirm.ogg', 50, 0)
			Syndicate_announce(input, usr)
			to_chat(usr, "<span class='danger'>MESSAGE TRANSMITTED TO SYNDICATE COMMAND.</span>")
			log_talk(usr,"[key_name(usr)] has made a Syndicate announcement: [input]",LOGSAY)
			CM.lastTimeUsed = world.time
	src.updateUsrDialog()


/obj/machinery/computer/communications/syndicate/attack_hand(mob/user)

	user.set_machine(src)
	var/dat = ""
	var/datum/browser/popup = new(user, "communications", "Communications Console", 400, 500)
	popup.set_title_image(user.browse_rsc_icon(src.icon, src.icon_state))

	switch(src.state)
		if(STATE_DEFAULT)
			if (src.authenticated)
				if(SSshuttle.emergencyCallAmount)
					if(SSshuttle.emergencyLastCallLoc)
						dat += "Most recent shuttle call/recall traced to: <b>[format_text(SSshuttle.emergencyLastCallLoc.name)]</b><BR>"
					else
						dat += "Unable to trace most recent shuttle call/recall signal.<BR>"
				dat += "Logged in as: [auth_id]"
				dat += "<BR>"
				dat += "<BR>\[ <A HREF='?src=\ref[src];operation=logout'>Log Out</A> \]<BR>"
				dat += "<BR><B>General Functions</B>"
				dat += "<BR>\[ <A HREF='?src=\ref[src];operation=MessageSyndicate'>Send Message to Syndicate Command</A> \]"
			else
				dat += "<BR>\[ <A HREF='?src=\ref[src];operation=login'>Log In</A> \]"

	dat += "<BR><BR>\[ [(src.state != STATE_DEFAULT) ? "<A HREF='?src=\ref[src];operation=main'>Main Menu</A> | " : ""]<A HREF='?src=\ref[user];mach_close=communications'>Close</A> \]"

	popup.set_content(dat)
	popup.open()
	popup.set_content(dat)
	popup.open()
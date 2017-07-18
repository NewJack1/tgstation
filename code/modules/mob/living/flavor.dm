/mob/living/carbon/human/verb/set_flavor()
	set name = "Set Flavor Text"
	set desc = "Sets an extended description of your character's features."
	set category = "IC"

	if(jobban_isbanned(usr, "appearance"))
		return

	update_flavor_text()
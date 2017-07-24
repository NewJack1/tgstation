/datum/species/skrell
	name = "Skrell"
	id = "skrell"
	say_mod = "говорит"
	default_color = "FFFFF"
	species_traits = list(MUTCOLORS)
	mutant_organs = list(/obj/item/organ/tongue/skrell)
	mutant_bodyparts = list("skrell_hair")
	default_features = list("mcolor" = "FFF", "skrell_hair" = "Null")
	attack_verb = "punch"
	attack_sound = 'sound/weapons/slash.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	meat = /obj/item/weapon/reagent_containers/food/snacks/meat/slab/human/mutant/slime
	skinned_type = /obj/item/stack/sheet/animalhide/generic

/datum/species/skrell/qualifies_for_rank(rank, list/features)
	if(rank in GLOB.command_positions)
		return 0
	return 1

/obj/item/organ/tongue/skrell
	say_mod = "говорит"


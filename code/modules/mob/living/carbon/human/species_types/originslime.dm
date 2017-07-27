/datum/species/originslime
	name = "Slime human"
	id = "originslime"
	default_color = "222"
	burnmod = 3
	coldmod = 3
	heatmod = 3
	brutemod = 5
	stunmod = 0.1
	punchdamagelow = 0.1
	punchdamagehigh = 0.1
	punchstunthreshold = 0.1
	species_traits = list(MUTCOLORS, EYECOLOR, HAIR, FACEHAIR, NOBLOOD, VIRUSIMMUNE, TOXINLOVER, RADIMMUNE, EASYDISMEMBER, NOBREATH) // Всё ещё чувствуют боль.
	say_mod = "булькает"
	hair_color = "mutcolor"
	hair_alpha = 150
	ignored_by = list(/mob/living/simple_animal/slime)
	meat = /obj/item/weapon/reagent_containers/food/snacks/meat/slab/human/mutant/slime
	exotic_blood = "slimejelly"
	damage_overlay_type = ""
	mutant_organs = list()

/datum/species/originslime/spec_life(mob/living/carbon/human/H)
	if(H.stat == DEAD) //can't farm slime jelly from a dead slime/jelly person indefinitely
		return
	if(!H.blood_volume)
		H.blood_volume += 5
		H.adjustBruteLoss(5)
		to_chat(H, "<span class='danger'>You feel empty!</span>")

	if(H.blood_volume < BLOOD_VOLUME_NORMAL)
		if(H.nutrition >= NUTRITION_LEVEL_STARVING)
			H.blood_volume += 3
			H.nutrition -= 2.5
	if(H.blood_volume < BLOOD_VOLUME_OKAY)
		if(prob(5))
			to_chat(H, "<span class='danger'>You feel drained!</span>")

/datum/species/originslime/random_name(gender,unique,lastname)
	if(unique)
		return random_unique_originslime_name(gender)

	var/randname = originslime_name(gender)

	if(lastname)
		randname += " [lastname]"

	return randname

/datum/species/originslime/after_equip_job(datum/job/J, mob/living/carbon/human/H)
	H.grant_language(/datum/language/slime)
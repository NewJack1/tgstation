//If you're looking for spawners like ash walker eggs, check ghost_role_spawners.dm

/obj/structure/fans/tiny/invisible //For blocking air in ruin doorways
	invisibility = INVISIBILITY_ABSTRACT

//lavaland_surface_seed_vault.dmm
//Seed Vault

/obj/effect/spawner/lootdrop/seed_vault
	name = "seed vault seeds"
	lootcount = 1

	loot = list(/obj/item/seeds/gatfruit = 10,
				/obj/item/seeds/cherry/bomb = 10,
				/obj/item/seeds/berry/glow = 10,
				/obj/item/seeds/sunflower/moonflower = 8
				)

//Free Golems

/obj/item/weapon/disk/design_disk/golem_shell
	name = "Golem Creation Disk"
	desc = "A gift from the Liberator."
	icon_state = "datadisk1"
	max_blueprints = 1

/obj/item/weapon/disk/design_disk/golem_shell/Initialize()
	. = ..()
	var/datum/design/golem_shell/G = new
	blueprints[1] = G

/datum/design/golem_shell
	name = "Golem Shell Construction"
	desc = "Allows for the construction of a Golem Shell."
	id = "golem"
	req_tech = list("materials" = 12)
	build_type = AUTOLATHE
	materials = list(MAT_METAL = 40000)
	build_path = /obj/item/golem_shell
	category = list("Imported")

/obj/item/golem_shell
	name = "incomplete free golem shell"
	icon = 'icons/obj/wizard.dmi'
	icon_state = "construct"
	desc = "The incomplete body of a golem. Add ten sheets of any mineral to finish."
	var/shell_type = /obj/effect/mob_spawn/human/golem
	var/has_owner = FALSE //if the resulting golem obeys someone

/obj/item/golem_shell/attackby(obj/item/I, mob/user, params)
	..()
	var/species
	if(istype(I, /obj/item/stack/))
		var/obj/item/stack/O = I

		if(istype(O, /obj/item/stack/sheet/metal))
			species = /datum/species/golem

		if(istype(O, /obj/item/stack/sheet/glass))
			species = /datum/species/golem/glass

		if(istype(O, /obj/item/stack/sheet/plasteel))
			species = /datum/species/golem/plasteel

		if(istype(O, /obj/item/stack/sheet/mineral/sandstone))
			species = /datum/species/golem/sand

		if(istype(O, /obj/item/stack/sheet/mineral/plasma))
			species = /datum/species/golem/plasma

		if(istype(O, /obj/item/stack/sheet/mineral/diamond))
			species = /datum/species/golem/diamond

		if(istype(O, /obj/item/stack/sheet/mineral/gold))
			species = /datum/species/golem/gold

		if(istype(O, /obj/item/stack/sheet/mineral/silver))
			species = /datum/species/golem/silver

		if(istype(O, /obj/item/stack/sheet/mineral/uranium))
			species = /datum/species/golem/uranium

		if(istype(O, /obj/item/stack/sheet/mineral/bananium))
			species = /datum/species/golem/bananium

		if(istype(O, /obj/item/stack/sheet/mineral/titanium))
			species = /datum/species/golem/titanium

		if(istype(O, /obj/item/stack/sheet/mineral/plastitanium))
			species = /datum/species/golem/plastitanium

		if(istype(O, /obj/item/stack/sheet/mineral/abductor))
			species = /datum/species/golem/alloy

		if(istype(O, /obj/item/stack/sheet/mineral/wood))
			species = /datum/species/golem/wood

		if(istype(O, /obj/item/stack/sheet/bluespace_crystal))
			species = /datum/species/golem/bluespace

		if(istype(O, /obj/item/stack/sheet/runed_metal))
			species = /datum/species/golem/runic

		if(istype(O, /obj/item/stack/medical/gauze) || istype(O, /obj/item/stack/sheet/cloth))
			species = /datum/species/golem/cloth

		if(istype(O, /obj/item/stack/sheet/mineral/adamantine))
			species = /datum/species/golem/adamantine

		if(istype(O, /obj/item/stack/sheet/plastic))
			species = /datum/species/golem/plastic

		if(species)
			if(O.use(10))
				to_chat(user, "You finish up the golem shell with ten sheets of [O].")
				new shell_type(get_turf(src), species, user)
				qdel(src)
			else
				to_chat(user, "You need at least ten sheets to finish a golem.")
		else
			to_chat(user, "You can't build a golem out of this kind of material.")

//made with xenobiology, the golem obeys its creator
/obj/item/golem_shell/servant
	name = "incomplete servant golem shell"
	shell_type = /obj/effect/mob_spawn/human/golem/servant

///Syndicate Listening Post

/obj/effect/mob_spawn/human/lavaland_syndicate
	name = "Syndicate Bioweapon Scientist"
	roundstart = FALSE
	death = FALSE
	icon = 'icons/obj/Cryogenic2.dmi'
	icon_state = "sleeper_s"
	flavour_text = "<font size=3>�� ��������� ������� ���������, ������� �������� � ��������� ����������������� ������, ��������������� ������������� ������. � ���������, ��� ����������� ����, ����������, ����� ������ � ���� �������. ����������� ���� ������������ ��� ����� �����, � ������������ ��������� ������������. <font size=6><b>��</b></font> ������� ���� ��� ������������ �������. </b> ���� ��������� �����������, ���� ������ ����������, �� ���������� ���� ������� � ���� �����!</b>"
	id_access_list = list(GLOB.access_syndicate)
	outfit = /datum/outfit/lavaland_syndicate
	assignedrole = "Lavaland Syndicate"
	objectives = /datum/objective/survive

/datum/outfit/lavaland_syndicate
	name = "Syndicate Bioweapon Scientist"
	r_hand = /obj/item/weapon/gun/ballistic/automatic/c20r/sc_c20r
	uniform = /obj/item/clothing/under/syndicate
	suit = /obj/item/clothing/suit/toggle/labcoat
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/combat
	ears = /obj/item/device/radio/headset/syndicate/alt
	back = /obj/item/weapon/storage/backpack
	r_pocket = /obj/item/weapon/gun/ballistic/automatic/pistol
	l_pocket = /obj/item/weapon/crowbar/red
	id = /obj/item/weapon/card/id
	implants = list(/obj/item/weapon/implant/weapons_auth)

/datum/outfit/lavaland_syndicate/post_equip(mob/living/carbon/human/H)
	H.faction |= "syndicate"

/obj/effect/mob_spawn/human/lavaland_syndicate/comms
	name = "Syndicate Telecomms Agent"
	flavour_text = {"
<b>�� ��������� ������� ������� ���������, ������� �������� � ������������� ����������������� ������, ��������������� � ����������� ������������� ������.</b>
<b>�� ������������ ���������� ������ ��������� � ������ � ��� ������ ����� ����� ������� ������������.</b>
<b>� ��� � ���������� ������� ��� ��������� �����-���� ��� ����������. �� ������ ������ ��������������� �� �� ������� ������������.</b>
<b>���������� ���� �������� �������, ���������� ���������� ����. ������� � ����� ���. ������ �������������� ������ ����.</b>

<b>�������:</b>
1. �������� ���������� ������ ����.
2. �������� �������� �� ���, ��������� ������� ������������.
3. ���������� ������� ��������� ����.
4. ��������� ���������� ������������ �� ������� �����.
	"}
	outfit = /datum/outfit/lavaland_syndicate/comms

/datum/outfit/lavaland_syndicate/comms
	name = "Syndicate Telecomms Agent"
	r_hand = /obj/item/weapon/melee/energy/sword/saber
	mask = /obj/item/clothing/mask/chameleon
	uniform = /obj/item/clothing/under/syndicate
	suit = /obj/item/clothing/suit/armor/vest
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/combat
	ears = /obj/item/device/radio/headset/syndicate/alt
	back = /obj/item/weapon/storage/backpack
	r_pocket = /obj/item/weapon/gun/ballistic/automatic/pistol
	l_pocket = /obj/item/weapon/door_remote/syndicate
	id = /obj/item/weapon/card/id/syndicate/comms
	implants = list(/obj/item/weapon/implant/weapons_auth)

/obj/effect/mob_spawn/human/lavaland_syndicate/botanist
	name = "Syndicate Botanist Agent"
	flavour_text = {"
<b>�� ��������� ������� ���������, ������� �������� � ������������� ����������������� ������, ��������������� � ����������� ������������� ������.</b>
<b>�� ������������ ������-��������, ������� ������ � ������� � ��������� ������� ���������.</b>
<b>���������� ���� �������� �������, ������������ ��������. �������������� � �������� �������� �������. ������ �������������� ������ ����.</b>

<b>�������:</b>
1. �������� ���� ����������� ����������� ���� ��� ����������� ������.
2. ����������� ������� ��������, ����������� ��������������� ����� � ���������� ����.
3. �� ����������� ��������� ������ � ������ ������� ��������, ������� ����� ���� �������.
4. ��������� ���������� ������������ �� ������� �����.
	"}
	outfit = /datum/outfit/lavaland_syndicate/botanist

/datum/outfit/lavaland_syndicate/botanist
	name = "Syndicate Botanist Agent"
	r_hand = /obj/item/weapon/gun/ballistic/automatic/c20r/sc_c20r
	uniform = /obj/item/clothing/under/rank/hydroponics
	suit = /obj/item/clothing/suit/toggle/labcoat
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/botanic_leather
	ears = /obj/item/device/radio/headset/syndicate/alt
	back = /obj/item/weapon/storage/backpack
	r_pocket = /obj/item/weapon/gun/ballistic/automatic/pistol
	l_pocket = /obj/item/weapon/crowbar/red
	id = /obj/item/weapon/card/id/syndicate/botanist
	implants = list(/obj/item/weapon/implant/weapons_auth)

/obj/effect/mob_spawn/human/lavaland_syndicate/chemist
	name = "Syndicate Chemist Agent"
	flavour_text = {"
<b>�� ��������� ������� ���������, ������� �������� � ������������� ����������������� ������, ��������������� � ����������� ������������� ������.</b>
<b>�� ������������ ������-��������, ������� ������ � ������� � ��������� ������� ���������.</b>
<b>���������� ���� �������� �������, ������������ ��������. �������������� � �������� �������� �������. ������ �������������� ������ ����.</b>

<b>�������:</b>
1. �������� ���� ����������� ����������� �������� (� ����� ����) �� ���� �������� ����� �����.
2. ���������� ����������� ���������� ������ ������ (������������� ��� ���������).
3. ������������������, �����������, �������������, ��������� (� ���������� ���������) - ���� �������� ������.
4. ��������� ���������� ������������ �� ������� �����.
	"}
	outfit = /datum/outfit/lavaland_syndicate/chemist

/datum/outfit/lavaland_syndicate/chemist
	name = "Syndicate Chemist Agent"
	r_hand = /obj/item/weapon/gun/ballistic/automatic/c20r/sc_c20r
	uniform = /obj/item/clothing/under/rank/chemist
	suit = /obj/item/clothing/suit/toggle/labcoat
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/color/latex
	ears = /obj/item/device/radio/headset/syndicate/alt
	back = /obj/item/weapon/storage/backpack
	r_pocket = /obj/item/weapon/gun/ballistic/automatic/pistol
	l_pocket = /obj/item/weapon/crowbar/red
	id = /obj/item/weapon/card/id/syndicate/chemist
	implants = list(/obj/item/weapon/implant/weapons_auth)

/obj/effect/mob_spawn/human/lavaland_syndicate/virologist
	name = "Syndicate Virologist Agent"
	flavour_text = {"
<b>�� ��������� ������� ���������, ������� �������� � ������������� ����������������� ������, ��������������� � ����������� ������������� ������.</b>
<b>�� ������������ ������-��������, ������� ������ � ������� � ��������� ������� ���������.</b>
<b>���������� ���� �������� �������, ������������ ��������. �������������� � �������� �������� �������. ������ �������������� ������ ����.</b>

<b>�������:</b>
1. ������� ����� ������������-��������� ������.
2. ������� ����� ������������-�������� ������.
3. �� ����������� ������������������ �� ���������, ����������� ��� ������ ����� ����� � ���������� ����.
4. ��������� ���������� ������������ �� ������� �����.
	"}
	outfit = /datum/outfit/lavaland_syndicate/virologist

/datum/outfit/lavaland_syndicate/virologist
	name = "Syndicate Virologist Agent"
	r_hand = /obj/item/weapon/gun/ballistic/automatic/c20r/sc_c20r
	uniform = /obj/item/clothing/under/rank/virologist
	suit = /obj/item/clothing/suit/toggle/labcoat
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/color/latex
	ears = /obj/item/device/radio/headset/syndicate/alt
	back = /obj/item/weapon/storage/backpack
	r_pocket = /obj/item/weapon/gun/ballistic/automatic/pistol
	l_pocket = /obj/item/weapon/crowbar/red
	id = /obj/item/weapon/card/id/syndicate/virologist
	implants = list(/obj/item/weapon/implant/weapons_auth)

/obj/effect/mob_spawn/human/lavaland_syndicate/engineer
	name = "Syndicate Engineer Agent"
	flavour_text = {"
<b>�� ��������� ������� ���������, ������� �������� � ������������� ����������������� ������, ��������������� � ����������� ������������� ������.</b>
<b>�� ������������ ������-��������, ������� ������ � ������� � ��������� ������� ���������.</b>
<b>���������� ���� �������� �������, ������������ ��������. �������������� � �������� �������� �������. ������ �������������� ������ ����.</b>

<b>�������:</b>
1. ��������� ������ ������� �� �����-����, �������� ������� ��������� �������.
2. ��������� � ������ ���������� ����������.
3. ������������ ����������� ����������� ������� ����.
4. ��������� ���������� ������������ �� ������� �����.
	"}
	outfit = /datum/outfit/lavaland_syndicate/engineer

/datum/outfit/lavaland_syndicate/engineer
	name = "Syndicate Engineer Agent"
	r_hand = /obj/item/weapon/gun/ballistic/automatic/c20r/sc_c20r
	uniform = /obj/item/clothing/under/rank/engineer
	suit = /obj/item/clothing/suit/toggle/labcoat
	belt = /obj/item/weapon/storage/belt/utility/full
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/combat
	ears = /obj/item/device/radio/headset/syndicate/alt
	back = /obj/item/weapon/storage/backpack
	r_pocket = /obj/item/weapon/gun/ballistic/automatic/pistol
	l_pocket = /obj/item/weapon/crowbar/red
	id = /obj/item/weapon/card/id/syndicate/engineer
	implants = list(/obj/item/weapon/implant/weapons_auth)

/obj/effect/mob_spawn/human/lavaland_syndicate/miner
	name = "Syndicate Miner Agent"
	flavour_text = {"
<b>�� ��������� ������������ �������� ���������, ������� �������� � ������������� ����������������� ������, ��������������� � ����������� ������������� ������.</b>
<b>�� ������������ ������-��������, ������� ������ � ������� � ��������� ������� ���������.</b>
<b>���������� ���� �������� �������, ������������ ��������. �������������� � �������� �������� �������. ������ �������������� ������ ����.</b>

<b>�������:</b>
1. ������� �� ���������� ���� ��������� "������" �� ���������.
2. ����� ����������� �������������� ��� ������ ��������.
3. ��������� � ������� �� ���������� ����������� ���� "�������".
4. ��������� ��� ����������� ������������ � "��������", ������ � ����������� ����. ��������� ���������� ������ �� ������� "�������-03".
	"}
	outfit = /datum/outfit/lavaland_syndicate/miner

/datum/outfit/lavaland_syndicate/miner
	name = "Syndicate Miner Agent"
	r_hand = /obj/item/weapon/gun/ballistic/automatic/c20r/sc_c20r
	uniform = /obj/item/clothing/under/rank/miner
	belt = /obj/item/weapon/storage/belt/utility/full
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/combat
	ears = /obj/item/device/radio/headset/syndicate/alt
	back = /obj/item/weapon/storage/backpack
	r_pocket = /obj/item/weapon/gun/ballistic/automatic/pistol
	l_pocket = /obj/item/weapon/crowbar/red
	id = /obj/item/weapon/card/id/syndicate/miner
	implants = list(/obj/item/weapon/implant/weapons_auth)

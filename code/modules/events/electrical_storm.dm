/datum/round_event_control/electrical_storm
	name = "Electrical Storm"
	typepath = /datum/round_event/electrical_storm
	earliest_start = 6000
	min_players = 0
	weight = 40
	alertadmins = 0

/datum/round_event/electrical_storm
	var/lightsoutAmount	= 1
	var/lightsoutRange	= 25
	announceWhen	= 1

/datum/round_event/electrical_storm/announce()
	priority_announce("� ����� ������� ������������ ������������ ��� ��������� ������������� �����. ����������, ��������� � �������������� ���� ������������.", "�������! ������������� �����!")


/datum/round_event/electrical_storm/start()
	var/list/epicentreList = list()

	for(var/i=1, i <= lightsoutAmount, i++)
		var/list/possibleEpicentres = list()
		for(var/obj/effect/landmark/newEpicentre in GLOB.landmarks_list)
			if(newEpicentre.name == "lightsout" && !(newEpicentre in epicentreList))
				possibleEpicentres += newEpicentre
		if(possibleEpicentres.len)
			epicentreList += pick(possibleEpicentres)
		else
			break

	if(!epicentreList.len)
		return

	for(var/obj/effect/landmark/epicentre in epicentreList)
		for(var/obj/machinery/power/apc/apc in urange(lightsoutRange, epicentre))
			apc.overload_lighting()

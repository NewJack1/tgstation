/datum/round_event_control/anomaly/anomaly_flux
	name = "Anomaly: Hyper-Energetic Flux"
	typepath = /datum/round_event/anomaly/anomaly_flux

	min_players = 10
	max_occurrences = 0
	weight = 20

/datum/round_event/anomaly/anomaly_flux
	startWhen = 10
	announceWhen = 3

/datum/round_event/anomaly/anomaly_flux/announce()
	priority_announce("������� �������� ������� �������� ���������� ����� �����-��������������� ������. ����� ���������� �����������: [impact_area.name].", "�������! ��������!")


/datum/round_event/anomaly/anomaly_flux/start()
	var/turf/T = safepick(get_area_turfs(impact_area))
	if(T)
		newAnomaly = new /obj/effect/anomaly/flux(T)

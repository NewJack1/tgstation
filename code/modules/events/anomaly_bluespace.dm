/datum/round_event_control/anomaly/anomaly_bluespace
	name = "Anomaly: Bluespace"
	typepath = /datum/round_event/anomaly/anomaly_bluespace
	max_occurrences = 1
	weight = 5

/datum/round_event/anomaly/anomaly_bluespace
	startWhen = 3
	announceWhen = 10


/datum/round_event/anomaly/anomaly_bluespace/announce()
	priority_announce("—канеры дальнего радиуса действи€ обнаружили нестабильную BlueSpace аномалию. предположительное место: [impact_area.name].", "У“ревога! јномали€!")


/datum/round_event/anomaly/anomaly_bluespace/start()
	var/turf/T = safepick(get_area_turfs(impact_area))
	if(T)
		newAnomaly = new /obj/effect/anomaly/bluespace(T)

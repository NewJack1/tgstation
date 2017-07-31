/mob/living/silicon/robot/say_quote(var/text)
	if(get_custom_quote(text))
		return ..(text, list(SPAN_ROBOT))

/mob/living/silicon/robot/IsVocal()
	return !config.silent_borg

/datum/round_event_control/meteor_wave/meaty
	name = "Meteor Wave: Meaty"
	typepath = /datum/round_event/meteor_wave/meaty
	weight = 2
	max_occurrences = 0

/datum/round_event/meteor_wave/meaty
	wave_name = "meaty"

/datum/round_event/meteor_wave/meaty/announce()
	priority_announce("������ ����� ���������� ����� �� ����� �������.", "�������� ��� �����!",'sound/ai/meteors.ogg')

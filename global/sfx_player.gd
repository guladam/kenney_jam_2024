extends Node


func play(sfx: AudioStream, single=false) -> void:
	if not sfx:
		return
		
	if single:
		stop()

	for player: AudioStreamPlayer in get_children():
		if not player.playing:
			player.stream = sfx
			player.play()
			break


func stop() -> void:
	for player: AudioStreamPlayer in get_children():
		player.stop()

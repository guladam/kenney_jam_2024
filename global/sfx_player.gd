extends Node

const ATTACKS := [
	preload("res://assets/attack_big.ogg"),
	preload("res://assets/attack_plate.ogg"),
	preload("res://assets/attack_tin.ogg"),
	preload("res://assets/attack_wood.ogg")
]

const BLOCKS := [
	preload("res://assets/block.ogg"),
	preload("res://assets/block2.ogg")
]

func play(sfx: AudioStream, single=false) -> void:
	if not sfx:
		return
		
	if single:
		stop()

	for player: AudioStreamPlayer in get_children():
		if not player.playing:
			if player.stream.streams_count == 1:
				player.stream.remove_stream(0)
			player.stream.add_stream(0, sfx)
			player.play()
			break


func stop() -> void:
	for player: AudioStreamPlayer in get_children():
		player.stop()

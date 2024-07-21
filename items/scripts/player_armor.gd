extends ItemStats

@export var amount := 1


func activate() -> void:
	player.stats.armor += amount
	SFXPlayer.play(SFXPlayer.BLOCKS.pick_random())

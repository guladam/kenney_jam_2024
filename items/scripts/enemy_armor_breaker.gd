extends ItemStats


func activate() -> void:
	player.stats.armor = 0
	SFXPlayer.play(SFXPlayer.ATTACKS.pick_random())

extends ItemStats


func activate() -> void:
	enemy.stats.armor = 0
	SFXPlayer.play(SFXPlayer.ATTACKS.pick_random())

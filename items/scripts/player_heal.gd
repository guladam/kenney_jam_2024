extends ItemStats

@export var amount := 1


func activate() -> void:
	player.heal_tween()
	player.stats.health += amount

extends ItemStats

@export var amount := 1


func activate() -> void:
	player.stats.armor += amount

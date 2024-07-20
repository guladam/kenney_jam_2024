extends ItemStats

@export var amount := 1


func activate() -> void:
	enemy.stats.armor += amount

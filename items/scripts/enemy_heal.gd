extends ItemStats

@export var amount := 1


func activate() -> void:
	enemy.heal_tween()
	enemy.stats.health += amount

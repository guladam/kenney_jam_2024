class_name EnemyStats
extends Stats

@export var items: Array[ItemStats]
@export var cooldown_between_items := 1.0


func setup() -> void:
	health = max_hp

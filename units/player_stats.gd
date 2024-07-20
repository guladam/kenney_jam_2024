class_name PlayerStats
extends Stats

@export var starter_items: Array[ItemStats]
@export var max_connections: int
@export var item_slots: PackedScene
@export var upgrades: int

var connections: int : set = _set_connections


func setup_game() -> void:
	connections = max_connections


func _set_connections(value: int) -> void:
	connections = value
	stats_changed.emit()

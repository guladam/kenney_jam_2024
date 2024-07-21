class_name PlayerStats
extends Stats

@export var items: Array[ItemStats]
@export var max_connections: int
@export var item_slots: PackedScene
@export var upgrades: int

var connections: int : set = _set_connections


func setup() -> void:
	health = max_hp
	connections = max_connections


func _set_connections(value: int) -> void:
	connections = value
	stats_changed.emit()


func get_deep_copy() -> PlayerStats:
	var copy: PlayerStats = self.duplicate()
	var new_item_array: Array[ItemStats] = []
	
	for item: ItemStats in items:
		new_item_array.append(item.duplicate())
	
	copy.items = new_item_array
	
	return copy

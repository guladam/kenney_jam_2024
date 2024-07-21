class_name ItemHandler
extends Node2D

const ITEM = preload("res://scenes/item/item.tscn")

@export var player_stats: PlayerStats


func spawn_items() -> void:
	Item.connections = {}
	
	var instance := player_stats.item_slots.instantiate()
	var i := 0
	
	for marker: Node2D in instance.get_children():
		var item := ITEM.instantiate() as Item
		item.global_position = marker.global_position
		item.connected_to_item.connect(_on_item_connected_to_item)
		item.disconnected_from_item.connect(_on_item_disconnected_from_item)
		add_child(item)
		item.item_stats = player_stats.items[i]
		print("initialized?")
		item.item_stats.initialize()
		i += 1
	
	instance.queue_free()


func disable_connecting() -> void:
	for item: Item in get_children():
		item.enabled = false


func _on_item_connected_to_item() -> void:
	if not player_stats:
		return
	
	player_stats.connections -= 1


func _on_item_disconnected_from_item() -> void:
	if not player_stats:
		return
	
	player_stats.connections += 1

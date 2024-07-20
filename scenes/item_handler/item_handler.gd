extends Node2D


func _ready() -> void:
	spawn_items(preload("res://characters/warrior/warrior_items.tscn"))
	#await get_tree().create_timer(10).timeout
	#get_child(0).activate()


func spawn_items(items: PackedScene) -> void:
	var instance := items.instantiate()
	
	for item: Item in instance.get_children():
		item.owner = null
		item.reparent(self)
	
	instance.queue_free()

class_name UpgradeMinusPlus
extends HBoxContainer

enum Type {MINUS, PLUS}

const MINUS = preload("res://assets/minus.png")
const PLUS = preload("res://assets/plus.png")

var item_assigned: ItemStats

@onready var icon: TextureRect = $Icon
@onready var item_texture: TextureRect = $Item


func setup(type: Type, item: ItemStats) -> void:
	item_assigned = item
	
	match type:
		Type.MINUS: 
			icon.texture = MINUS
			icon.modulate = Color.DARK_RED
		Type.PLUS:
			icon.texture = PLUS
			icon.modulate = Color.DARK_GREEN
	
	item_texture.texture.region.position = item.icon_coordinates * 16


func _on_item_mouse_entered() -> void:
	if ItemTooltip.current_item != item_assigned:
		ItemTooltip.show_tooltip(item_texture.global_position + Vector2(35, 0), item_assigned)
	else:
		ItemTooltip.hide_tooltip()


func _on_item_mouse_exited() -> void:
	ItemTooltip.hide_tooltip()

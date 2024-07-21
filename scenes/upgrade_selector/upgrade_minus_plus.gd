class_name UpgradeMinusPlus
extends HBoxContainer

enum Type {MINUS, PLUS}

const MINUS = preload("res://assets/minus.png")
const PLUS = preload("res://assets/plus.png")

@onready var icon: TextureRect = $Icon
@onready var lost_item: TextureRect = $LostItem


func setup(type: Type, item: ItemStats) -> void:
	match type:
		Type.MINUS: 
			icon.texture = MINUS
			icon.modulate = Color.DARK_RED
		Type.PLUS:
			icon.texture = PLUS
			icon.modulate = Color.DARK_GREEN
	
	lost_item.texture.region.position = item.icon_coordinates * 16

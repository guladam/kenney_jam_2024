extends CanvasLayer

@onready var panel_container: PanelContainer = $PanelContainer
@onready var label: Label = %Label

var current_item: ItemStats


func show_tooltip(pos: Vector2, item: ItemStats) -> void:
	current_item = item
	panel_container.position = pos
	label.text = item.tooltip
	show()


func hide_tooltip() -> void:
	current_item = null
	hide()

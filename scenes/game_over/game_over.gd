extends PanelContainer

signal restart_button_pressed

const MENU = "res://scenes/menu/menu.tscn"


func _on_restart_button_pressed() -> void:
	restart_button_pressed.emit()


func _on_main_menu_pressed() -> void:
	SceneTransition.change_to_scene(MENU)

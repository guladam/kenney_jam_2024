extends Control

@onready var play_button: Button = %PlayButton
@onready var quit_button: Button = %QuitButton


func _on_play_button_pressed() -> void:
	SceneTransition.change_to_scene("res://scenes/game/game.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()

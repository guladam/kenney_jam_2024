extends Control

@onready var play_button: Button = %PlayButton
@onready var quit_button: Button = %QuitButton


func _on_play_button_pressed() -> void:
	SceneTransition.change_to_scene("res://scenes/game/game.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_youtube_channel_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse"):
		OS.shell_open("https://youtube.com/@godotgamelab")

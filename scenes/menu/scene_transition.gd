extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func change_to_scene(new_scene: String) -> void:
	animation_player.play("fade")
	await animation_player.animation_finished
	get_tree().change_scene_to_file(new_scene)
	animation_player.play_backwards("fade")

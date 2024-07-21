class_name ConnectionUI
extends HBoxContainer

@export var player_stats: PlayerStats : set = _set_player_stats

@onready var label: Label = $Label


func _set_player_stats(value: PlayerStats) -> void:
	if player_stats:
		player_stats.stats_changed.disconnect(_on_player_stats_changed)

	player_stats = value
	
	if player_stats:
		player_stats.stats_changed.connect(_on_player_stats_changed)


func _on_player_stats_changed() -> void:
	if not is_node_ready():
		await ready
	
	label.text = str(player_stats.connections)

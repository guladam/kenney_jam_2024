class_name GameUI
extends CanvasLayer

@export var player_stats: PlayerStats

@onready var player_stats_ui: StatsUI = %PlayerStats
@onready var enemy_stats_ui: StatsUI = %EnemyStats
@onready var connection_ui: ConnectionUI = %ConnectionUI
@onready var start_fight_button: Button = %StartFightButton


func setup_ui(p_stats: PlayerStats, e_stats: EnemyStats) -> void:
	player_stats_ui.stats = p_stats
	enemy_stats_ui.stats = e_stats
	connection_ui.player_stats = p_stats
	start_fight_button.disabled = true
	
	player_stats.stats_changed.connect(_on_player_stats_changed)


func _on_player_stats_changed() -> void:
	start_fight_button.disabled = player_stats.connections == player_stats.max_connections or player_stats.connections < 0


func _on_start_fight_button_pressed() -> void:
	start_fight_button.hide()

class_name GameUI
extends CanvasLayer

@export var player_stats: PlayerStats

@onready var player_stats_ui: StatsUI = %PlayerStats
@onready var enemy_stats_ui: StatsUI = %EnemyStats
@onready var connection_ui: ConnectionUI = %ConnectionUI
@onready var start_fight_button: Button = %StartFightButton
@onready var tutorial_1: PanelContainer = %Tutorial1
@onready var tutorial_2: PanelContainer = %Tutorial2
@onready var game_over: PanelContainer = %GameOver
@onready var game_won: PanelContainer = %GameWon


func setup_ui(p_stats: PlayerStats, e_stats: EnemyStats) -> void:
	player_stats_ui.stats = p_stats
	enemy_stats_ui.stats = e_stats
	connection_ui.player_stats = p_stats
	start_fight_button.disabled = true
	
	player_stats.stats_changed.connect(_on_player_stats_changed)


func show_tutorial() -> void:
	tutorial_1.show()


func show_game_won() -> void:
	game_won.show()

func show_game_over() -> void:
	game_over.show()


func _on_player_stats_changed() -> void:
	start_fight_button.disabled = player_stats.connections == player_stats.max_connections or player_stats.connections < 0


func _on_start_fight_button_pressed() -> void:
	start_fight_button.hide()


func _on_tutorial_1_button_pressed() -> void:
	tutorial_2.show()
	tutorial_1.hide()


func _on_tutorial_2_button_pressed() -> void:
	tutorial_2.hide()

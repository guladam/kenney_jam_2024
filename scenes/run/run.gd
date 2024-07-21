extends Node2D

const GAME = preload("res://scenes/game/game.tscn")

@export var levels: Array[Level]
@export var starter_player_stats: PlayerStats

var player_stats: PlayerStats

@onready var current_level: Node2D = $CurrentLevel
@onready var game_over: PanelContainer = %GameOver
@onready var game_won: PanelContainer = %GameWon
@onready var upgrade_selector: UpgradeSelector = %UpgradeSelector
@onready var level_over_timer: Timer = %LevelOverTimer
@onready var level_index := 0


func _ready() -> void:
	player_stats = starter_player_stats.get_deep_copy()
	upgrade_selector.player_stats = player_stats
	upgrade_selector.upgrade_selected.connect(_on_upgrade_selected)
	_spawn_level()


func _spawn_level() -> void:
	var game := GAME.instantiate() as Game
	game.level = levels[level_index]
	game.player_stats = player_stats
	game.lost.connect(_on_level_lost)
	game.won.connect(_on_level_won)
	current_level.add_child(game)


func _show_upgrade_selector() -> void:
	var old_level := current_level.get_child(0)
	old_level.queue_free()
	upgrade_selector.spawn_upgrades()


func _on_level_lost() -> void:
	level_over_timer.start()
	level_over_timer.timeout.connect(game_over.show, CONNECT_ONE_SHOT)


func _on_level_won() -> void:
	var callback: Callable
	level_over_timer.start()
	
	if level_index == 5:
		callback = game_won.show
	else:
		callback = _show_upgrade_selector
		
	level_over_timer.timeout.connect(callback, CONNECT_ONE_SHOT)


func _on_game_over_restart_button_pressed() -> void:
	game_over.hide()
	
	var old_level := current_level.get_child(0)
	old_level.queue_free()
	old_level.tree_exited.connect(_spawn_level)
	

func _on_upgrade_selected() -> void:
	level_index += 1
	_spawn_level()

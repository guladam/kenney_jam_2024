extends Node2D

@export var level: Level
@export var player_stats: PlayerStats

@onready var item_handler: ItemHandler = $ItemHandler
@onready var player: Character = $Player
@onready var enemy: Character = $Enemy
@onready var enemy_ai: EnemyAI = $EnemyAI
@onready var game_ui: GameUI = $GameUI


func _ready() -> void:
	start_game()


func start_game() -> void:
	item_handler.player_stats = player_stats
	player.stats = player_stats
	enemy.stats = level.enemy
	enemy_ai.enemy_stats = level.enemy
	game_ui.setup_ui(player_stats, level.enemy)
	player_stats.setup_game()
	item_handler.spawn_items()
	
	if level.tutorial:
		game_ui.show_tutorial()
	
	player.died.connect(_on_player_died)
	enemy.died.connect(_on_enemy_died)


func _on_start_fight_button_pressed() -> void:
	var first_item := Item.connections.keys()[0] as Item
	first_item.activate()
	item_handler.disable_connecting()
	enemy_ai.start_playing()


func _on_player_died() -> void:
	game_ui.show_game_over()
	item_handler.queue_free()
	enemy_ai.queue_free()


func _on_enemy_died() -> void:
	item_handler.queue_free()
	enemy_ai.queue_free()

	if level.difficulty == 5:
		game_ui.show_game_won()
	else:
		print("show upgrades :)")

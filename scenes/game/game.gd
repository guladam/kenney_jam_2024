extends Node2D

@export var level: Level
@export var player_stats: PlayerStats
@export var enemy_stats: EnemyStats

@onready var item_handler: ItemHandler = $ItemHandler
@onready var player: Character = $Player
@onready var enemy: Character = $Enemy
@onready var game_ui: GameUI = $GameUI
@onready var tutorial_1: PanelContainer = %Tutorial1


func _ready() -> void:
	start_game()


func start_game() -> void:
	item_handler.player_stats = player_stats
	player.stats = player_stats
	enemy.stats = enemy_stats
	game_ui.setup_ui(player_stats, enemy_stats)
	player_stats.setup_game()
	item_handler.spawn_items()
	if level.tutorial:
		tutorial_1.show()


func _on_start_fight_button_pressed() -> void:
	var first_item := Item.connections.keys()[0] as Item
	first_item.activate()
	item_handler.disable_connecting()

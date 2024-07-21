class_name EnemyAI
extends Node2D

@export var enemy_stats: EnemyStats

@onready var current_enemy_item: EnemyItem = $CurrentEnemyItem
@onready var next_enemy_item: EnemyItem = $NextEnemyItem
@onready var cooldown_timer: Timer = $CooldownTimer

var current_item: int


func start_playing() -> void:
	cooldown_timer.wait_time = enemy_stats.cooldown_between_items
	current_enemy_item.item_activated.connect(_on_current_item_activated)
	current_item = 0
	_update_actions()
	show()
	current_enemy_item.activate()


func _get_item_stats(index: int) -> ItemStats:
	var wrapped_index := wrapi(index, 0, enemy_stats.items.size())
	return enemy_stats.items[wrapped_index]


func _update_actions() -> void:
	current_enemy_item.item_stats = _get_item_stats(current_item)
	next_enemy_item.item_stats = _get_item_stats(current_item + 1)


func _on_current_item_activated() -> void:
	current_item += 1
	_update_actions()
	cooldown_timer.start()


func _on_cooldown_timer_timeout() -> void:
	current_enemy_item.activate()

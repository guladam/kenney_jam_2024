class_name Upgrade
extends PanelContainer

signal upgrade_selected

enum Type {ITEM_SWAP, PLUS_MAX_HP, PLUS_CONNECTION}

const UPGRADE_MINUS_PLUS = preload("res://scenes/upgrade_selector/upgrade_minus_plus.tscn")
const UPGRADE_PLUS_HEALTH = preload("res://scenes/upgrade_selector/upgrade_plus_health.tscn")
const UPGRADE_PLUS_CONNECTION = preload("res://scenes/upgrade_selector/upgrade_plus_connection.tscn")

@export var item_pool: Array[ItemStats]

var player_stats: PlayerStats
var lost_item: ItemStats
var gained_item: ItemStats
var type: Type

@onready var visuals: VBoxContainer = %Visuals


func set_upgrade(upgrade_type: Type, p_stats: PlayerStats) -> void:
	player_stats = p_stats
	
	match upgrade_type:
		Type.ITEM_SWAP:       _spawn_item_swap_upgrade()
		Type.PLUS_MAX_HP:     _spawn_plus_max_hp_upgrade()
		Type.PLUS_CONNECTION: _spawn_plus_connection_upgrade()


func _spawn_item_swap_upgrade() -> void:
	type = Type.ITEM_SWAP
	var minus := UPGRADE_MINUS_PLUS.instantiate() as UpgradeMinusPlus
	var plus := UPGRADE_MINUS_PLUS.instantiate() as UpgradeMinusPlus
	visuals.add_child(minus)
	visuals.add_child(plus)
	
	lost_item = player_stats.items.pick_random()
	gained_item = item_pool.pick_random()
	
	while gained_item.id == lost_item.id:
		gained_item = item_pool.pick_random()
	
	minus.setup(UpgradeMinusPlus.Type.MINUS, lost_item)
	plus.setup(UpgradeMinusPlus.Type.PLUS, gained_item)


func _spawn_plus_connection_upgrade() -> void:
	type = Type.PLUS_CONNECTION
	
	if player_stats.max_connections >= 6:
		_spawn_item_swap_upgrade()
		return

	var plus_conn := UPGRADE_PLUS_CONNECTION.instantiate()
	visuals.add_child(plus_conn)


func _spawn_plus_max_hp_upgrade() -> void:
	type = Type.PLUS_MAX_HP
	var plus_max_hp := UPGRADE_PLUS_HEALTH.instantiate()
	visuals.add_child(plus_max_hp)


func _apply_upgrade() -> void:
	match type:
		Type.ITEM_SWAP:
			player_stats.items.erase(lost_item)
			player_stats.items.append(gained_item)
		Type.PLUS_MAX_HP:
			player_stats.max_hp += 2
		Type.PLUS_CONNECTION:
			player_stats.max_connections += 1
		
	upgrade_selected.emit()


func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse"):
		_apply_upgrade()

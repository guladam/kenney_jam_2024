class_name UpgradeSelector
extends Control

signal upgrade_selected

const UPGRADE = preload("res://scenes/upgrade_selector/upgrade.tscn")
const UPGRADE_LAYOUT := [
	Upgrade.Type.ITEM_SWAP,
	Upgrade.Type.ITEM_SWAP,
	Upgrade.Type.PLUS_CONNECTION,
	Upgrade.Type.PLUS_MAX_HP
]

@export var player_stats: PlayerStats
@onready var upgrades: HBoxContainer = %Upgrades


func spawn_upgrades() -> void:
	for i in 4:
		var new_upgrade := UPGRADE.instantiate() as Upgrade
		upgrades.add_child(new_upgrade)
		new_upgrade.set_upgrade(UPGRADE_LAYOUT[i], player_stats)
		new_upgrade.upgrade_selected.connect(_on_upgrade_selected)
	show()


func _on_upgrade_selected() -> void:
	for upgrade: Upgrade in upgrades.get_children():
		upgrade.queue_free()
		
	upgrade_selected.emit()
	hide()

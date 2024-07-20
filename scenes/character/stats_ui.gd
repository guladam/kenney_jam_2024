class_name StatsUI
extends VBoxContainer

@export var stats: Stats : set = _set_stats

@onready var health_label: Label = %HealthLabel
@onready var armor_label: Label = %ArmorLabel


func _set_stats(value: Stats) -> void:
	if stats:
		stats.stats_changed.disconnect(_on_stats_changed)

	stats = value
	stats.stats_changed.connect(_on_stats_changed)
	_on_stats_changed()


func _on_stats_changed() -> void:
	if not is_node_ready():
		await ready
	
	health_label.text = str(stats.health)
	armor_label.text = str(stats.armor)

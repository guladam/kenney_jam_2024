class_name Stats
extends Resource

signal stats_changed
signal health_depleted

@export var health: int : set = _set_health
@export var armor: int : set = _set_armor
@export var sprite_coordinates: Vector2
@export var flip_h: bool


func take_damage(damage: int) -> void:
	if damage <= 0:
		return
		
	var initial_damage = damage
	damage = clampi(damage - armor, 0, damage)
	armor = clampi(armor - initial_damage, 0, armor)
	health -= damage


func _set_health(value: int) -> void:
	health = clampi(value, 0, 99)
	stats_changed.emit()
	
	if health <= 0:
		health_depleted.emit()


func _set_armor(value: int) -> void:
	armor = clampi(value, 0, 99)
	stats_changed.emit()

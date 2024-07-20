class_name Character
extends Node2D

signal attack_arrived
signal attack_finished

const DAMAGE_MATERIAL = preload("res://assets/damage_material.tres")
const HEAL_MATERIAL = preload("res://assets/heal_material.tres")

@export var attack_target_position: Node2D
@export var stats: Stats : set = _set_stats
@export var attack_anim_length := 0.5
@export var shader_anim_length := 0.3

var tween_move: Tween
var tween_shader: Tween

@onready var visuals: Sprite2D = $Sprite2D
@onready var original_position := position


func _ready() -> void:
	attack_arrived.connect(_on_attack_arrived)


func attack_tween() -> void:
	if not visuals:
		return
	
	if tween_move:
		tween_move.kill()
	
	tween_move = create_tween()
	tween_move.tween_property(self, "position", attack_target_position.position, attack_anim_length / 2.0)
	tween_move.finished.connect(func(): attack_arrived.emit(), CONNECT_ONE_SHOT)


func damage_tween() -> void:
	if not visuals:
		return
	
	if tween_shader:
		tween_shader.kill()
	
	tween_shader = create_tween()
	visuals.material = DAMAGE_MATERIAL
	tween_shader.tween_interval(shader_anim_length)
	tween_shader.finished.connect(func(): visuals.material = null, CONNECT_ONE_SHOT)


func heal_tween() -> void:
	if not visuals:
		return
	
	if tween_shader:
		tween_shader.kill()
	
	tween_shader = create_tween()
	visuals.material = HEAL_MATERIAL
	tween_shader.tween_interval(shader_anim_length)
	tween_shader.finished.connect(func(): visuals.material = null, CONNECT_ONE_SHOT)


func _set_stats(value: Stats) -> void:
	stats = value
	if stats and visuals:
		visuals.region_rect.position = stats.sprite_coordinates * 16
		visuals.flip_h = stats.flip_h


func _on_attack_arrived() -> void:
	if not visuals:
		return
	
	if tween_move:
		tween_move.kill()
	
	tween_move = create_tween()
	tween_move.tween_property(self, "position", original_position, attack_anim_length / 2.0)
	tween_move.finished.connect(func(): attack_finished.emit(), CONNECT_ONE_SHOT)

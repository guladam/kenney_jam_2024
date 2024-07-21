class_name ItemStats
extends Resource

@export var upgrades: Array[int]
@export var icon_coordinates: Vector2
@export var activation_time := 1.0

var player: Character
var enemy: Character


func initialize() -> void:
	player = _get_player()
	enemy = _get_enemy()


func activate() -> void:
	pass


func _get_player() -> Character:
	var tree := Engine.get_main_loop() as SceneTree
	if tree:
		return tree.get_first_node_in_group("player") as Character
	
	return null


func _get_enemy() -> Character:
	var tree := Engine.get_main_loop() as SceneTree
	if tree:
		return tree.get_first_node_in_group("enemy") as Character
	
	return null

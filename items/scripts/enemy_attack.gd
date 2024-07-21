extends ItemStats

const ATTACKS := [
	preload("res://assets/attack_big.ogg"),
	preload("res://assets/attack_plate.ogg"),
	preload("res://assets/attack_tin.ogg"),
	preload("res://assets/attack_wood.ogg")
]

@export var damage := 2


func activate() -> void:
	enemy.attack_tween()
	enemy.attack_arrived.connect(
		func(): 
			player.damage_tween()
			SFXPlayer.play(SFXPlayer.ATTACKS.pick_random())
			player.stats.take_damage(damage)
	, CONNECT_ONE_SHOT)

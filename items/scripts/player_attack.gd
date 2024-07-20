extends ItemStats

@export var damage := 2


func activate() -> void:
	player.attack_tween()
	player.attack_arrived.connect(
		func(): 
			enemy.damage_tween()
			enemy.stats.take_damage(damage)
	, CONNECT_ONE_SHOT)

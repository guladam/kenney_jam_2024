extends ItemStats

@export var damage := 2


func activate() -> void:
	enemy.attack_tween()
	enemy.attack_arrived.connect(
		func(): 
			player.damage_tween()
			player.stats.take_damage(damage)
	, CONNECT_ONE_SHOT)

extends ItemStats

@export var damage := 1
@export var heal := 1


func activate() -> void:
	player.attack_tween()
	player.attack_arrived.connect(
		func(): 
			enemy.damage_tween()
			SFXPlayer.play(SFXPlayer.ATTACKS.pick_random())
			enemy.stats.take_damage(damage)
			player.stats.health += 1
			player.heal_tween()
	, CONNECT_ONE_SHOT)

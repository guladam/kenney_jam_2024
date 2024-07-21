extends ItemStats

@export var damage := 1
@export var heal := 1


func activate() -> void:
	enemy.attack_tween()
	enemy.attack_arrived.connect(
		func(): 
			player.damage_tween()
			SFXPlayer.play(SFXPlayer.ATTACKS.pick_random())
			player.stats.take_damage(damage)
			enemy.stats.health += 1
			enemy.heal_tween()
	, CONNECT_ONE_SHOT)

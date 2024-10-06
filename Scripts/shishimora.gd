extends Mob

func ready_func():
	dirRightAnim = false
	SPEED = 80
	$Panel/Label.text = "Шишимора: НЕ ТОПЧИ МОЙ МОХ, Я ЕГО ЕМММ!"
	super.ready_func()
	await get_tree().create_timer(3.0).timeout
	$Panel.visible = false

func _on_mob_health_no_health():
	if alive:
		state = DEATH

func _on_mob_health_received_damage(direction):
	direction_received_damage = direction
	state = HIT

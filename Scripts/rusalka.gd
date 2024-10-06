extends Mob

func ready_func():
	dirRightAnim = false
	SPEED = 100
	$Panel/Label.text = "Русалка: Наша лужа мала, тебе не положено здесь быть."
	super.ready_func()
	await get_tree().create_timer(3.0).timeout
	$Panel.visible = false
	

func _on_mob_health_no_health():
	if alive:
		state = DEATH

func _on_mob_health_received_damage(direction):
	direction_received_damage = direction
	state = HIT

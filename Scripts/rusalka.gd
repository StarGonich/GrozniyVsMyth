extends Mob

func ready_func():
	dirRightAnim = false
	SPEED = 100
	$Panel/Label.text = "Русалка: Наша лужа мала, тебе не положено здесь быть."
	super.ready_func()
	

func _on_mob_health_no_health():
	if alive:
		state = DEATH

func _on_mob_health_received_damage(direction):
	direction_received_damage = direction
	state = HIT

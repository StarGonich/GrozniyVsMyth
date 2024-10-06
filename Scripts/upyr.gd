extends Mob

func ready_func():
	dirRightAnim = false
	SPEED = 120
	$Panel/Label.text = "Водяной упырь: Свежая кровь! сладкая, свежая кровь! Я уже чувствую, как жизнь переполняет меня!"
	super.ready_func()

func physic_process_func(delta):
	if state != ATTACK1:
		$AnimatedSprite2D.position.y = 18
	else:
		$AnimatedSprite2D.position.y = 0
	super.physic_process_func(delta)

func _on_mob_health_no_health():
	if alive:
		state = DEATH

func _on_mob_health_received_damage(direction):
	direction_received_damage = direction
	state = HIT

extends CharacterBody2D

enum{
	MOVE,
	ATTACK
}

@onready var coyotTimer = $CoyotTimer
@onready var anim = $AnimatedSprite2D
@onready var animPlayer = $AnimationPlayer

var SPEED = 400
var JUMP_VELOCITY = -800
var gravity = 1000
var fall = false

var state: int = 0:
	set(value):
		state = value
		match state:
			MOVE: 
				move_state()
			ATTACK:
				attack_state()

func _physics_process(delta: float) -> void:
	
	if state == MOVE:
		if Input.is_action_just_pressed("JUMP"):
			if is_on_floor() || not coyotTimer.is_stopped():
				velocity.y = JUMP_VELOCITY
				anim.play("JumpStart")
		if velocity.y > 0:
			anim.play("Fall")
	
	if not is_on_floor():
		if velocity.y < 1000:
			velocity.y += gravity * delta
	
	if state == MOVE:
		move_state()
	
	var was_on_floor = is_on_floor()
	
	move_and_slide()
	
	if was_on_floor and not is_on_floor():
		coyotTimer.start()


func move_state():
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			anim.play("Run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			anim.play("Idle")
	
	if direction == -1:
		$AnimatedSprite2D.flip_h = true
	elif direction == 1:
		$AnimatedSprite2D.flip_h = false
	

func attack_state():
	pass

func _on_check_death_area_area_entered(area: Area2D) -> void:
	queue_free()

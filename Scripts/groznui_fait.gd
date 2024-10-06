extends CharacterBody2D

signal change_health(new_health)

enum{
	MOVE,
	ATTACK,
	HIT,
	DEATH
}

@onready var coyotTimer = $CoyotTimer
@onready var anim = $AnimatedSprite2D
@onready var animPlayer = $AnimationPlayer
@onready var animPlayerWater = $AnimationPlayerWater

var health = 15
var max_health = 15
var damage = 1
var death = false

var SPEED = 250
var JUMP_VELOCITY = -450
var gravity = 900
var fall = false
var direction 
var direction_dmg = 1
var state: int = 0:
	set(value):
		state = value
		match state:
			MOVE: 
				move_state()
			ATTACK:
				attack_state()
			HIT:
				hit_state()
			DEATH:
				death_state()

func _ready():
	if GlobalScene.lokation == 2:
		animPlayer = animPlayerWater
	else:
		anim.visible = true
		$AnimatedSprite2DWater.visible = false
		
	get_tree().paused = false
	Signals.connect("enemy_attack", Callable(self, "_on_enemy_damage_received"))

func _physics_process(delta: float) -> void:
	
	if state == MOVE:
		if Input.is_action_just_pressed("JUMP"):
			if is_on_floor() || not coyotTimer.is_stopped():
				velocity.y = JUMP_VELOCITY
				animPlayer.play("Jump")
		if velocity.y > 0:
			animPlayer.play("Fall")
	
	if not is_on_floor():
		if velocity.y < 800:
			velocity.y += gravity * delta
	
	if state == MOVE:
		move_state()
	
	var was_on_floor = is_on_floor()
	
	move_and_slide()
	
	if was_on_floor and not is_on_floor():
		coyotTimer.start()

	var player_pos = self.position
	Signals.emit_signal("player_update_position", player_pos)

func inverse_sprite():
	if direction == -1:
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2DWater.flip_h = true
		#$AnimatedSprite2D.offset.x = -12
		$DamageBox.scale.x = -1
	elif direction == 1:
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2DWater.flip_h = false
		#$AnimatedSprite2D.offset.x = 0
		$DamageBox.scale.x = 1
	

func move_state():
	direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		direction_dmg = direction
		velocity.x = direction * SPEED
		if velocity.y == 0:
			animPlayer.play("Run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			animPlayer.play("Idle")
			
	inverse_sprite()
	
	if Input.is_action_just_pressed("Attack"):
		state = ATTACK

func attack_state():
	velocity.x = 0
	animPlayer.play("Attack")
	await animPlayer.animation_finished
	state = MOVE


func hit_state():
	$DamageBox/HitBox/CollisionShape2D.set_deferred("disabled", true)
	coyotTimer.stop()
	animPlayer.play("Hit")
	await get_tree().create_timer(0.1).timeout
	velocity.y = -150
	velocity.x = -direction * 100
	await animPlayer.animation_finished
	state = MOVE
	

func death_state():
	velocity.x = 0
	animPlayer.play("Death")
	await animPlayer.animation_finished
	death = true
	
func _on_check_death_area_area_entered(area: Area2D) -> void:
	queue_free()
	
func _on_enemy_damage_received(enemy_damage):
	health -= enemy_damage
	if health <= 0:
		health = 0
		state = DEATH
	else:
		pass
		state = HIT
	emit_signal("change_health", health)
	
func _on_hit_box_area_entered(_area):
	Signals.emit_signal("player_attack", damage, direction_dmg)

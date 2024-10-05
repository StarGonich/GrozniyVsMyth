extends CharacterBody2D
class_name Mob

enum {
	IDLE,
	CHASE,
	ATTACK1,
	ATTACK2,
	HIT,
	DEATH
}

var gravity = 800
var dirRightAnim = true
var damage = 1
var SPEED = 50
var alive = true
var player
var direction
var direction_received_damage
var distant
var num_attack
var state: int = 0:
	set(value):
		state = value
		match state:
			IDLE:
				idle_state()
			CHASE:
				chase_state()
			ATTACK1:
				attack1_state()
			ATTACK2:
				attack2_state()
			HIT:
				hit_state()
			DEATH:
				death_state()
				
@onready var anim = $AnimatedSprite2D
@onready var animPlayer = $AnimationPlayer

func ready_func():
	Signals.connect("player_update_position", Callable(self, "_on_player_update_position"))

func _ready():
	ready_func()

func physic_process_func(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

func _physics_process(delta):
	physic_process_func(delta)
	move_and_slide()
	
func _process(_delta):
	if state == CHASE:
		chase_state()
	
func idle_state():
	animPlayer.play("Idle")
	await get_tree().create_timer(0.6).timeout
	$Collision/AreaAttack/CollisionAttack.disabled = false
	$Collision/Detector/DetectorCollision.disabled = false

func attack1_state():
	velocity.x = 0
	animPlayer.play("Attack1")
	await animPlayer.animation_finished
	$Collision/AreaAttack/CollisionAttack.disabled = true
	$Collision/Detector/DetectorCollision.disabled = true
	state = IDLE

func attack2_state():
	pass

func bool_in_integer(boolVar):
	if boolVar:
		return 1
	else:
		return -1

func chase_state():
	direction = (player - self.position).normalized()
	if alive:
		velocity.x = direction.x * SPEED
		if direction.x < 0:
			anim.flip_h = dirRightAnim
			anim.position.x = bool_in_integer(dirRightAnim)*int(abs(anim.position.x))
			$Collision/AreaAttack.scale.x = -1
			$DamageBox.scale.x = -1
		elif direction.x > 0:
			anim.flip_h = not dirRightAnim
			anim.position.x = bool_in_integer(not dirRightAnim)*int(abs(anim.position.x))
			$Collision/AreaAttack.scale.x = 1
			$DamageBox.scale.x = 1
		animPlayer.play("Walk")
		
func hit_state():
	velocity.x = 0
	velocity.y += -100
	velocity.x += direction_received_damage*100
	animPlayer.play("Hit")
	await animPlayer.animation_finished
	state = IDLE
		
func death_state():
	pass
	#velocity.x = 0
	#alive = false
	#$Collision/AreaAttack/CollisionAttack.set_deferred("disabled", true)
	#$Collision/Detector/DetectorCollision.set_deferred("disabled", true)
	#animPlayer.play("Death")
	#await animPlayer.animation_finished
	#queue_free()

func _on_player_update_position(player_pos):
	player = player_pos
	

func _on_area_attack_body_entered(_body):
	if alive:
		state = ATTACK1
		
func _on_detector_body_entered(_body):
	if alive:
		state = CHASE

func _on_detector_body_exited(_body):
	velocity.x = 0
	if alive:
		state = IDLE

func _on_hit_box_area_entered(_area):
	Signals.emit_signal("enemy_attack", damage)

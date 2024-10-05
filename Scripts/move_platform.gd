extends RigidBody2D

var time = 0
var speed = 1
var size = 5000
var isHoriz = false

func _physics_process(delta: float) -> void:
	time += delta 
	var movement = cos(time * speed)*size 
	if isHoriz:
		position.x = movement 
	else:
		position.y = movement * delta


func _on_move_platform_check_dis_call_move() -> void:
	$CollisionShape2D.set_deferred("disabled", true)

func _on_move_platform_check_show_call_move() -> void:
	$CollisionShape2D.set_deferred("disabled", false)

func _on_cheak_death_area_area_entered(area: Area2D) -> void:
	queue_free()

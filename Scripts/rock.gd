extends RigidBody2D

var speed = 8

func _process(delta: float) -> void:
	$Sprite2D.rotation += delta*speed

func _on_area_2d_area_entered(area: Area2D) -> void:
	queue_free()

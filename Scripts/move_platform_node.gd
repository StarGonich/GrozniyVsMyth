extends Node2D

var offset = Vector2(0, -200)
var duration = 5.0 

func _ready() -> void:
	var tween = get_tree().create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	tween.set_loops().set_parallel(false)
	tween.tween_property($AnimatableBody2D, "position", offset, duration / 2)
	tween.tween_property($AnimatableBody2D, "position", Vector2.ZERO, duration / 2)

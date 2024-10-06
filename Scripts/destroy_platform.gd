extends StaticBody2D

@onready var anim = $AnimatedSprite2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	await get_tree().create_timer(1.0).timeout
	$Area2D/CollisionShape2D.disabled = true
	$Player_check/CollisionShape2D.disabled = true
	hide()
	#queue_free()

func _on_destroy_platform_check_dis_call_destroy() -> void:
	$CollisionShape2D.set_deferred("disabled", true)
	$Area2D/CollisionShape2D.set_deferred("disabled", true)

func _on_destroy_platform_check_show_call_destroy() -> void:
	$CollisionShape2D.set_deferred("disabled", false)
	$Area2D/CollisionShape2D.set_deferred("disabled", false)

func _on_check_death_area_area_entered(area: Area2D) -> void:
	hide()
	#queue_free()

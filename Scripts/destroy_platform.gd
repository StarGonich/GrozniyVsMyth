extends StaticBody2D

@onready var anim = $AnimatedSprite2D

#func _process(delta: float) -> void:
	#if scale.x == 2/3:
		#$Sprite2D.texture = "res://Graphics/platformbrrmid.png"
	#elif scale.x == 1/3:
		#$Sprite2D.texture = "res://Graphics/platformbrrmini.png"

func _on_area_2d_body_entered(body: Node2D) -> void:
	await get_tree().create_timer(2.0).timeout
	#anim.play("Death")
	#await anim.animation_finished
	queue_free()

func _on_destroy_platform_check_dis_call_destroy() -> void:
	$CollisionShape2D.set_deferred("disabled", true)
	$Area2D/CollisionShape2D.set_deferred("disabled", true)

func _on_destroy_platform_check_show_call_destroy() -> void:
	$CollisionShape2D.set_deferred("disabled", false)
	$Area2D/CollisionShape2D.set_deferred("disabled", false)

func _on_check_death_area_area_entered(area: Area2D) -> void:
	queue_free()

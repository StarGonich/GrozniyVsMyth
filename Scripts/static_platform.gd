extends StaticBody2D

var textureMid = "res://Graphics/platform0.5.png"
var textureMini = "res://Graphics/platformmini.png"

func _on_static_platform_check_dis_call() -> void:
	$CollisionShape2D.set_deferred("disabled", true)

func _on_static_platform_check_show_call() -> void:
	$CollisionShape2D.set_deferred("disabled", false)

func _on_check_death_area_area_entered(area: Area2D) -> void:
	queue_free()

func _process(delta: float) -> void:
	if scale.x == 2/3:
		$Sprite2D.texture = textureMid
	elif scale.x == 1/3:
		$Sprite2D.texture = textureMini

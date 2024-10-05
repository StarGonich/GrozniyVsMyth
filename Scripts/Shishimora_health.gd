extends MobHealth


func ready_func():
	max_health = 5
	super.ready_func()


func _on_heart_box_area_entered(area: Area2D) -> void:
	await get_tree().create_timer(0.05).timeout
	health -= player_dmg
	if health <= 0:
		health = 0
		emit_signal("no_health")
		health_bar.visible = false
	else:
		emit_signal("received_damage", dir_received_dmg)

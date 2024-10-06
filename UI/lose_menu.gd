extends Control


func _on_restart_pressed() -> void:
	get_tree().paused = false
	match GlobalScene.cur_level:
		1, 3, 5:
			for platform in $"../..".platforms:
				get_tree().root.remove_child(platform)
		2:
			for enemy in $"../../Leshiy".enemys:
				get_tree().root.remove_child(enemy)
		4:
			for enemy in $"../../Vodanoy".enemys:
				get_tree().root.remove_child(enemy)
	get_tree().reload_current_scene()


func _on_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://UI/main_menu.tscn")

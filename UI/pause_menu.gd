extends Control

func resume():
	get_tree().paused = false
	$Panel.hide()
	$PauseButton.show()
	
	
func pause():
	get_tree().paused = true
	$Panel.show()
	$PauseButton.hide()
	

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		print("Нажата")
		if get_tree().paused:
			resume()
		else:
			pause()

func _on_resume_pressed() -> void:
	resume()

func _on_restart_pressed() -> void:
	resume()
	get_tree().reload_current_scene()

func _on_menu_pressed() -> void:
	resume()
	get_tree().change_scene_to_file("res://UI/main_menu.tscn")

func _on_pause_button_pressed() -> void:
	pause()

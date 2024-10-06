extends Control

@onready var settings = $Settings

func _ready() -> void:
	settings.back.connect(_on_back_pressed)
	
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
		if get_tree().paused:
			resume()
		else:
			pause()

func _on_resume_pressed() -> void:
	resume()

func _on_restart_pressed() -> void:
	resume()
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
	resume()
	get_tree().change_scene_to_file("res://UI/main_menu.tscn")

func _on_pause_button_pressed() -> void:
	pause()


func _on_settings_pressed() ->  void:
	$Panel.hide()
	$Settings.show()


func _on_back_pressed() -> void:
	$Settings.hide()
	$Panel.show()

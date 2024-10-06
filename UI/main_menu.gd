extends Control

@onready var settings = $Settings
@onready var credits = $Credits
@onready var main_menu_buttons = $MainMenuButtons as VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	settings.back.connect(_on_back_pressed)
	credits.back.connect(_on_back_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/scene_1.tscn")


func _on_settings_pressed() -> void:
	main_menu_buttons.visible = false
	settings.visible = true


func _on_credits_pressed() -> void:
	main_menu_buttons.visible = false
	credits.visible = true


func _on_back_pressed() -> void:
	settings.visible = false
	credits.visible = false
	main_menu_buttons.visible = true
	
	
func _on_exit_pressed() -> void:
	get_tree().quit()
	

extends Node2D

var lokation = 2

var cur_point = 1

var cur_level = 1

var level_1_complete = false:
	set(value):
		level_1_complete = value
		if value:
			await get_tree().create_timer(1.5).timeout
			get_tree().change_scene_to_file("res://Scenes/level_jump.tscn")
			
var level_2_complete = false:
	set(value):
		level_2_complete = value
		if value:
			await get_tree().create_timer(1.5).timeout
			get_tree().change_scene_to_file("res://Scenes/level_jump.tscn")

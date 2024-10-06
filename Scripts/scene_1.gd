extends CanvasLayer

@onready var label: Label = $Panel/CenterContainer/Label
@onready var timer: Timer = $Timer

var letter_index = 0
var text = ""
var letter_time = 0.02
var space_time = 0.05
var punct_time = 0.3
var stop = false
var numb_abz = 1
signal finished_display()

func _ready():
	_display_text("В далёком-далёком ХVI веке жил некий царь Иоанн. 
	Был он по слухам жестоким и кровожадным правителем, страшным тираном,
	лично казнившим непригодных. ")

func _display_text(text_to_display):
	text = text_to_display
	label.text = text_to_display
	label.text = ""
	if stop == false:
		_display_letter()
	
func _display_letter():
	if letter_index < text.length():
		label.text += text[letter_index]
	
	letter_index +=1
	if letter_index >= text.length():
		stop = true
	if letter_index < text.length():
		match text[letter_index]:
			"!", ".", ",", "?": timer.start(punct_time)
			" ": timer.start(space_time)
			_: timer.start(letter_time)
		
func _on_timer_timeout() -> void:
	_display_letter()
	
func _process(delta):
	if Input.is_action_just_pressed("Click") and stop == true:
		stop = false
		letter_index = 0
		match numb_abz:
			1: 
				_display_text("Так было не всегда, 
				тоска сгубила его, он жил в постоянном страхе. Был суеверным.
				 Казалось, сам бес за ним охоту повёл. Несчатие преследовало царя,
				 и он сам стал походить на его воплощение.")
			2: 
				_display_text("Никого не оставалось, и Иоанн преисполнился в 
				своей страсти к богу, велев построить..")
			3:
				_display_text("Нечто воистину прекрасное...")
			4:
				get_tree().change_scene_to_file("res://Scenes/level_jump.tscn")
		numb_abz+=1

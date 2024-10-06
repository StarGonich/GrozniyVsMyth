extends CanvasLayer

@onready var label: Label = $Panel2/Label
@onready var timer: Timer = $Timer

var letter_index = 0
var text = ""
var letter_time = 0.02
var space_time = 0.05
var punct_time = 0.3
var stop = false
var numb_abz = 1
signal finished_display()


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


func _ready():
	_display_text("Что-то я перемудрил с этими шишиморами, 
	как будто это кто-то больной писал, жизнь творца настолько тяжелая и 
	непонятная, что мне остается разве что молиться")
	await get_tree().create_timer(10.0).timeout
	$Panel2.hide()
	anim()

func anim():
	$Scene.scale.x = 1
	$Scene.scale.y = 1
	$Scene.texture = load("res://Graphics/end_scene1.png")
	await get_tree().create_timer(3.5).timeout
	$Panel3.visible = true
	$Scene.texture = load("res://Graphics/end_scene2.png")
	await get_tree().create_timer(3.5).timeout
	$Panel3.visible = false
	$Scene.texture = load("res://Graphics/end_scene3.png")
	await get_tree().create_timer(2.5).timeout
	$Groznui.freeze = false

func _on_check_ground_body_entered(body: Node2D) -> void:
	$Scene.texture = load("res://Graphics/end_scene4.png")
	await get_tree().create_timer(1.0).timeout
	$Panel.visible = true

func _on_button_pressed() -> void:
	get_tree().quit()

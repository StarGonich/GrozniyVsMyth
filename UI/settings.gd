extends Control

@onready var option_button = $VBoxContainer/VBoxContainer/ScreenMode/OptionButton as OptionButton
@onready var option_button2 = $VBoxContainer/VBoxContainer/Resolution/OptionButton as OptionButton


const WINDOW_MODE_ARRAY: Array[String] = [
	"Full-Screen",
	"Window",
	"Borderless Full-Screen",
	"Borderless Window"
]

const RESOLUTION_DICTIONARY: Dictionary = {
	"1920x1080": Vector2i(1920, 1080),
	"1366x768": Vector2i(1366, 768),
	"854x480": Vector2i(854, 480)
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	option_button.clear()
	option_button2.clear()
	for window_mode in WINDOW_MODE_ARRAY:
		option_button.add_item(window_mode)
	for resolution in RESOLUTION_DICTIONARY:
		option_button2.add_item(resolution)
	option_button.item_selected.connect(on_window_mode_selected)
	option_button2.item_selected.connect(on_resolution_selected)


func on_window_mode_selected(index : int) -> void:
	match index:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		2:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
		3:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
			
			
func on_resolution_selected(index: int) -> void:
	DisplayServer.window_set_size(RESOLUTION_DICTIONARY.values()[index])
	
	
signal back
func _on_back_pressed() -> void:
	back.emit()

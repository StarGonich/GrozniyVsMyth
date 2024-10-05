extends Node2D
class_name MobHealth

signal no_health()
signal received_damage(direction)

@onready var health_bar = $HealthBar

var dir_received_dmg

var player_dmg
var max_health = 1
var health:
	set(value):
		health = value
		health_bar.value = health
		health_bar.visible = true

func ready_func():
	health = max_health
	Signals.connect("player_attack", Callable(self, "_on_player_damage_received"))
	health_bar.max_value = max_health
	health_bar.visible = false

func _ready():
	ready_func()
	
func _on_player_damage_received(player_damage, direction_dmg):
	player_dmg = player_damage
	dir_received_dmg = direction_dmg

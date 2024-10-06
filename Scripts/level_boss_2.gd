extends Node2D

@onready var healthBar = $Health/HealthBar
@onready var player = $GroznuiFait


func _ready():
	healthBar.max_value = player.max_health
	healthBar.value = healthBar.max_value
	
func _process(delta: float) -> void:
	if $GroznuiFait.death:
		get_tree().paused = true 
		$CanvasLayer/LoseMenu.visible = true

func _on_groznui_fait_change_health(new_health: Variant) -> void:
	healthBar.value = new_health	

extends Area2D

var damage = 1

@onready var animPlayer = $AnimationPlayer

func _ready():
	animPlayer.play("Attack")
	await animPlayer.animation_finished
	queue_free()

func _on_area_entered(_area):
	Signals.emit_signal("enemy_attack", damage)

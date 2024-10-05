extends Node

signal dis_call_destroy()
signal show_call_destroy()


func _on_player_check_area_entered(area: Area2D) -> void:
	emit_signal("show_call_destroy")

func _on_player_check_area_exited(area: Area2D) -> void:
	emit_signal("dis_call_destroy")

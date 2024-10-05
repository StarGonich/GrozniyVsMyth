extends Node

signal dis_call()
signal show_call()


func _on_area_2d_area_entered(area: Area2D) -> void:
	emit_signal("show_call") 


func _on_area_2d_area_exited(area: Area2D) -> void:
	emit_signal("dis_call")

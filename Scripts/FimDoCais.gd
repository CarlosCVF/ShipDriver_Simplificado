extends Area2D

signal leaving_the_pier

func _on_body_entered(_body):
	emit_signal("leaving_the_pier")

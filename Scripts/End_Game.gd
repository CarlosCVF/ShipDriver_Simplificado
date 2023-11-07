extends Area2D

signal Player_has_won()

func _on_body_entered(_body):
	emit_signal("Player_has_won")

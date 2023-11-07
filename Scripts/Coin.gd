extends Area2D

func _on_body_entered(_body):
	Globals.coins += 1
	Globals.score += 150
	queue_free()

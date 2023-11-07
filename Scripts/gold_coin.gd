extends Area2D

func _on_body_entered(_body):
	Globals.gold_coins += 1
	Globals.score += 1000
	queue_free()

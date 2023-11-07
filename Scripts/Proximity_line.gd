extends Area2D

@onready var exit_pier = $"../Exit_Pier"
var can_go = false

func _ready():
	exit_pier.leaving_the_pier.connect(Off_pier)

func Off_pier():
	can_go = true

func _on_body_exited(body):
	if body.name == "Player" and body.has_method("Overspeed") and !can_go:
		body.lost_points()
		Globals.Perto = true
	if body.name == "Player" and body.has_method("Overspeed") and can_go:
		Globals.Perto = false

func _on_body_entered(body):
	if body.name == "Player" and body.has_method("Overspeed"):
		Globals.Perto = false

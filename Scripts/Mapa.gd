extends Node2D

@onready var player = $Player
@onready var control = $HUD/Control

func _ready():
	Globals.score = 0
	Globals.coins = 0
	Globals.gold_coins = 0
	Globals.speed = 0

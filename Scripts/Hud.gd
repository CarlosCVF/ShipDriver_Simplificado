extends Control

@onready var score_number = $MarginContainer/Score_Container/Score_number as Label
@onready var timer = $MarginContainer/Timer_Container/Timer as Label
@onready var coins_counter = $MarginContainer/Coin_container/Coins_counter as Label
@onready var gold_coin_counter = $MarginContainer/Gold_coin_container/Gold_coin_counter as Label
@onready var speed_counter = $MarginContainer/HBoxContainer/Speed_counter as Label
@onready var clock_timer = $Clock_Timer as Timer
@onready var player = $"../../Player"

var minutes = 0
var seconds = 0
@export_range(0,5) var default_minutes := 2
@export_range(0,59) var default_seconds := 0

signal time_is_up()

func _ready():
	coins_counter.text = str("%02d" % Globals.coins)
	speed_counter.text = str("%02d" % Globals.speed)
	gold_coin_counter.text = str("%02d" % Globals.gold_coins)
	score_number.text = str("%04d" % Globals.score)
	timer.text = str("%02d" % default_minutes) + ":" + str("%02d" % default_seconds)
	reset_clock_timer()

func _process(_delta):
	Globals.speed = player.nos
	score_number.text = str("%04d" % Globals.score)
	speed_counter.text = str("%02d" % Globals.speed)
	gold_coin_counter.text = str("%02d" % Globals.gold_coins)
	coins_counter.text = str("%02d" % Globals.coins)
	
	if minutes == 0 and seconds == 0:
		emit_signal("time_is_up")

func reset_clock_timer():
	minutes = default_minutes
	seconds = default_seconds

func _on_clock_timer_timeout():
	if seconds != 0 or minutes != 0:
		if seconds == 0:
			if minutes > 0:
				minutes -= 1
				seconds = 60
		seconds -= 1
	
	timer.text = str("%02d" % minutes) + ":" + str("%02d" % seconds)

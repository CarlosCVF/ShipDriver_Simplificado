extends CharacterBody2D

@export var speed: float = 1
@export var deceleration: float = -1
@export var max_speed: float = 200
@export var min_speed: float = -200
@export var acceleration: float = 0.005
@warning_ignore("unused_private_class_variable")
@export var _friction: float = 0.0015
@export var stop: bool = false
@export var forward: bool = true
@export var rotation_speed = 0.4
var nos
var can_move: bool = true
var cont : int = 0

signal player_has_died()
signal player_overspeed()
var rotation_dir = 0

func get_input():
	rotation_dir = 0
	velocity = Vector2()
	if Input.is_action_pressed("move_right"):
		rotation_dir += 1
	if Input.is_action_pressed("move_left"):
		rotation_dir -= 1
	
	if Input.is_action_pressed("move_down"):
		if stop:
			if deceleration >= min_speed:
				deceleration += deceleration * acceleration
			velocity = Vector2(deceleration, 0).rotated(rotation)
		else:
			speed -= speed * acceleration
			velocity = Vector2(speed, 0).rotated(rotation)
			if speed <= 1:
				stop = true
				forward = false

	if Input.is_action_pressed("move_up"):
		if forward:
			if speed <= max_speed:
				speed += (speed * acceleration) + 0.1
			velocity = Vector2(speed, 0).rotated(rotation)
		else:
			deceleration -= deceleration * acceleration
			velocity = Vector2(deceleration, 0). rotated(rotation)
			if deceleration >= -1:
				forward = true
				stop = false
	
	if !Input.is_action_pressed("move_up") and !Input.is_action_pressed("move_down") and !stop:
		if speed >= 2:
			speed -= speed * _friction
			velocity = Vector2(speed, 0).rotated(rotation)
			if speed <= 1:
				stop = true
				forward = false
				
	if !Input.is_action_pressed("move_down") and !Input.is_action_pressed("move_up") and !forward:
		if deceleration <= -2:
			deceleration -= deceleration * _friction
			velocity = Vector2(deceleration, 0). rotated(rotation)
			if deceleration >= -1:
				forward = true


func _physics_process(delta):
	if can_move:
		Globals.speed = speed
		nos = speed * 0.07
		if nos >= 10:
			Overspeed(nos)
			pass
		if speed == 200:
			rotation_speed = 0.4 #+ 0.6
		if speed < 200 && speed >= 150:
			rotation_speed = 0.35 #+ 0.45
		if speed < 150 && speed >= 100:
			rotation_speed = 0.25 #+ 0.25
		if speed < 100 && speed >= 50:
			rotation_speed = 0.15 #+ 0.15
		if speed >= 0 and speed < 50 and speed > -50:
			rotation_speed = 0.05 #+ 0.05
		if speed == -200:
			rotation_speed = 0.4
		if speed > -200 && speed <= -150:
			rotation_speed = 0.35
		if speed > -150 && speed <= -100:
			rotation_speed = 0.25
		if speed > -100 && speed <= -50:
			rotation_speed = 0.15
		get_input()
		rotation += rotation_dir * rotation_speed * delta
		move_and_slide()
	else:
		velocity = Vector2(0,0).rotated(rotation)


func take_damage():
	if Globals.gold_coins == 1:
		Globals.gold_coins -= 1
		Globals.score -= 1000
	emit_signal("player_has_died")

func Overspeed(nos):
	cont += 1
	if nos >= 12:
		if cont == 150:
			Globals.score -= 150
	if cont == 150:
		Globals.score -= 100
		cont = 0
	
func lost_points():
	Globals.score -= 100

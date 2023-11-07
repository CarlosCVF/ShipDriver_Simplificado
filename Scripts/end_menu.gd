extends CanvasLayer

@onready var lose_win = $MarginContainer/VBoxContainer/Lose_Win
@onready var score_number = $MarginContainer/VBoxContainer/Score_container/Score_number
@onready var coins_number = $MarginContainer/VBoxContainer/Coins_taken_container/Coins_number
@onready var control = $"../HUD/Control"
@onready var player = $"../Player"
@onready var end_game = $"../End_Game"

var opcao = 0

func _ready():
	visible = false
	score_number.text = str("%04d" % Globals.score)
	coins_number.text = str("%02d" % Globals.coins)
	player.player_has_died.connect(reload_Game)
	control.time_is_up.connect(reload_Game2)
	end_game.Player_has_won.connect(reload_Game3)

func _process(_delta):
	if Input.is_action_pressed("reset") and visible:
		get_tree().reload_current_scene()
		get_tree().paused = false
	score_number.text = str("%04d" % Globals.score)
	coins_number.text = str("%02d" % Globals.coins)
	if Input.is_action_just_pressed("Menu_right") and visible:
		opcao += 1
	if Input.is_action_just_pressed("Menu_left") and visible:
		opcao -= 1
	if opcao < 0:
		opcao = $MarginContainer/VBoxContainer/Buttons_container.get_child_count() - 1
	if opcao > $MarginContainer/VBoxContainer/Buttons_container.get_child_count() - 1:
		opcao = 0
	if Input.is_action_just_pressed("Confirm") and visible:
		match opcao:
			0:
				get_tree().reload_current_scene()
				get_tree().paused = false
			1:
				get_tree().change_scene_to_file("res://Scenes/menu_screen.tscn")
				get_tree().paused = false
	$Setinha.global_position = $MarginContainer/VBoxContainer/Buttons_container.get_child(opcao).global_position + Vector2(-60, 25)

func reload_Game():
	visible = true
	get_tree().paused = true
	lose_win.text = "Voce encalhou!!"

func reload_Game2():
	visible = true
	get_tree().paused = true
	lose_win.text = "Acabou o tempo!!"

func reload_Game3():
	visible = true
	get_tree().paused = true
	lose_win.text = "Voce Ganhou!!"

func _on_restart_button_pressed():
	get_tree().reload_current_scene()
	get_tree().paused = false


func _on_menu_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/menu_screen.tscn")
	get_tree().paused = false

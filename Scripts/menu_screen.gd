extends Control

var opcao = 0

func _process(_delta):
	if Input.is_action_just_pressed("Menu_down"):
		opcao += 1
	if Input.is_action_just_pressed("Menu_up"):
		opcao -= 1
	if opcao < 0:
		opcao = $VBoxContainer/Menu_Buttons.get_child_count() -1
	if opcao > $VBoxContainer/Menu_Buttons.get_child_count() -1:
		opcao = 0
	if Input.is_action_just_pressed("Confirm") and visible:
		match opcao:
			0:
				get_tree().change_scene_to_file("res://Scenes/main.tscn")
			1:
				get_tree().change_scene_to_file("res://Scenes/controls.tscn")
		pass
	$Seta.global_position = $VBoxContainer/Menu_Buttons.get_child(opcao).global_position + Vector2(-75,45)


func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_controls_pressed():
	get_tree().change_scene_to_file("res://Scenes/controls.tscn")


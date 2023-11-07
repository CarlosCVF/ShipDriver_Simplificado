extends Control


func _ready():
	pass
	
func _process(_delta):
	if Input.is_action_just_pressed("Confirm") and visible:
		get_tree().change_scene_to_file("res://Scenes/menu_screen.tscn")


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/menu_screen.tscn")

extends CanvasLayer

@onready var proximity_line = $"../Proximity_line"
@onready var velocity_warning = $Warning_box/Pop_up/Warnings/Velocity_Warning
@onready var proximity_warning = $Warning_box/Pop_up/Warnings/Proximity_Warning
@onready var player = $"../Player"

func _ready():
	visible = false

func _process(_delta):
	if Globals.Perto and Globals.speed <= 10:
		visible = true
		Warning_distance()
		velocity_warning.visible = false
	
	if Globals.Perto and Globals.speed >= 11:
		visible = true
		Warning_distance()
		Warning_speed()
	
	if !Globals.Perto and Globals.speed >= 11:
		visible = true
		Warning_speed()
		proximity_warning.visible = false
	
	if !Globals.Perto and Globals.speed <= 10:
		visible = false

func Warning_distance():
	proximity_warning.visible = true
	proximity_warning.text = "Excesso de proximidade do cais"
	
func Warning_speed():
	velocity_warning.visible = true
	velocity_warning.text = "Velocidade excedida"

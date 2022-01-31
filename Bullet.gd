extends Area2D

var velocity
var pos
var rot

func _ready():
	pos = get_global_position() 
	rot = get_rotation()
	

func process(delta):
	position =+ Vector2(100,0)
	


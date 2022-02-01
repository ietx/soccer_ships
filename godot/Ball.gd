extends RigidBody2D

var reset = false
var inicial_position
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	
	inicial_position = get_global_transform().origin
	print (inicial_position)


func _on_Arena_reset():
	reset = true
#	sleeping = true
	
func _integrate_forces(state):
	if reset:
		state.transform = Transform2D (0, inicial_position)
		state.linear_velocity = Vector2()
		reset = false
#		sleeping = false
	

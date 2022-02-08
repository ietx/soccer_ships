extends ParallaxBackground

var SPEED = 4
# Declare member variables here. Examples:
# var a = 2s
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _process(delta):
	
	$Space.motion_offset.x += -0.8*SPEED * delta
	$Stars.motion_offset.x += 3*SPEED * delta
	$Space.motion_offset.y += -2.6*SPEED * delta
	$Stars.motion_offset.y += 0.9*SPEED * delta

extends ParallaxBackground

var SPEED = 5

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	$Stars.motion_offset.x += SPEED * delta
	$Nebulosa1.motion_offset.x += -3.8*SPEED * delta
	$Nebulosa2.motion_offset.x += 3*SPEED * delta
	$Nebulosa3.motion_offset.x += -2*SPEED * delta
	
#	$Stars.motion_offset.y += SPEED * delta
#	$Nebulosa1.motion_offset.y += -1.5*SPEED * delta
#	$Nebulosa2.motion_offset.y += 1.13*SPEED * delta
#	$Nebulosa3.motion_offset.y += -1.1*SPEED * delta
#	pass

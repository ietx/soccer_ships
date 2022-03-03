extends RigidBody2D

var reset = false
var inicial_position
var linear_vel
var max_speed = 500
var real_position

# Called when the node enters the scene tree for the first time.
func _ready():
	inicial_position = get_global_transform().origin
	print (inicial_position)

func reset():
	reset = true
	
func _on_Arena_reset():
	reset = true
#	sleeping = true
	
func _integrate_forces(state):
	if reset:
		state.transform = Transform2D (0, inicial_position)
		state.linear_velocity = Vector2()
		reset = false
#		sleeping = false
	
func _process(delta):
	real_position = get_global_position()
	print (real_position)
	linear_vel = get_linear_velocity()
	if abs (get_linear_velocity().x) > max_speed or abs (get_linear_velocity().y) > max_speed:
		var new_speed = get_linear_velocity().normalized()
		new_speed *= max_speed
		linear_velocity = new_speed
		
func _on_Golden_Gol_Golden_Gol():
	$Sprite.play("Gold")
	pass # Replace with function body.


func _on_Ball_body_entered(body):
	if Global.FX_off == false:
		if body.name == "Ship" or body.name == "Ship 2":
			$Ball_Ship.play()
		elif body.name == "Areana Limits":
			$Ball_Wall.play()
			$Electric.set_visible(true)
			if real_position.x > 455:
				$Electric.play("Red")
			else:
				$Electric.play("Blue")
		elif body.name == "Goal":
			$Ball_Post.play()


func _on_Electric_animation_finished():
	$Electric.stop()
	$Electric.set_visible(false)
	$Electric.set_frame(0)
	

extends RigidBody2D

var reset = false
var inicial_position
var linear_vel
var max_speed = 500
var real_position
var gg = false
var can_bounce = true

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
	
func _process(_delta):
	print($Timer.get_time_left())
	real_position = get_global_position()
	linear_vel = get_linear_velocity()
	if abs (get_linear_velocity().x) > max_speed or abs (get_linear_velocity().y) > max_speed:
		var new_speed = get_linear_velocity().normalized()
		new_speed *= max_speed
		linear_velocity = new_speed
		
func _on_Golden_Gol_Golden_Gol():
	gg = true
	$Sprite.play("Gold")
	pass # Replace with function body.


func _on_Ball_body_entered(body):
	if Global.FX_off == false:
		if body.name == "Ship" or body.name == "Ship 2":
			if can_bounce == true:
				$Timer.start()
				$Ball_Ship.play()
				can_bounce = false
		elif body.name == "Areana Limits":
			if can_bounce == true:
				$Timer.start()
				$Ball_Wall.play()
				$Electric.set_visible(true)
				can_bounce = false
			
			if real_position.x > 455 and gg == false:
				$Electric.play("Red")
			elif real_position.x < 455 and gg == false:
				$Electric.play("Blue")
			elif gg == true:
				$Electric.play("Golden")
		elif body.name == "Goal":
			$Ball_Post.play()


func _on_Electric_animation_finished():
	$Electric.stop()
	$Electric.set_visible(false)
	$Electric.set_frame(0)
	


func _on_Timer_timeout():
	can_bounce = true
	pass # Replace with function body.

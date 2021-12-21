extends RigidBody2D


export (int) var engine_thrust
export (int) var spin_thrust

var thrust = Vector2()
var rot = 0
var inicial_position 

func _ready():

	inicial_position = get_global_transform().origin
	print (inicial_position)

func _on_Arena_Blue_Goal():
	set_mode(RigidBody2D.MODE_KINEMATIC)
	sleeping = true
	print (String(get_mode()))
	call_deferred("change", "position" ,Vector2(inicial_position.x, inicial_position.y))
	position.x = inicial_position.x
	position.y = inicial_position.y
	#transform = Transform2D(0, Vector2(inicial_position))
	set_mode(RigidBody2D.MODE_RIGID)
	sleeping = false
	
func _physics_process(delta):
	if Input.is_action_pressed("Thrust"):
		thrust = Vector2(0, engine_thrust)
		$Sprite.play("Thrust")
	elif Input.is_action_pressed("Break"):
		thrust = Vector2(0, - 0.5 * engine_thrust)
		$Sprite.play("Break")
	elif Input.is_action_just_pressed("Dash"):
		thrust = Vector2(0, 300 * engine_thrust)
		$Sprite.play("Dash")
	else:
		thrust = Vector2()
		$Sprite.play("Still")
	rot = 0
	if Input.is_action_pressed("Rotate_Right"):
		rot += 1
	if Input.is_action_pressed("Rotate_Left"):
		rot -= 1
	else:
		rot - 0
		
	
	
	set_applied_force(thrust.rotated(rotation))
	set_applied_torque(rot * spin_thrust)



#func _on_Arena_Blue_Goal():
#	set_mode(RigidBody2D.MODE_KINEMATIC)
#	sleeping = true
#	print (String(get_mode()))
#	call_deferred("change", "position" ,Vector2(inicial_position.x, inicial_position.y))
#	#position.x = inicial_position.x
#	#position.y = inicial_position.y
#	#transform = Transform2D(0, Vector2(inicial_position))
#	set_mode(RigidBody2D.MODE_RIGID)
#	sleeping = false
	
	print (get_mode())

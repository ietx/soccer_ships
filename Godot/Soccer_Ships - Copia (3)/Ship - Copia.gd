extends RigidBody2D


export (int) var engine_thrust
export (int) var spin_thrust

var thrust = Vector2()
var rot = 0
var inicial_position
var reset = false

func _ready():

	inicial_position = get_global_transform().origin
	print(inicial_position)

func _on_Arena_reset():
	sleeping = true
	reset = true
#	print (String(get_mode()))
#	set_mode(RigidBody2D.MODE_STATIC)
#	position.x = inicial_position.x
#	position.y = inicial_position.y
#	print (get_mode())
	
		
func _physics_process(delta):
	if Input.is_action_pressed("Seta"):
		thrust = Vector2(0, - engine_thrust)
		$Sprite.play("Thrust")
	elif Input.is_action_pressed("Break_2"):
		thrust = Vector2(0, 0.5 * engine_thrust)
		$Sprite.play("Break")
	elif Input.is_action_just_pressed("Dash_2"):
		thrust = Vector2(0, - 300 * engine_thrust)
		$Sprite.play("Dash")
	else:
		thrust = Vector2()
		$Sprite.play("Still")
	rot = 0
	if Input.is_action_pressed("Rto_L_2"):
		rot -= 1
	if Input.is_action_pressed("Rot_R_2"):
		rot += 1
	else:
		rot - 0 

	
	set_applied_force(thrust.rotated(rotation))
	set_applied_torque(rot * spin_thrust)

func _integrate_forces(state):
	if reset:
		state.transform = Transform2D (PI, inicial_position)
		state.linear_velocity = Vector2()
		reset = false
		sleeping = false
		
	

extends RigidBody2D


export (int) var engine_thrust
export (int) var spin_thrust

var thrust = Vector2()
var rot = 0
var inicial_position
var inicial_rot
var reset = false
export var power_up = 0
var PU_Switch = false
signal PU_Used_Blue
var GG = false
var Freeze = true

func _ready():

	inicial_position = get_global_transform().origin
	inicial_rot = get_rotation()

func _on_Arena_reset():
	sleeping = true
	reset = true
	
func _physics_process(delta):
	
	if GG == true:
		PU_Switch == true
	
	if Freeze == false:
		if Input.is_action_pressed("Seta"):
			thrust = Vector2(0, - engine_thrust)
			$Sprite.play("Thrust")
		elif Input.is_action_pressed("Break_2"):
			thrust = Vector2(0,  engine_thrust)
			$Sprite.play("Break")
		elif Input.is_action_just_pressed("Dash_2"):
			if power_up == 0 and PU_Switch == true:
				thrust = Vector2(0, -300 * engine_thrust)
				$Sprite.play("Dash")
				if GG == false:
					PU_Switch = false
					emit_signal("PU_Used_Blue")
			elif power_up == 1 and PU_Switch == true:
				sleeping = true
				$Sprite.play("Stop")
				if GG == false:
					PU_Switch = false
					emit_signal("PU_Used_Blue")
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
		state.transform = Transform2D (inicial_rot, inicial_position)
		state.linear_velocity = Vector2()
		reset = false
		sleeping = false
		
	


func _on_Arena_Dash_PowUp2():
	power_up = 0
	PU_Switch = true


func _on_Arena_Still_PowUp2():
	power_up = 1
	PU_Switch = true


func _on_Golden_Gol_Golden_Gol():
	GG = true
	


func _on_Golden_Gol_Unfreeze_2():
	Freeze = false


func _on_Arena_Unfreeze_2():
	Freeze = false


func _on_Arena_Freeze_2():
	Freeze = true
	sleeping = true
	if Input.is_action_pressed("Seta"):
		thrust = Vector2(0, 0)
		$Sprite.play("Still")
	elif Input.is_action_pressed("Break_2"):
		thrust = Vector2(0,  0)
		$Sprite.play("Still")
	if Input.is_action_pressed("Rto_L_2"):
		rot = 0
	if Input.is_action_pressed("Rot_R_2"):
		rot = 0


func _on_Red_Wins_Unfreeze_2():
	Freeze = false
	#POSSIBILITAM DETECTAR COLISÕES
	set_max_contacts_reported(10)
	set_contact_monitor(true)
	

func _on_Ship_2_body_entered(body):
	var Body = str(body)
	print (Body)
	print("OPA")
	if Body == "Ship:[RigidBody2D:1390]":
		$Sprite.set_visible(false)
		$Explode.set_visible(true)
		$Explode.play("Explode")



func _on_Explode_animation_finished():
	queue_free()
	pass # Replace with function body.


func _on_Blue_Wins_Unfreeze_2():
	Freeze = false
	pass # Replace with function body.

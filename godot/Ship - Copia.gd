extends RigidBody2D


export (int) var engine_thrust
export (int) var spin_thrust

var thrust = Vector2()
var rot = 0
var inicial_position
var inicial_rot
var current_position
var current_rot
var reset = false
export var power_up = 0
var PU_Switch = false
signal PU_Used_Blue
var GG = false
var Freeze = true
signal Shoot2
onready var bullet = preload("res://Bullet.tscn")
var angel = false
var reborn = false
signal Explode2


func _ready():
	inicial_position = Vector2(135, 256)
	inicial_rot = get_rotation()

func reset_pos():
	sleeping = true
	reset = true
	angel = false
	
func _physics_process(delta):
	
	current_position = get_global_position()
	current_rot = get_rotation()
	
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
				emit_signal("PU_Used_Blue", power_up, current_position, current_rot)

			elif power_up == 1 and PU_Switch == true:
				sleeping = true
				emit_signal("PU_Used_Blue", power_up, current_position, current_rot)
				
			elif power_up == 2 and PU_Switch == true:
				shoot()
				emit_signal("PU_Used_Blue", power_up, current_position, current_rot)
				
			if GG == false:
					PU_Switch = false
					
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
	if (reset or reborn) == true:
		state.transform = Transform2D(inicial_rot, inicial_position)
		state.linear_velocity = Vector2()
		reset = false
		sleeping = false
		reborn = false
		$Angel_Timer.stop()
		
	if angel == true:
		state.transform = Transform2D(0, Vector2(-1000, -1000))
		state.linear_velocity = Vector2()
		
func shoot():
	var rot = get_rotation()
	var ship = "Blue"
	var muz_pos = $Muzzle.get_global_position()
	var dir = Vector2(0, -1).rotated(rot) 
	emit_signal("Shoot2", bullet, muz_pos, rot, dir, ship)

func get_shoot():
	angel = true
	$Angel_Timer.start()
	var pos = get_global_position()
	var rot = get_rotation()
	emit_signal("Explode2", pos, rot)


###################

func power_up(type):
	PU_Switch = true
	power_up = type

####################

func golden_gol():
	GG = true
	
func freeze():
	Freeze = true
	if Freeze == true:
		sleeping = true
		if Input.is_action_pressed("Seta"):
				thrust = Vector2(0, 0)
				$Sprite.play("Still")
		elif Input.is_action_pressed("Break_2"):
				thrust = Vector2(0,  0)
				$Sprite.play("Still")
		if Input.is_action_pressed("Rot_R_2"):
			rot = 0
		if Input.is_action_pressed("Rto_L_2"):
			rot = 0
	
func unfreeze():
	Freeze = false
#
func _on_Golden_Gol_Unfreeze_2():
	Freeze = false
#
#
func red_wins_unfreeze():
	Freeze = false
	#POSSIBILITAM DETECTAR COLISÕES
	set_max_contacts_reported(10)
	set_contact_monitor(true)

func _on_Ship_2_body_entered(body):

	if body is RigidBody2D:
		$Sprite.set_visible(false)
		$Explode.set_visible(true)
		$Explode.play("Explode")

func _on_Explode_animation_finished():
	queue_free()

func blue_wins_unfreeze():
	Freeze = false
	
func _on_Angel_Timer_timeout():
	angel = false
	reborn = true


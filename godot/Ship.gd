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
signal PU_Used_Red
var GG = false



onready var bullet = preload("res://Bullet.tscn")
var bullet_speed = 300

func _ready():

	inicial_position = get_global_transform().origin
	inicial_rot = get_rotation()
	print (inicial_position)

func _on_Arena_reset():
	sleeping = true
	reset = true
	

	
func _physics_process(delta):
	
	if GG == true:
		PU_Switch == true
		
	if Input.is_action_pressed("Thrust"):
		thrust = Vector2(0, engine_thrust)
		$Sprite.play("Thrust")
	elif Input.is_action_pressed("Break"):
		thrust = Vector2(0, - engine_thrust)
		$Sprite.play("Break")
	
	elif Input.is_action_just_pressed("Dash"):
		if power_up == 0 and PU_Switch == true:
			thrust = Vector2(0, 300 * engine_thrust)
			$Sprite.play("Dash")
			if GG == false:
				PU_Switch = false
				emit_signal("PU_Used_Red")
		elif power_up == 1 and PU_Switch == true:
			sleeping = true
			$Sprite.play("Stop")
			if GG == false:
				PU_Switch = false
				emit_signal("PU_Used_Red")
		else: 
			pass
#		power_up == 2 and PU_Switch == true:
#			var bullet_instance = bullet.instance()
#			bullet_instance.position = get_global_position() 
#			bullet_instance.rotation = get_rotation()
##			bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed,0).rotated(rotation))
#			get_tree().get_root().add_child(bullet_instance)
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

func _integrate_forces(state):
	if reset:
		state.transform = Transform2D(inicial_rot, inicial_position)
		state.linear_velocity = Vector2()
		reset = false
		sleeping = false
		

	
func _on_Arena_Dash_PowUp():
	power_up = 0
	PU_Switch = true


func _on_Arena_Still_PowUp():
	power_up = 1
	PU_Switch = true
	pass # Replace with function body.
	
#func shoot():
#	var b = bullet.instance()
#	bullet_container.add_child(b)
#	b.start_at(get_rotation(), get_global_transform().origin)


func _on_Golden_Gol_Golden_Gol():
	GG = true

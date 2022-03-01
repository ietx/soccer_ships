extends Control

# RED
var List_ID = 0
var Last_ID = 8
var First_ID = 0

# BLUE
var List2_ID = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.music_off == false:
		$Blind.play()
	pass
	# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Rotate_Right"):
		if List_ID < Last_ID:
			List_ID += 1 
		else:
			List_ID = First_ID
	if Input.is_action_just_pressed("Rotate_Left"):
		if List_ID > First_ID:
			List_ID -= 1
		else: 
			List_ID = Last_ID
	
	
	if List_ID == 0:
		$Red_Sellect.play("Ship")
	elif List_ID == 1:
		$Red_Sellect.play("Annie")
	elif List_ID == 2:
		$Red_Sellect.play("Bella")
	elif List_ID == 3:
		$Red_Sellect.play("Vi")
	elif List_ID == 4:
		$Red_Sellect.play("Mey")
	elif List_ID == 5:
		$Red_Sellect.play("Betty")
	elif List_ID == 6:
		$Red_Sellect.play("Jinx")
	elif List_ID == 7:
		$Red_Sellect.play("Bayron")
	elif List_ID == 8:
		$Red_Sellect.play("Santi")
	
	## BLUE ##
	
	if Input.is_action_just_pressed("Rot_R_2"):
		if List2_ID < Last_ID:
			List2_ID += 1 
		else:
			List2_ID = First_ID
	if Input.is_action_just_pressed("Rto_L_2"):
		if List2_ID > First_ID:
			List2_ID -= 1
		else: 
			List2_ID = Last_ID
	
	
	if List2_ID == 0:
		$Blue_Sellect.play("Ship2")
	elif List2_ID == 1:
		$Blue_Sellect.play("Tamir")
	elif List2_ID == 2:
		$Blue_Sellect.play("Pearl")
	elif List2_ID == 3:
		$Blue_Sellect.play("Hope")
	elif List2_ID == 4:
		$Blue_Sellect.play("Wey")
	elif List2_ID == 5:
		$Blue_Sellect.play("Sting")
	elif List2_ID == 6:
		$Blue_Sellect.play("Bobby")
	elif List2_ID == 7:
		$Blue_Sellect.play("Telly")
	elif List2_ID == 8:
		$Blue_Sellect.play("Ky")


func _on_TextureButton_pressed():
	Global.Red_ID = List_ID
	Global.Blue_ID = List2_ID
	if Global.GG_Menu == true:
		get_tree().change_scene("res://Golden Gol.tscn")
	else:
		get_tree().change_scene("res://Arena.tscn")
	pass # Replace with function body.

func _on_Back_pressed():
	get_tree().change_scene("res://Menu.tscn")

func _on_GoldenBack_button_down():
	Global.GG_Menu = false
	get_tree().change_scene("res://Menu.tscn")

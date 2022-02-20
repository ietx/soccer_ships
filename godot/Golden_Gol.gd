extends Node2D

signal Dash_PowUp
signal Still_PowUp
signal Shoot_PowUp
signal Dash_PowUp2
signal Still_PowUp2
signal Shoot_PowUp2

signal Unfreeze_1
signal Unfreeze_2

signal Golden_Gol

var start = false
var time = -11 #Cronometro do jogo.- 11 é o tempo que demora a animacao do Start e Roleta
var minu
var sec
var gol_frame
var Tree_Two_One_GO




var PU_RandomNum123 = RandomNumberGenerator.new()
var PU_RandomType
var Winner 

#onready var hud = get_node("HUD")
func _ready():
	$Start_Animation.set_visible(true)
	$Sound.play()
	$Goals.play("Gold_Shine")
	$Start_Animation.play("Golden_Gol")

	
	PU_RandomNum123.randomize()
	PU_RandomType = PU_RandomNum123.randi_range(0,2)
	
	emit_signal("Golden_Gol")
	if PU_RandomType == 0:
		emit_signal("Dash_PowUp")
		emit_signal("Dash_PowUp2")
	elif PU_RandomType == 1:
		emit_signal("Still_PowUp")
		emit_signal("Still_PowUp2")
	elif PU_RandomType == 2:
		emit_signal("Shoot_PowUp")
		emit_signal("Shoot_PowUp2")
func _process(delta):
	
	
	#GOL ANIMATION
	gol_frame = $Gol_Animation.get_frame()
	if gol_frame == 23:
		if Winner == "Red":
			get_tree().change_scene("res://Red_Wins.tscn")
		else:
			get_tree().change_scene("res://Blue_Wins.tscn")

	
	#START ANIMATION
	var Roleta_Frame = $Roleta.get_frame()
	var Roleta_Animation = String($Roleta.get_animation())
	var Start_Frame = $Start_Animation.get_frame()
	if Start_Frame == 14:
		$Start_Animation.set_visible(false)
		$Start_Animation.stop()
		$Start_Animation.set_frame(0)
		$Roleta.set_visible(true)
		$Roleta.play("Rolling")
	
	#ROLETA ANIMATION
	if Roleta_Frame == 10 and Roleta_Animation == "Rolling":
		$Roleta_Timer.start()
		if PU_RandomType == 0:
			$Roleta.play("Green")
			$HUD/PU_Light_Blue.play("Green")
			$HUD/PU_Light_Red.play("Green")
		if PU_RandomType == 1:
			$Roleta.play("Red")
			$HUD/PU_Light_Red.play("Red")
			$HUD/PU_Light_Blue.play("Red")
		if PU_RandomType == 2:
			$Roleta.play("Blue")
			$HUD/PU_Light_Red.play("Blue")
			$HUD/PU_Light_Blue.play("Blue")
	
	var Roleta_Timer = $Roleta_Timer.get_time_left()
#	
	#3 2 1 GO! START TIMER
	

	Tree_Two_One_GO = stepify($Start_Timer.get_time_left(), 0.1)
	
	print(Tree_Two_One_GO )
	
	if Tree_Two_One_GO == 4.5:
		$Start_Timer_Animation.play("3")
	elif Tree_Two_One_GO == 3.2:
		$Start_Timer_Animation.play("2")
	elif Tree_Two_One_GO == 2.2:
		$Start_Timer_Animation.play("1")
	elif Tree_Two_One_GO == 1.1:
		$Start_Timer_Animation.play("Go")
		emit_signal("Unfreeze_1")
		emit_signal("Unfreeze_2")
	
	
		
	#CRONOMETRO 
	time += delta 

	if start == true:
		minu = int(int(time)/60)
		sec = int(time)- minu * 60
		if sec > 9:
			$HUD/Time.text = String(minu) + ":" + String(sec)
		else:
			$HUD/Time.text = String(minu) + ":0" + String(sec)
	
	
	
		
func _on_Blue_Goal_body_entered(body):
	$Gol_Animation.set_visible(true)
	$Gol_Animation.play("Gol_R")
	$Ball.queue_free()
	Winner = "Red"
	pass
	
func _on_Red_Goal_body_entered(body):
	$Gol_Animation.set_visible(true)
	$Gol_Animation.play("Gol_B")
	$Ball.queue_free()
	Winner = "Blue"
	pass
	



	


func _on_Roleta_Timer_timeout():
	$Roleta.set_visible(false)
	$Start_Timer_Animation.set_visible(true)
	$Start_Timer.start()
	

func _on_Start_Timer_timeout():
	$Start_Timer_Animation.set_visible(false)
	start = true
	pass # Replace with function body.

func _on_Ship_Shoot(bullet, muz_pos, rot, dir, ship):
	var b = bullet.instance()
	add_child(b)
	b.start(muz_pos, rot, dir, ship)

func _on_Ship2_Shoot2(bullet, muz_pos, rot, dir, ship):
	var b = bullet.instance()
	add_child(b)
	b.start(muz_pos, rot, dir, ship)
	


func _on_Ship_Explode(pos, rot):
	$Explode.set_visible(true)
	$Explode.position = pos
	$Explode.rotation = rot
	$Explode.play("Explode")
func _on_Explode_animation_finished():
	$Explode.set_visible(false)
	$Explode.stop()
	$Explode.set_frame(0)

func _on_Ship2_Explode2(pos, rot):
	$Explode2.set_visible(true)
	$Explode2.position = pos
	$Explode2.rotation = rot
	$Explode2.play("Explode2")
func _on_Explode2_animation_finished():
	$Explode2.set_visible(false)
	$Explode2.stop()
	$Explode2.set_frame(0)

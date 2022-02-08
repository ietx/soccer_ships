extends Node2D

signal Dash_PowUp
signal Still_PowUp
signal Dash_PowUp2
signal Still_PowUp2
signal Unfreeze_1
signal Unfreeze_2

signal Golden_Gol

var start = false
var time = -6 #Cronometro do jogo.- 6 é o tempo que demora a animacao do Start e Roleta
var minu
var sec
var gol_frame





var PU_RandomNum123 = RandomNumberGenerator.new()
var PU_RandomType

#onready var hud = get_node("HUD")
func _ready():
	$Start_Animation.set_visible(true)
	$Sound.play()
	$Goals.play("Gold_Shine")
	$Start_Animation.play("Golden_Gol")
		
	
	PU_RandomNum123.randomize()
	PU_RandomType = PU_RandomNum123.randi_range(0,1)
	
	emit_signal("Golden_Gol")
	if PU_RandomType == 0:
		emit_signal("Dash_PowUp")
		emit_signal("Dash_PowUp2")
#		$HUD/PU_Light_Blue.play("Green")
#		$HUD/PU_Light_Red.play("Green")
	elif PU_RandomType == 1:
		emit_signal("Still_PowUp")
		emit_signal("Still_PowUp2")
#		$HUD/PU_Light_Red.play("Red")
#		$HUD/PU_Light_Blue.play("Red")

	
func _process(delta):
	
	
	#GOL ANIMATION
	gol_frame = $Gol_Animation.get_frame()
	if gol_frame == 23:
		get_tree().change_scene("res://Menu.tscn")
	
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
	
	var Roleta_Timer = $Roleta_Timer.get_time_left()
	print (Roleta_Animation)
	print (Roleta_Timer)
#		$Roleta.set_visible(false)
		
#		if PU_RandomType == 0:
#			$Roleta.set_visible(false)
#			$Roleta.play("Green")
#			$Roleta.stop()
#			$Roleta.set_visible(false)
#		elif PU_RandoType == 1:
#			$Roleta.play("Red")
#			$Roleta.stop()
#			$Roleta.set_visible(false)
		
		
		
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
	pass
	
func _on_Red_Goal_body_entered(body):
	$Gol_Animation.set_visible(true)
	$Gol_Animation.play("Gol_B")
	$Ball.queue_free()
	pass
	



	


func _on_Roleta_Timer_timeout():
	start = true
	$Roleta.set_visible(false)
	emit_signal("Unfreeze_1")
	emit_signal("Unfreeze_2")
	
	pass # Replace with function body.

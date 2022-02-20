extends Node2D

signal reset
signal Dash_PowUp
signal Still_PowUp
signal Shoot_PowUp
signal Dash_PowUp2
signal Still_PowUp2
signal Shoot_PowUp2
signal Unfreeze_1
signal Unfreeze_2
signal Freeze_1
signal Freeze_2
var Blue_Goal = 0
var Red_Goal = 0
var start = false
var Tree_Two_One_GO 
var match_time
var minu
var sec
var gol_frame
const PU_Xmax = 750
const PU_Ymax = 100
const PU_Xmin = 170
const PU_Ymin = 400


var PU_X = RandomNumberGenerator.new()
var PU_Y = RandomNumberGenerator.new()
var PU_RandomNum123 = RandomNumberGenerator.new()
var PU_RandomType
var PU_out = Vector2(-100,-100)

#onready var hud = get_node("HUD")
func _ready():
	$John.play()
	$StartTimer.start()
	$Gol_Animation.playing = false
	$Lightning_Animation.play("Thunder")
#	$Shine_Star/Blue_Shine.set_visible(false)
#	$Shine_Star/Red_Shine.set_visible(false)
	#$Gol_Animation.set_visible(false)
	 #continua



#	hud.get_node("HUD/CenterContainer/CountDown").set_text((round($StartTimer.time_left)))
	
func _process(delta):
	
	gol_frame = $Gol_Animation.get_frame()
	Tree_Two_One_GO = stepify($StartTimer.get_time_left(), 0.1)
	

	
		
	#Para o cronômetro durante o gol
	if start == false: #Se for o comeco da partida PRIMEIRO 3 2 1 GO
		if Tree_Two_One_GO == 0: 
			$TimeNormal.start() 
			start = true
			$StartTimerAnimation.set_visible(false)
	else: #Se for durante a partida qualquer 321 GO
		if Tree_Two_One_GO == 0: 
			$StartTimerAnimation.set_visible(false)
	
	#CountDown
	if Tree_Two_One_GO == 4.5:
		$StartTimerAnimation.play("3")
	elif Tree_Two_One_GO == 3.2:
		$StartTimerAnimation.play("2")
	elif Tree_Two_One_GO == 2.2:
		$StartTimerAnimation.play("1")
	elif Tree_Two_One_GO == 1.1:
		$StartTimerAnimation.play("Go")
		$TimeNormal.set_paused(false)
		emit_signal("Unfreeze_1")
		emit_signal("Unfreeze_2")
	
#	if $StartTimer.time_left > 1:
#		$HUD/PanelContainer/CenterContainer/CountDown.text = String(int($StartTimer.time_left))
#		emit_signal("Freeze_1")
#		emit_signal("Freeze_2")
#	else:
#		$HUD/PanelContainer/CenterContainer/CountDown.text = ("Go!")
	
	#Cronômetro do tempo da partida
	
	if start == false:
		$HUD/Time.text = "4:20"
		$HUD/Time.modulate = (Color(1,1,1,1))
	else:
		match_time = int($TimeNormal.time_left)
	
	if start == true:
		minu = match_time/60
		sec = match_time - minu * 60
		if sec > 9 :
			$HUD/Time.text = (String(minu) + ":" + String(sec))
		else:
			$HUD/Time.text = (String(minu) + ":0" + String(sec))
		# Vermelho piscante
		if match_time < 30:
			$HUD/Time/AnimationPlayer.play("Blink_Red")
		else:
			$HUD/Time.modulate = (Color(1,1,1,1))
	
	#Anmiação do gol
	if gol_frame == 23:
		$Gol_Animation.stop()
		$Gol_Animation.set_frame(0)
		$Gol_Animation.set_visible(false)
		$StartTimerAnimation.set_visible(true)
		$StartTimer.start()
	

		
func _on_Blue_Goal_body_entered(body):
	Blue_Goal += 1
	$HUD/Red.text = String(Blue_Goal)
	emit_signal("reset") #Emite sinal pras naves e bola reseteram a posição
#	$StartTimerAnimation.set_visible(true)
#	$StartTimer.start()
	$TimeNormal.set_paused(true)
	$Gol_Animation.set_visible(true)
	$Gol_Animation.play("Gol_R")
	emit_signal("Freeze_1")
	emit_signal("Freeze_2")


func _on_Red_Goal_body_entered(body):
	Red_Goal += 1
	$HUD/Blue.text = String(Red_Goal)
	emit_signal("reset")
#	$StartTimerAnimation.set_visible(true)
#	$StartTimer.start()
	$TimeNormal.set_paused(true)
	$Gol_Animation.set_visible(true)
	$Gol_Animation.play("Gol_B")
	emit_signal("Freeze_1")
	emit_signal("Freeze_2")



func _on_StartTimer_timeout():
	$HUD/PanelContainer.set_visible(false)



func _on_TimeNormal_timeout():
	if Blue_Goal == Red_Goal:
		get_tree().change_scene("res://Golden Gol.tscn")
	elif Blue_Goal > Red_Goal:
		get_tree().change_scene("res://Red_Wins.tscn")
	elif Blue_Goal < Red_Goal:
		get_tree().change_scene("res://Blue_Wins.tscn")
	
		



func _on_Green_Shine_body_entered(body):
	if body == $Ship:
		emit_signal("Dash_PowUp")
		$HUD/PU_Light_Red.play("Green")
	elif body == $Ship2:
		emit_signal("Dash_PowUp2")
		$HUD/PU_Light_Blue.play("Green")
	$Shine_Star/Green_Shine.position = PU_out
	$Shine_Star/Timer_PU.start()
	$Shine_Star/Green_Shine/AnimatedSprite.stop()
	$Shine_Star/Green_Shine/AnimatedSprite.set_frame(0)
	print (body)
	pass # Replace with function body.


func _on_Red_Shine_body_entered(body):
	if body == $Ship:
		emit_signal("Still_PowUp")
		$HUD/PU_Light_Red.play("Red")
	elif body == $Ship2:
		emit_signal("Still_PowUp2")
		$HUD/PU_Light_Blue.play("Red")
	$Shine_Star/Red_Shine.position = PU_out
	$Shine_Star/Timer_PU.start()
	$Shine_Star/Red_Shine/AnimatedSprite.stop()
	$Shine_Star/Red_Shine/AnimatedSprite.set_frame(0)
	print (body)
	pass # Replace with function body.

func _on_Blue_Shine_body_entered(body):
	if body == $Ship:
		emit_signal("Shoot_PowUp")
		$HUD/PU_Light_Red.play("Blue")
	elif body == $Ship2:
		emit_signal("Shoot_PowUp2")
		$HUD/PU_Light_Blue.play("Blue")
	$Shine_Star/Blue_Shine.position = PU_out
	$Shine_Star/Timer_PU.start()
	$Shine_Star/Blue_Shine/AnimatedSprite.stop()
	$Shine_Star/Blue_Shine/AnimatedSprite.set_frame(0)
	print (body) 
	
func _on_Timer_PU_timeout():
	PU_RandomNum123.randomize()
	PU_RandomType = PU_RandomNum123.randi_range(0,2)
	PU_X.randomize()
	PU_Y.randomize()
	if PU_RandomType == 0:
		$Shine_Star/Green_Shine.position = Vector2(PU_X.randi_range(PU_Xmin , PU_Xmax),PU_Y.randi_range(PU_Ymin , PU_Ymax))
		$Shine_Star/Green_Shine/AnimatedSprite.play("Green")
	elif PU_RandomType == 1:
		$Shine_Star/Red_Shine.position = Vector2(PU_X.randi_range(PU_Xmin , PU_Xmax),PU_Y.randi_range(PU_Ymin , PU_Ymax))
		$Shine_Star/Red_Shine/AnimatedSprite.play("Red")
	elif PU_RandomType == 2:
		$Shine_Star/Blue_Shine.position = Vector2(PU_X.randi_range(PU_Xmin , PU_Xmax),PU_Y.randi_range(PU_Ymin , PU_Ymax))
		$Shine_Star/Blue_Shine/AnimatedSprite.play("Blue")
	
	print ($Shine_Star/Green_Shine.position)
	print ($Shine_Star/Red_Shine.position)
	print ($Shine_Star/Blue_Shine.position)
	print (PU_RandomType)


#Desliga a luz do HUB do PU

func _on_Ship_PU_Used_Red():
	$HUD/PU_Light_Red.play("Off")

func _on_Ship2_PU_Used_Blue():
	$HUD/PU_Light_Blue.play("Off")


########## SHOOTING ###########

func _on_Ship_Shoot(bullet, muz_pos, rot, dir, ship):
	var b = bullet.instance()
	add_child(b)
	b.start(muz_pos, rot, dir, ship)
	

func _on_Ship2_Shoot2(bullet, muz_pos, rot, dir, ship):
	var b = bullet.instance()
	add_child(b)
	b.start(muz_pos, rot, dir, ship)
	pass # Replace with function body.


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
	
#######################################################



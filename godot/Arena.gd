extends Node2D

signal reset #Só ta aplicado na bola
#signal Dash_PowUp
#signal Still_PowUp
#signal Shoot_PowUp
#signal Dash_PowUp2
#signal Still_PowUp2
#signal Shoot_PowUp2
#signal Unfreeze_1
#signal Unfreeze_2
#signal Freeze_1
#signal Freeze_2
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
var Red_ID = Global.Red_ID
var Blue_ID = Global.Blue_ID
var Red_choices = [preload("res://Ship.tscn"), preload ("res://Annie.tscn"), preload ("res://Bella.tscn"), preload ("res://Vi.tscn"), preload ("res://Mey.tscn"), preload ("res://Betty.tscn"), preload ("res://Jinx.tscn"), preload ("res://Bayron.tscn"), preload ("res://Santi.tscn"), preload ("res://UFB.tscn")]
var Blue_choices = [preload("res://Ship - Copia.tscn"), preload("res://Tamir.tscn"), preload("res://Pearl.tscn"), preload("res://Hope.tscn"), preload ("res://Wey.tscn"), preload("res://Sting.tscn"), preload ("res://Bobby.tscn"), preload ("res://Telly.tscn"), preload ("res://Ky.tscn"), preload ("res://Rei.tscn")]
var Ship
var Ship2
var StartTimer_frame
func _ready():
	
		
		
	#### SHIP SPAWN ####
	
	Ship = Red_choices[Red_ID].instance()
	Ship.connect("PU_Used_Red", self, "_on_Ship_PU_Used_Red")
	Ship.connect("Explode", self, "_on_Ship_Explode")
	Ship.connect("Shoot", self, "_on_Ship_Shoot")
	$Ships_Node.add_child(Ship)
	Ship.position = Vector2(775, 256)
	
	
	Ship2 = Blue_choices[Blue_ID].instance()
	Ship2.connect("PU_Used_Blue", self, "_on_Ship2_PU_Used_Blue")
	Ship2.connect("Explode2", self, "_on_Ship2_Explode2")
	Ship2.connect("Shoot2", self, "_on_Ship2_Shoot2")
	$Ships_Node.add_child(Ship2)
	Ship2.position = Vector2(135, 256)
	
	#####################
	if Global.music_off == false:
		$John.play()
	else:
		pass
#
	$Gol_Animation.playing = false
	$Lightning_Animation.play("Thunder")
	$StartTimerAnimation.set_visible(true)
	$StartTimerAnimation.play("321GO")

	
func _process(delta):
	
	StartTimer_frame = $StartTimerAnimation.get_frame()
	gol_frame = $Gol_Animation.get_frame()
#	Tree_Two_One_GO = stepify($StartTimer.get_time_left(), 0.1)
	
	if StartTimer_frame == 4 or StartTimer_frame == 8 or StartTimer_frame == 12:
		if Global.FX_off == false:
			$FX/Honk_Low.play() 
	elif StartTimer_frame == 16:
		if Global.FX_off == false:
			$FX/Honk_High.play()

	
		
#	#Para o cronômetro durante o gol
#	if start == false: #Se for o comeco da partida PRIMEIRO 3 2 1 GO
#		if Tree_Two_One_GO == 0: 
#			$TimeNormal.start() 
#			start = true
#			$StartTimerAnimation.set_visible(false)
#	else: #Se for durante a partida qualquer 321 GO
#		if Tree_Two_One_GO == 0: 
#			$StartTimerAnimation.set_visible(false)
#
#	#CountDown
#	if Tree_Two_One_GO == 4.5:
#		$StartTimerAnimation.play("3")
#	elif Tree_Two_One_GO == 3.2:
#		$StartTimerAnimation.play("2")
#	elif Tree_Two_One_GO == 2.2:
#		$StartTimerAnimation.play("1")
#	elif Tree_Two_One_GO == 1.1:
#		$StartTimerAnimation.play("Go")
#		$TimeNormal.set_paused(false)
#		Ship.unfreeze()
#		Ship2.unfreeze()
#		emit_signal("Unfreeze_1")
#		emit_signal("Unfreeze_2")
	
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
	
	if gol_frame == 4:
		if Global.FX_off == false:
			$FX/Gol_FX.play()
			$FX/Gol_FX2.play()
		
	if gol_frame == 23:
		$Gol_Animation.stop()
		$Gol_Animation.set_frame(0)
		$Gol_Animation.set_visible(false)
		$StartTimerAnimation.set_visible(true)
		$StartTimerAnimation.play("321GO")
	

		
func _on_Blue_Goal_body_entered(body):
	Blue_Goal += 1
	$HUD/Red.text = String(Blue_Goal)
	Ship.reset_pos()
	Ship2.reset_pos()
	emit_signal("reset") #Emite sinal pras naves e bola reseteram a posição
	$TimeNormal.set_paused(true)
	$Gol_Animation.set_visible(true)
	$Gol_Animation.play("Gol_R")
	Ship.freeze()
	Ship2.freeze()
	



func _on_Red_Goal_body_entered(body):
	Red_Goal += 1
	$HUD/Blue.text = String(Red_Goal)
	Ship.reset_pos()
	Ship2.reset_pos()
	emit_signal("reset")
	$TimeNormal.set_paused(true)
	$Gol_Animation.set_visible(true)
	$Gol_Animation.play("Gol_B")
	Ship.freeze()
	Ship2.freeze()
	





func _on_TimeNormal_timeout():
	if Blue_Goal == Red_Goal:
		get_tree().change_scene("res://Golden Gol.tscn")
	elif Blue_Goal > Red_Goal:
		get_tree().change_scene("res://Red_Wins.tscn")
	elif Blue_Goal < Red_Goal:
		get_tree().change_scene("res://Blue_Wins.tscn")
	
		



func _on_Green_Shine_body_entered(body):
	if Global.FX_off == false:
		$FX/PU_0_IN.play()
	body.power_up(0)
	if body.name == "Ship 2":
		$HUD/PU_Light_Blue.play("Green")
	else:
		$HUD/PU_Light_Red.play("Green")
#	if body == $Ship:
#		emit_signal("Dash_PowUp")
#		$HUD/PU_Light_Red.play("Green")
#	elif body == $Ship2:
#		emit_signal("Dash_PowUp2")
#		$HUD/PU_Light_Blue.play("Green")
	$Shine_Star/Timer_PU.stop()
	$Shine_Star/Green_Shine.position = PU_out
	$Shine_Star/Timer_PU.start()
	$Shine_Star/Green_Shine/AnimatedSprite.stop()
	$Shine_Star/Green_Shine/AnimatedSprite.set_frame(0)
	print (body)
	pass # Replace with function body.


func _on_Red_Shine_body_entered(body):
	if Global.FX_off == false:
		$FX/PU_1_IN.play()
	body.power_up(1)
	if body.name == "Ship 2":
		$HUD/PU_Light_Blue.play("Red")
	else:
		$HUD/PU_Light_Red.play("Red")
#	if body == $Ship:
#		emit_signal("Still_PowUp")
#		$HUD/PU_Light_Red.play("Red")
#	elif body == $Ship2:
#		emit_signal("Still_PowUp2")
#		$HUD/PU_Light_Blue.play("Red")
	$Shine_Star/Timer_PU.stop()
	$Shine_Star/Red_Shine.position = PU_out
	$Shine_Star/Timer_PU.start()
	$Shine_Star/Red_Shine/AnimatedSprite.stop()
	$Shine_Star/Red_Shine/AnimatedSprite.set_frame(0)
	print (body)
	pass # Replace with function body.

func _on_Blue_Shine_body_entered(body):
	if Global.FX_off == false:
		$FX/PU_2_IN.play()
	print (body.name)
	body.power_up(2)
	if body.name == "Ship 2":
		$HUD/PU_Light_Blue.play("Blue")
	else:
		$HUD/PU_Light_Red.play("Blue")
#	if body == $Ship:
#		emit_signal("Shoot_PowUp")
#		$HUD/PU_Light_Red.play("Blue")
#	elif body == $Ship2:
#		emit_signal("Shoot_PowUp2")
#		$HUD/PU_Light_Blue.play("Blue")
	$Shine_Star/Timer_PU.stop()
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

func _on_Ship_PU_Used_Red(power_up, pos, rot):
	if power_up == 0:
		$PU_Animation/Dash1.set_visible(true)
		$PU_Animation/Dash1.position = pos
		$PU_Animation/Dash1.rotation = rot
		$PU_Animation/Dash1.play("Dash")
		$FX/PU_1_USED.play()
	elif power_up == 1:
		$PU_Animation/Stop1.set_visible(true)
		$PU_Animation/Stop1.position = pos
		$PU_Animation/Stop1.rotation = rot
		$PU_Animation/Stop1.play("Stop")
		$FX/PU_2_USED.play()
		
	$HUD/PU_Light_Red.play("Off")

func _on_Ship2_PU_Used_Blue(power_up, pos, rot):
	
	if power_up == 0:
		$PU_Animation/Dash2.set_visible(true)
		$PU_Animation/Dash2.position = pos
		$PU_Animation/Dash2.rotation = rot
		$PU_Animation/Dash2.play("Dash")
		$FX/PU_1_USED.play()
		 
	elif power_up == 1:
		$PU_Animation/Stop2.set_visible(true)
		$PU_Animation/Stop2.position = pos
		$PU_Animation/Stop2.rotation = rot
		$PU_Animation/Stop2.play("Stop")
		$FX/PU_2_USED.play()
		
		
	$HUD/PU_Light_Blue.play("Off")


########## SHOOTING ###########

func _on_Ship_Shoot(bullet, muz_pos, rot, dir, ship):
	$FX/PU_3_USED.play()
	var b = bullet.instance()
	add_child(b)
	b.start(muz_pos, rot, dir, ship)
	

func _on_Ship2_Shoot2(bullet, muz_pos, rot, dir, ship):
	$FX/PU_3_USED.play()
	var b = bullet.instance()
	add_child(b)
	b.start(muz_pos, rot, dir, ship)
	pass # Replace with function body.


func _on_Ship_Explode(pos, rot):
	$FX/Ship_Explode.play()
	$Explode.set_visible(true)
	$Explode.position = pos
	$Explode.rotation = rot
	$Explode.play("Explode")
func _on_Explode_animation_finished():
	$Explode.set_visible(false)
	$Explode.stop()
	$Explode.set_frame(0)

func _on_Ship2_Explode2(pos, rot):
	$FX/Ship_Explode.play()
	$Explode2.set_visible(true)
	$Explode2.position = pos
	$Explode2.rotation = rot
	$Explode2.play("Explode2")
func _on_Explode2_animation_finished():
	$Explode2.set_visible(false)
	$Explode2.stop()
	$Explode2.set_frame(0)
	
#######################################################


func _on_StartTimerAnimation_animation_finished():
	$StartTimerAnimation.set_visible(false)
	$StartTimerAnimation.stop()
	$StartTimerAnimation.set_frame(0)
	Ship.unfreeze()
	Ship2.unfreeze()
	if start == false: #Se for o comeco da partida PRIMEIRO 3 2 1 GO
		$TimeNormal.start() 
		start = true
	else: #Se for durante a partida qualquer 321 GO
		$TimeNormal.set_paused(false)
		



func _on_Ball_Zone_body_exited(body):
	body.reset()

####### POWER UP END ANIMATIONS #########

func _on_Dash1_animation_finished():
	$PU_Animation/Dash1.set_visible(false)
	$PU_Animation/Dash1.stop()
	$PU_Animation/Dash1.set_frame(0)
func _on_Dash2_animation_finished():
	$PU_Animation/Dash2.set_visible(false)
	$PU_Animation/Dash2.stop()
	$PU_Animation/Dash2.set_frame(0)
func _on_Stop1_animation_finished():
	$PU_Animation/Stop1.set_visible(false)
	$PU_Animation/Stop1.stop()
	$PU_Animation/Stop1.set_frame(0)
func _on_Stop2_animation_finished():
	$PU_Animation/Stop2.set_visible(false)
	$PU_Animation/Stop2.stop()
	$PU_Animation/Stop2.set_frame(0)
	
####################################

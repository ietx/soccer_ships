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
var Blue_Goal = "-"
var Red_Goal = "-"
var start = true
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
var Red_choices = preload("res://Ship.tscn")
var Blue_choices = preload("res://Ship - Copia.tscn")
var Ship 
var Ship2 
var StartTimer_frame

func _ready():


		
		
	#### SHIP SPAWN ####
	
	Ship = Red_choices.instance()
	Ship.connect("PU_Used_Red", self, "_on_Ship_PU_Used_Red")
	Ship.connect("Explode", self, "_on_Ship_Explode")
	Ship.connect("Shoot", self, "_on_Ship_Shoot")
	$Ships_Node.add_child(Ship)
	Ship.position = Vector2(775, 256)
	
	
	Ship2 = Blue_choices.instance()
	Ship2.connect("PU_Used_Blue", self, "_on_Ship2_PU_Used_Blue")
	Ship2.connect("Explode2", self, "_on_Ship2_Explode2")
	Ship2.connect("Shoot2", self, "_on_Ship2_Shoot2")
	$Ships_Node.add_child(Ship2)
	Ship2.position = Vector2(135, 256)
	
	Ship.unfreeze()
	Ship2.unfreeze()
	$HUD/Red.text = String(Blue_Goal)
	$HUD/Blue.text = String(Red_Goal)
	#####################
	if Global.music_off == false:
		$John.play()
	else:
		pass
#
	$Gol_Animation.playing = false
	$Lightning_Animation.play("Thunder")
	

	
func _process(delta):
	
	
	gol_frame = $Gol_Animation.get_frame()

	#Cronômetro do tempo da partida
	
	
	$HUD/Time.text = "0:00"
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
		
	

		
func _on_Blue_Goal_body_entered(body):
	
	Ship.reset_pos()
	Ship2.reset_pos()
	emit_signal("reset") #Emite sinal pras naves e bola reseteram a posição
	$Gol_Animation.set_visible(true)
	$Gol_Animation.play("Gol_R")
	
	



func _on_Red_Goal_body_entered(body):
	
	Ship.reset_pos()
	Ship2.reset_pos()
	emit_signal("reset")
	$Gol_Animation.set_visible(true)
	$Gol_Animation.play("Gol_B")
	
	


func _on_Green_Shine_body_entered(body):
	if Global.FX_off == false:
		$FX/PU_0_IN.play()
	body.power_up(0)
	if body.name == "Ship 2":
		$HUD/PU_Light_Blue.play("Green")
	else:
		$HUD/PU_Light_Red.play("Green")
	$Shine_Star/Green_Shine/Green_Shine_Timer.stop()
	$Shine_Star/Green_Shine/Green_Shine_Timer.start()
	$Shine_Star/Green_Shine/AnimatedSprite.stop()
	$Shine_Star/Green_Shine/AnimatedSprite.set_frame(0)
	



func _on_Red_Shine_body_entered(body):
	if Global.FX_off == false:
		$FX/PU_1_IN.play()
	body.power_up(1)
	if body.name == "Ship 2":
		$HUD/PU_Light_Blue.play("Red")
	else:
		$HUD/PU_Light_Red.play("Red")
	$Shine_Star/Red_Shine/Red_Shine_Timer.stop()
	$Shine_Star/Red_Shine/Red_Shine_Timer.start()
	$Shine_Star/Red_Shine/AnimatedSprite.stop()
	$Shine_Star/Red_Shine/AnimatedSprite.set_frame(0)

func _on_Blue_Shine_body_entered(body):
	if Global.FX_off == false:
		$FX/PU_2_IN.play()
	print (body.name)
	body.power_up(2)
	if body.name == "Ship 2":
		$HUD/PU_Light_Blue.play("Blue")
	else:
		$HUD/PU_Light_Red.play("Blue")
	$Shine_Star/Blue_Shine/Blue_Shine_Timer.stop()
	$Shine_Star/Blue_Shine/Blue_Shine_Timer.start()
	$Shine_Star/Blue_Shine/AnimatedSprite.stop()
	$Shine_Star/Blue_Shine/AnimatedSprite.set_frame(0)
	

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


func _on_Green_Shine_Timer_timeout():
	$Shine_Star/Green_Shine/AnimatedSprite.play("Green")


func _on_Red_Shine_Timer_timeout():
	$Shine_Star/Red_Shine/AnimatedSprite.play("Red")


func _on_Blue_Shine_Timer_timeout():
	$Shine_Star/Blue_Shine/AnimatedSprite.play("Blue")

extends Node2D


var Red_ID = Global.Red_ID
var Blue_ID = Global.Blue_ID
var Red_choices = [preload("res://Ship.tscn"), preload ("res://Annie.tscn"), preload ("res://Bella.tscn"), preload ("res://Vi.tscn"), preload ("res://Mey.tscn"), preload ("res://Betty.tscn")]
var Blue_choices = [preload("res://Ship - Copia.tscn"), preload("res://Tamir.tscn"), preload("res://Pearl.tscn"), preload("res://Hope.tscn"), preload ("res://Wey.tscn"), preload ("res://Sting.tscn")]
var Ship
var Ship2

signal Golden_Gol

var start = false
var time = -9 #Cronometro do jogo.- 11 é o tempo que demora a animacao do Start e Roleta
var minu
var sec
var gol_frame
var Tree_Two_One_GO




var PU_RandomNum123 = RandomNumberGenerator.new()
var PU_RandomType
var Winner 

#onready var hud = get_node("HUD")
func _ready():
	
	Global.GG_Menu = false
	
	#### SHIP SPAWN ####
	
	Ship = Red_choices[Red_ID].instance()
	Ship.connect("Explode", self, "_on_Ship_Explode")
	Ship.connect("Shoot", self, "_on_Ship_Shoot")
	$Ships_Node.add_child(Ship)
	Ship.position = Vector2(775, 256)
	
	Ship2 = Blue_choices[Blue_ID].instance()
	Ship2.connect("Explode2", self, "_on_Ship2_Explode2")
	Ship2.connect("Shoot2", self, "_on_Ship2_Shoot2")
	$Ships_Node.add_child(Ship2)
	Ship2.position = Vector2(135, 256)
	
	#####################
	
	$Start_Animation.set_visible(true)
	$Sound.play()
	$Goals.play("Gold_Shine")
	$Start_Animation.play("Golden_Gol")

	
	PU_RandomNum123.randomize()
	PU_RandomType = PU_RandomNum123.randi_range(0,2)
	
	emit_signal("Golden_Gol")
	Ship.power_up(PU_RandomType)
	Ship2.power_up(PU_RandomType)
	Ship.golden_gol()
	Ship2.golden_gol()
	
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
	
func _on_Roleta_Timer_timeout():
	$Roleta.set_visible(false)
	$Start_Timer_Animation.set_visible(true)
	$Start_Timer_Animation.play("321GO")
	$Start_Timer.start()
	

func _on_Start_Timer_timeout():
	$Start_Timer_Animation.set_visible(false)
	start = true
	

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


func _on_Start_Timer_Animation_animation_finished():
	Ship.unfreeze()
	Ship2.unfreeze()
	$Start_Timer_Animation.set_visible(false)
	start = true

extends Node2D

signal reset
signal Dash_PowUp
signal Still_PowUp
signal Dash_PowUp2
signal Still_PowUp2

signal Golden_Gol

var Blue_Goal = 0
var Red_Goal = 0
var start = false
var time = 0
var minu
var sec
var gol_frame





var PU_RandomNum123 = RandomNumberGenerator.new()
var PU_RandomType

#onready var hud = get_node("HUD")
func _ready():
	$Goals.play("Gold_Shine")
	
	PU_RandomNum123.randomize()
	PU_RandomType = PU_RandomNum123.randi_range(0,1)
	
	emit_signal("Golden_Gol")
	if PU_RandomType == 0:
		emit_signal("Dash_PowUp")
		emit_signal("Dash_PowUp2")
		$HUD/PU_Light_Blue.play("Green")
		$HUD/PU_Light_Red.play("Green")
	elif PU_RandomType == 1:
		emit_signal("Still_PowUp")
		emit_signal("Still_PowUp2")
		$HUD/PU_Light_Red.play("Red")
		$HUD/PU_Light_Blue.play("Red")

	
func _process(delta):
	time += delta
	
	minu = int(int(time)/60)
	sec = int(time)- minu * 60
	if sec > 9:
		$HUD/Time.text = String(minu) + ":" + String(sec)
	else:
		$HUD/Time.text = String(minu) + ":0" + String(sec)
	
	
	
		
func _on_Blue_Goal_body_entered(body):
	get_tree().change_scene("res://Menu.tscn")
	pass
	
func _on_Red_Goal_body_entered(body):
	get_tree().change_scene("res://Menu.tscn")
	pass
	

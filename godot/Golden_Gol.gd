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
var time 
var match_time
var minu
var sec
var gol_frame
const PU_Xmax = 750
const PU_Ymax = 100
const PU_Xmin = 170
const PU_Ymin = 400


var PU_RandomNum123 = RandomNumberGenerator.new()
var PU_RandomType

#onready var hud = get_node("HUD")
func _ready():
	$Goals.play("Gold_Shine")
	
	PU_RandomNum123.randomize()
	PU_RandomType = PU_RandomNum123.randi_range(0,1)
	
	print (PU_RandomType)
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
	pass
	

		
func _on_Blue_Goal_body_entered(body):
	get_tree().change_scene("res://Menu.tscn")
	pass
	
func _on_Red_Goal_body_entered(body):
	get_tree().change_scene("res://Menu.tscn")
	pass
	

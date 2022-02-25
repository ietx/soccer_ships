extends Node2D

var Red_ID = Global.Red_ID
var Blue_ID = Global.Blue_ID
var Red_choices = [preload("res://Ship.tscn"), preload ("res://Annie.tscn"), preload ("res://Bella.tscn"), preload ("res://Vi.tscn"), preload ("res://Mey.tscn"), preload ("res://Betty.tscn"), preload ("res://Jinx.tscn"), preload ("res://Bayron.tscn")]
var Blue_choices = [preload("res://Ship - Copia.tscn"), preload("res://Tamir.tscn"), preload("res://Pearl.tscn"), preload("res://Hope.tscn"), preload ("res://Wey.tscn"), preload("res://Sting.tscn"), preload ("res://Bobby.tscn"), preload ("res://Telly.tscn")]
var Ship
var Ship2



# Called when the node enters the scene tree for the first time.
func _ready():
	$Stage.play()
	
#### SHIP SPAWN ####
	
	Ship = Red_choices[Red_ID].instance()
	add_child(Ship)
	Ship.position = Vector2(775, 256)
	
	Ship2 = Blue_choices[Blue_ID].instance()
	add_child(Ship2)
	Ship2.position = Vector2(135, 256)

	Ship.red_wins_unfreeze()
	Ship2.red_wins_unfreeze()


func _on_Timer_timeout():
	get_tree().change_scene("res://Menu.tscn")
	pass # Replace with function body.

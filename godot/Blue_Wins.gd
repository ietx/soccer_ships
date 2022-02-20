extends Node2D

signal Unfreeze_1
signal Unfreeze_2
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Stage.play()
	emit_signal("Unfreeze_1")
	emit_signal("Unfreeze_2")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	get_tree().change_scene("res://Menu.tscn")
	

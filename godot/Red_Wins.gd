extends Node2D


signal Unfreeze_1
signal Unfreeze_2


# Called when the node enters the scene tree for the first time.
func _ready():
	emit_signal("Unfreeze_1")
	emit_signal("Unfreeze_2")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	get_tree().change_scene("res://Menu.tscn")
	pass # Replace with function body.

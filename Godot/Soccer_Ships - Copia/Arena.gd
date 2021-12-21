extends Node2D

signal Blue_Goal
signal Red_Goal
var Blue_Goal = 0
var Red_Goal = 0
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Blue_Goal_body_entered(body):
	Blue_Goal += 1
	$Score/Blue.text = String(Blue_Goal)
	emit_signal("Blue_Goal")


func _on_Red_Goal_body_entered(body):
	Red_Goal += 1
	$Score/Red.text = String(Red_Goal)
	emit_signal("Red_Goal")
	


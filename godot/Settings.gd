extends Control


func _ready():
	$Blind.play()

func _on_Controls_pressed():
	pass # Replace with function body.

func _on_Back_pressed():
	get_tree().change_scene("res://Menu.tscn")

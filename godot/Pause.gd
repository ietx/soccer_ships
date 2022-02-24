extends Control

var new_pause_state

func _input(event):
	new_pause_state = not get_tree().paused
	if event.is_action_pressed("Pause"):
		get_tree().paused = new_pause_state
		visible = new_pause_state


func _on_Quit_pressed():
	get_tree().change_scene("res://Menu.tscn")
	get_tree().paused = new_pause_state

func _on_Restart_pressed():
	get_tree().change_scene("res://Arena.tscn")
	get_tree().paused = new_pause_state

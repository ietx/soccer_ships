extends Control

var music_switch = Global.music_off

func _ready():
	if music_switch == false:
		$Blind.play()

func _process(delta):
	if Global.FX_off == true:
		$FX_switch.pressed = true
	if music_switch:
		$Music_Switch.pressed = true
	
func _on_Controls_pressed():
	pass # Replace with function body.

func _on_Back_pressed():
	get_tree().change_scene("res://Menu.tscn")


func _on_Music_Switch_toggled(button_pressed): #MUSIC OFF TRUE
	music_switch = button_pressed
	Global.music_off = music_switch
	$Blind.stop()
	if button_pressed == false:
		$Blind.play()
	

func _on_FX_switch_toggled(button_pressed): #True eh off
	Global.FX_off = button_pressed
	pass # Replace with function body.

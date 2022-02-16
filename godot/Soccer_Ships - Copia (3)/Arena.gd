extends Node2D

signal reset
signal freeze
var Blue_Goal = 0
var Red_Goal = 0
var start = false

#onready var hud = get_node("HUD")
func _ready():
	$StartTimer.start()

#	hud.get_node("HUD/CenterContainer/CountDown").set_text((round($StartTimer.time_left)))
	
func _process(delta):	
	if $StartTimer.time_left > 1:
		$HUD/PanelContainer/CenterContainer/CountDown.text = String(int($StartTimer.time_left))
	else:
		$HUD/PanelContainer/CenterContainer/CountDown.text = ("Go!")
	
	$HUD/Time/Label.text = String(int($TimeNormal.time_left))
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


		
func _on_Blue_Goal_body_entered(body):
	Blue_Goal += 1
	$HUD/Red.text = String(Blue_Goal)
	emit_signal("reset") #Emite sinal pras naves e bola reseteram a posição
	$HUD/PanelContainer.set_visible(true)
	$StartTimer.start()
	$TimeNormal.stop()


func _on_Red_Goal_body_entered(body):
	Red_Goal += 1
	$HUD/Blue.text = String(Red_Goal)
	emit_signal("reset")
	$HUD/PanelContainer.set_visible(true)
	$StartTimer.start()
	$TimeNormal.stop()



func _on_StartTimer_timeout():
	$HUD/PanelContainer.set_visible(false)
	$TimeNormal.start()




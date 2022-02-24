extends Control

var ani_end = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Blind.play()
	$Ships/Ship/Animation.play("Ship-X")
	$Ships/Ship2/Animation.play("Ship-X")
	$Ships/Ship3/Animation.play("Ship-X")
	$Ships/Ship4/Animation.play("Ship-X")
	$Ships/Ship5/Animation.play("Ship-X")
	
	$Ships2/Ship/Animation.play("Ship-X")
	$Ships2/Ship2/Animation.play("Ship-X")
	$Ships2/Ship3/Animation.play("Ship-X")
	$Ships2/Ship4/Animation.play("Ship-X")
	$Ships2/Ship5/Animation.play("Ship-X")
	pass
	# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Ships/Ship3/Animation.is_playing() == false:
		$Ships/Ship/Animation.play("Ship-X")
		$Ships/Ship2/Animation.play("Ship-X")
		$Ships/Ship3/Animation.play("Ship-X")
		$Ships/Ship4/Animation.play("Ship-X")
		$Ships/Ship5/Animation.play("Ship-X")
		
		$Ships2/Ship/Animation.play("Ship-X")
		$Ships2/Ship2/Animation.play("Ship-X")
		$Ships2/Ship3/Animation.play("Ship-X")
		$Ships2/Ship4/Animation.play("Ship-X")
		$Ships2/Ship5/Animation.play("Ship-X")


func _on_GG_Button_pressed():
	Global.GG_Menu = true
	get_tree().change_scene("res://Sellect_Ship GG.tscn")
	

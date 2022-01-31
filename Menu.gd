extends Control

var ani_end = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Ship/Animation.play("Ship-X")
	$Ship2/Animation.play("Ship-X")
	$Ship3/Animation.play("Ship-X")
	$Ship4/Animation.play("Ship-X")
	$Ship5/Animation.play("Ship-X")
	pass
	# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Ship3/Animation.is_playing() == false:
		$Ship/Animation.play("Ship-X")
		$Ship2/Animation.play("Ship-X")
		$Ship3/Animation.play("Ship-X")
		$Ship4/Animation.play("Ship-X")
		$Ship5/Animation.play("Ship-X")

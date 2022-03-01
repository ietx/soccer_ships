extends Area2D

export (int) var speed
var Ship
var velocity = Vector2()
var area_enter = false
var ani_playing

func start(muz_pos, rot, dir, ship):
	Ship = ship
	if ship == "Red":
		$Sprite.play("Red")
	elif ship == "Blue":
		$Sprite.play("Blue")
	position = muz_pos
	rotation = rot
	velocity = dir * speed

		
func _physics_process(delta):
	ani_playing = str($Sprite.get_animation())
#	print(ani_playing)
	if area_enter == false:
		position += velocity * delta
	else:
		pass

 

func _on_Bullet_body_entered(body):
	area_enter = true
	if Ship == "Red":
		$Sprite.play("Red_Hit")
	elif Ship == "Blue":
		$Sprite.play("Blue_Hit")
	if body.has_method("get_shoot"):
		body.get_shoot()
#	

	


func _on_Sprite_animation_finished():
	if ani_playing == "Red_Hit":
		queue_free()
	elif ani_playing == "Blue_Hit":
		queue_free()
	else:
		pass

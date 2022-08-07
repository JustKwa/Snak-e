extends Node2D


var direction = ""


onready var body_sprite = $body_sprite
onready var body_bent_sprite = $body_bent_sprite


func _ready():
	pass


func turn():
	body_bent_sprite.visible = false
	body_sprite.visible = true
	match direction:
		"left":
			body_sprite.set_rotation_degrees(0)
		"right":
			body_sprite.set_rotation_degrees(180)
		"up":
			body_sprite.set_rotation_degrees(90)
		"down":
			body_sprite.set_rotation_degrees(-90)


func bent_to(bent_direction):
	body_sprite.visible = false
	body_bent_sprite.visible = true
	var bent_to  = direction + bent_direction
	match bent_to:
		"upright" ,"leftdown":
			body_bent_sprite.set_rotation_degrees(0)
		"upleft" ,"rightdown":
			body_bent_sprite.set_rotation_degrees(90)
		"downright" ,"leftup":
			body_bent_sprite.set_rotation_degrees(-90)
		"downleft" ,"rightup":
			body_bent_sprite.set_rotation_degrees(180)


	# if "left" in bent_to:
	# 	if "up" in bent_to:
	# 		body_bent_sprite.set_rotation_degrees(-90)
	# 	elif "down" in bent_to:
	# 		body_bent_sprite.set_rotation_degrees(0)
	# elif "right" in bent_to:
	# 	if "up" in bent_to:
	# 		body_bent_sprite.set_rotation_degrees(-180)
	# 	elif "down" in bent_to:
	# 		body_bent_sprite.set_rotation_degrees(90)




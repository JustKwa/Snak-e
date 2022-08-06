extends Node2D

onready var body_sprite = $body_sprite
onready var body_bent_sprite = $body_bent_sprite 

func _ready():
	pass


func turn_to(direction):
	match direction:
		"left":
			body_sprite.set_rotation_degrees(0)
		"right":
			body_sprite.set_rotation_degrees(180)
		"up":
			body_sprite.set_rotation_degrees(90)
		"down":
			body_sprite.set_rotation_degrees(-90)


func bent_to(direction):
	match direction:
		"up_right":
			body_bent_sprite.set_rotation_degress(-90)
		"up_left":
			body_bent_sprite.set_rotation_degress(-180)
		"down_right":
			body_bent_sprite.set_rotation_degrees(0)
		"down_left":
			body_bent_sprite.set_rotation_degrees(90)

extends Node2D

onready var head_sprite = $head_sprite 


func _ready():
	pass


func turn_to(direction):
	match direction:
		"left":
			head_sprite.set_rotation_degrees(0)
		"right":
			head_sprite.set_rotation_degrees(180)
		"up":
			head_sprite.set_rotation_degrees(90)
		"down":
			head_sprite.set_rotation_degrees(-90)

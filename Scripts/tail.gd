extends Node2D


onready var tail_sprite = $tail_sprite

func _ready():
	pass

func turn_to(direction):
	match direction:
		"left":
			tail_sprite.set_rotation_degrees(0)
		"right":
			tail_sprite.set_rotation_degrees(180)
		"up":
			tail_sprite.set_rotation_degrees(90)
		"down":
			tail_sprite.set_rotation_degrees(-90)



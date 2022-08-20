extends Area2D

var direction = []
var current_pos
var percent_to_tile = 0.0

func _ready():
	current_pos = self.position
	rotate_sprite()

func _physics_process(_delta):
	rotate_sprite()

func rotate_sprite():
	if direction.empty():
		return
	else:
		match direction.front():
			Vector2(-1, 0):
				$Sprite.set_rotation_degrees(0)
			Vector2(1, 0):
				$Sprite.set_rotation_degrees(180)
			Vector2(0, 1):
				$Sprite.set_rotation_degrees(-90)
			Vector2(0, -1):
				$Sprite.set_rotation_degrees(90)
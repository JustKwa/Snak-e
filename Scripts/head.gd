extends Area2D

var direction = []
var current_pos
var percent_to_tile = 0.0

func _ready():
	current_pos = self.position
	rotate_sprite()

func _physics_process(_delta):
	rotate_sprite()

# func move( input_dir, speed, delta, GRID_SIZE):

# 	percent_to_tile += speed * delta

# 	if percent_to_tile >= 1.0:
# 		position = current_pos + (direction.front() * GRID_SIZE)
# 		current_pos = position
# 		percent_to_tile = 0.0
# 		direction.append(input_dir)
# 		direction.pop_front()
# 	else:
# 		position = current_pos + (GRID_SIZE * percent_to_tile * direction.front())

func rotate_sprite():
	match direction.front():
		Vector2(-1, 0):
			$Sprite.set_rotation_degrees(0)
		Vector2(1, 0):
			$Sprite.set_rotation_degrees(180)
		Vector2(0, 1):
			$Sprite.set_rotation_degrees(-90)
		Vector2(0, -1):
			$Sprite.set_rotation_degrees(90)

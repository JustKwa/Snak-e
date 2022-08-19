extends Area2D

var direction = []
var current_pos
var percent_to_tile = 0.0


func _ready():
	current_pos = self.position


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


func _on_body_area_entered(area: Area2D):
	if area.name == "head":
		return get_tree().reload_current_scene()
	else:
		queue_free()
	pass

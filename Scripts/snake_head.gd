extends SnakeBody

signal at_tile


func _move(delta):
	rotate_sprite()

	percent_to_tile += global_var.speed * delta

	# Detects movement change at < 1.0 for snappier movement
	if percent_to_tile >= 0.94:
		position = current_pos + (direction * GRID_SIZE)
		current_pos = self.position
		percent_to_tile = 0.0
		emit_signal("at_tile")

	else:
		position = current_pos + (GRID_SIZE * percent_to_tile * direction)


func rotate_sprite() -> void:
	match direction:
		Vector2.LEFT:
			get_child(0).set_rotation_degrees(0)
		Vector2.RIGHT:
			get_child(0).set_rotation_degrees(180)
		Vector2.DOWN:
			get_child(0).set_rotation_degrees(-90)
		Vector2.UP:
			get_child(0).set_rotation_degrees(90)

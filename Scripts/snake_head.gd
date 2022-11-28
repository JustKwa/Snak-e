extends SnakeBody

onready var snake_controller = get_parent()

signal at_tile

func _ready():
	snake_controller.connect('food_eaten', self,'on_food_eaten')	


func _move(delta):
	_rotate()

	percent_to_tile += global_var.speed * delta

	# Detects movement change at < 1.0 for snappier movement
	if percent_to_tile >= 0.94:
		position = current_pos + (direction * GRID_SIZE)
		current_pos = self.position
		percent_to_tile = 0.0
		emit_signal("at_tile")

	else:
		position = current_pos + (GRID_SIZE * percent_to_tile * direction)


func _rotate() -> void:
	match direction:
		Vector2.LEFT:
			set_rotation_degrees(0)
		Vector2.RIGHT:
			set_rotation_degrees(180)
		Vector2.DOWN:
			set_rotation_degrees(-90)
		Vector2.UP:
			set_rotation_degrees(90)


func on_food_eaten() -> void:
	emit_signal('food_eaten')
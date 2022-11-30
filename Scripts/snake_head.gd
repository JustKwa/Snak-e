extends SnakeBody

signal at_tile

enum RotateAngle { LEFT = 0, RIGHT = 180, UP = 90, DOWN = -90 }
enum State { ROTATE, MOVE }

var rotation_angle: int = RotateAngle.RIGHT

onready var snake_controller = get_parent()


func _ready():
	state = State.MOVE
	snake_controller.connect("food_eaten", self, "on_food_eaten")


func _physics_process(delta):
	match state:
		State.ROTATE:
			_rotate(rotation_angle)
			state = State.MOVE
		State.MOVE:
			_move(delta)
			if _is_rotate():
				state = State.ROTATE


func on_food_eaten() -> void:
	animation_player.play("eat_hold")


func _move(delta):
	percent_to_tile += global_var.speed * delta

	# Detects movement change at < 1.0 for snappier movement
	if percent_to_tile >= 0.94:
		position = current_pos + (direction * GRID_SIZE)
		current_pos = self.position
		percent_to_tile = 0.0
		emit_signal("at_tile")


func _is_rotate() -> bool:
	var new_rotation_angle: int
	match direction:
		Vector2.LEFT:
			new_rotation_angle = RotateAngle.LEFT
		Vector2.RIGHT:
			new_rotation_angle = RotateAngle.RIGHT
		Vector2.DOWN:
			new_rotation_angle = RotateAngle.DOWN
		Vector2.UP:
			new_rotation_angle = RotateAngle.UP
	if new_rotation_angle == rotation_angle:
		return false
	else:
		rotation_angle = new_rotation_angle
		return true


func _rotate(value: int):
	set_rotation_degrees(value)

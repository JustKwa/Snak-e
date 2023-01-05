extends SnakeBody

signal at_tile

enum RotateAngle { LEFT = 0, RIGHT = 180, UP = 90, DOWN = -90 }
enum State { IDLE, ROTATE, MOVE, SHOOT, EXPLODE }

var rotation_angle: int = RotateAngle.RIGHT

onready var snake_controller = get_parent()
onready var animation_player2 = $AnimationPlayer2
onready var timer = $Timer


func _ready():
	state = State.MOVE
	snake_controller.connect("food_eaten", self, "on_food_eaten")
	snake_controller.connect("move_snake", self, "_on_move_snake")


func _physics_process(delta):
	match state:
		State.ROTATE:
			_rotate(rotation_angle)
			state = State.MOVE
		State.MOVE:
			_move(delta)
			if _is_rotate():
				state = State.ROTATE
		State.SHOOT:
			print("shoot")
			_shoot()
			state = State.MOVE
		State.EXPLODE:
			_explode()


func _on_move_snake(snake_direction):
	direction = snake_direction


# func _idle():
# 	direction = Vector2.ZERO
# 	state = State.MOVE


func on_food_eaten() -> void:
	# var is_hold_food_animation: bool = "hold_food" in animation_player2.current_animation

	# if is_hold_food_animation:
	# 	state = State.SHOOT
	# 	yield(animation_player2, "animation_finished")
	# 	animation_player2.play("hold_food")
	# 	return

	# if is_transitioning:
	# 	return

	if global_var.is_transitioning:
		timer.stop()
		animation_player2.play("neutral")

	timer.start()
	animation_player.play("eat_hold")
	animation_player2.play("hold_food")


func _move(delta):
	percent_to_tile += global_var.speed * delta

	# Detects movement change at < 1.0 for snappier movement
	if percent_to_tile >= 0.94:
		position = current_pos + (direction * GRID_SIZE)
		current_pos = self.position
		percent_to_tile = 0.0
		emit_signal("at_tile")
		return

	position = current_pos + (GRID_SIZE * percent_to_tile * direction)


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
		_:
			new_rotation_angle = RotateAngle.RIGHT

	if new_rotation_angle == rotation_angle:
		return false

	rotation_angle = new_rotation_angle
	return true


func _rotate(value: int):
	set_rotation_degrees(value)


func _explode():
	animation_player.play("explode")
	yield(animation_player, "animation_finished")
	global_var.game_over = true


func _shoot():
	animation_player.play("eat_shoot")
	animation_player2.play("neutral")


func _on_head_area_entered(area):
	if area.is_in_group("head_ignore"):
		return

	state = State.EXPLODE


func change_state(value):
	match value:
		"IDLE":
			state = State.IDLE
		"MOVE":
			state = State.MOVE
		"ROTATE":
			state = State.ROTATE
		"EXPLODE":
			state = State.EXPLODE


func _on_Timer_timeout():
	state = State.SHOOT
	timer.stop()


func _on_Line2D_snake_explode():
	state = State.EXPLODE

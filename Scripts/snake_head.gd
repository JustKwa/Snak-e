extends SnakeBody

signal at_tile

enum RotateAngle { LEFT = 0, RIGHT = 180, UP = 90, DOWN = -90 }
enum State { ROTATE, MOVE, SHOOT }

var rotation_angle: int = RotateAngle.RIGHT

onready var snake_controller = get_parent()
onready var animation_player2 = $AnimationPlayer2


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
			if _is_shoot():
				state = State.SHOOT
		State.SHOOT:
			_shoot()
			state = State.MOVE


func on_food_eaten() -> void:
	var is_hold_food_animation: bool = "hold_food" in animation_player2.current_animation

	if is_hold_food_animation:
		state = State.SHOOT
		yield(animation_player2, "animation_finished")
		animation_player2.play("hold_food")
		return

	animation_player.play("eat_hold")


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

	if new_rotation_angle == rotation_angle:
		return false

	rotation_angle = new_rotation_angle
	return true


func _rotate(value: int):
	set_rotation_degrees(value)


func _is_shoot() -> bool:
	var shoot_is_pressed: bool = Input.is_action_just_pressed("ui_shoot")
	var is_hold_food_animation: bool = "hold_food" in animation_player2.current_animation

	if shoot_is_pressed && is_hold_food_animation:
		return true

	return false


func _shoot():
	animation_player.play("eat_shoot")
	animation_player2.play("neutral")


func _on_head_area_entered(area):
	if "food" in area.name:
		return

	if "disconnect_check" in area.name:
		return

	# global_var.game_over = true

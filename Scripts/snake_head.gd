extends SnakeBody

signal at_tile
signal is_shoot

enum RotateAngle { LEFT = 0, RIGHT = 180, UP = 90, DOWN = -90 }
enum State { IDLE, ROTATE, MOVE, SHOOT, EXPLODE }

var rotation_angle: int = RotateAngle.RIGHT
var is_about_to_shoot: bool = false
var is_in_tile: bool = false

onready var snake_controller = get_parent()
onready var animation_player2 = $AnimationPlayer2
onready var timer = $Timer


func _ready():
	direction = Vector2.RIGHT
	state = State.MOVE
	snake_controller.connect("food_eaten", self, "on_food_eaten")


func _physics_process(delta):
	match state:
		State.IDLE:
			return
		State.ROTATE:
			_rotate(rotation_angle)
			state = State.MOVE
		State.MOVE:
			_move(delta)
			if _is_rotate():
				state = State.ROTATE
		State.SHOOT:
			_shoot()
			
			if is_about_to_shoot:
				return

			state = State.MOVE
		State.EXPLODE:
			_explode()
			state = State.IDLE



func on_food_eaten() -> void:
	animation_player.play("eat_hold")
	$eat.play()
	if global_var.is_transitioning:
		animation_player2.play("neutral")


func _move(delta):
	percent_to_tile += global_var.speed * delta

	if percent_to_tile >= 0.94:
		position = current_pos + (direction * GRID_SIZE)
		current_pos = self.position
		percent_to_tile = 0.0
		emit_signal("at_tile")

		if !is_about_to_shoot:
			return
		
		is_in_tile = true
		global_var.speed = 0
		state = State.SHOOT

		return

	is_in_tile = false
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
	$explode.play()
	yield(animation_player, "animation_finished")
	global_var.game_over = true


func _shoot():
	animation_player.play("eat_hold")
	return
	

func _on_head_area_entered(area):
	if area.is_in_group("head_ignore"):
		return

	state = State.EXPLODE


func _on_Line2D_snake_explode():
	state = State.EXPLODE


func _on_direction_checker_move_snake(snake_direction):
	if is_about_to_shoot:
		return

	direction = snake_direction


func _on_shoot_function_shoot_turn(snake_direction):
	direction = snake_direction
	is_in_tile = false
	is_about_to_shoot = false
	state = State.MOVE
	animation_player.play("eat_shoot")
	$shoot.play()


func _on_Line2D_shoot():
	is_about_to_shoot = true
	emit_signal("is_shoot")

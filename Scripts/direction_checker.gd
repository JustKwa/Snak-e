extends Node2D

signal move_snake(snake_direction)

var prev_input = [Vector2.ZERO]


func _process(_delta):
	_is_moving()


func _is_moving() -> void:
	if _check_dir() == prev_input.back():
		return

	if prev_input.size() <= 2:
		prev_input.append(_check_dir())


func _check_dir():
	if prev_input.back().x == 0:
		if Input.is_action_just_pressed("ui_left"):
			return Vector2.LEFT
		if Input.is_action_just_pressed("ui_right"):
			return Vector2.RIGHT

	if prev_input.back().y == 0:
		if Input.is_action_just_pressed("ui_up"):
			return Vector2.UP
		if Input.is_action_just_pressed("ui_down"):
			return Vector2.DOWN

	return prev_input.back()


func _on_head_at_tile():
	if prev_input.size() == 1:
		return

	prev_input.pop_front()
	emit_signal("move_snake", prev_input.front())


func _on_head_is_shoot():
	prev_input = [Vector2.ZERO]
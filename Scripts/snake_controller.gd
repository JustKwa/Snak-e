extends Node2D

signal food_eaten
signal move_snake(snake_direction)

var prev_input = []

onready var global_var: Resource = preload("res://global_var.tres")
onready var body = preload("res://Scenes/body.tscn")
onready var head = $head
onready var item_controller = get_parent().get_node("item_controller")


func _ready():
	prev_input = [Vector2.ZERO]
	head.connect("at_tile", self, "change_dir")
	item_controller.connect("food_eaten", self, "_on_food_eaten")
	var _connect_next_level_signal = global_var.connect("next_level", self, "_on_next_level")


func _process(_delta):
	_is_moving()


func change_dir() -> void:
	if prev_input.size() == 1:
		return

	prev_input.pop_front()
	emit_signal("move_snake", prev_input.front())
	# head.direction = prev_input.front()


func spawn_body() -> void:
	var instance = body.instance()
	instance.direction = head.direction * -1
	instance.position = head.position
	call_deferred("add_child", instance)


func _on_food_eaten() -> void:
	emit_signal("food_eaten")


func _is_moving() -> void:
	var input = _check_dir()

	if input == prev_input.back():
		return

	if prev_input.size() <= 2:
		prev_input.append(input)


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


func _on_next_level():
	# for child in get_children():
	# 	if child.is_in_group("self_destructable"):
	# 		child.self_destruct()

	prev_input = [Vector2.ZERO]

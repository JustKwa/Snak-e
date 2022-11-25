extends Node2D


var prev_input = [] 

var global_var: Resource = preload("res://global_var.tres")
onready var body = preload("res://Scenes/body.tscn")
onready var head = $head
onready var animation_player = get_node("head").get_node("AnimationPlayer")


func _ready():
	prev_input = [Vector2.RIGHT]
	head.connect('at_tile', self, 'change_dir')


func _process(_delta):
	_is_moving()


func change_dir():
	if prev_input.size() == 1:
		return
	else:
		prev_input.pop_front()
		head.direction = prev_input.front()


func _is_moving() -> void:
	var input = _check_dir()
	if input == prev_input.back():
		return
	elif prev_input.size() <= 2:
		prev_input.append(input)


func _check_dir():
	if prev_input.back().x == 0:
		if Input.is_action_just_pressed('ui_left'):
			return Vector2.LEFT
		elif Input.is_action_just_pressed('ui_right'):
			return Vector2.RIGHT
		else:
			return prev_input.back()
	elif prev_input.back().y == 0:
		if Input.is_action_just_pressed('ui_up'):
			return Vector2.UP
		elif Input.is_action_just_pressed('ui_down'):
			return Vector2.DOWN
		else:
			return prev_input.back()


func spawn_body() -> void:
	var instance = body.instance()
	instance.direction = head.direction * -1
	instance.position = head.position
	call_deferred("add_child", instance)


func food_eaten():
	animation_player.play("eat_shoot")

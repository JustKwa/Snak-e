extends Node2D

const GRID_SIZE = 8

export var speed = 2.0
var input_dir = []
var input = Vector2.ZERO
var gap = -8
var length = 1

onready var body = preload("res://Scenes/body.tscn")
onready var head = $head


func _ready():
	input_dir.append(Vector2(1, 0))
	head.direction.append(input_dir.front())
	spawn_body()
	pass


func _physics_process(delta):
	_check_dir()
	move(delta)


func move(delta):
	for i in get_children():
		i.percent_to_tile += speed * delta

		if i.percent_to_tile >= 1.0:
			i.position = i.current_pos + (i.direction.front() * GRID_SIZE)
			i.current_pos = i.position
			i.percent_to_tile = 0.0
			if i.direction.size() > 1:
				var current_child_id = int(get_children().find(i))
				print(current_child_id)
				if current_child_id < get_child_count() - 1:
					get_child(current_child_id + 1).direction.append(i.direction.front())
				i.direction.pop_front()

		else:
			i.position = i.current_pos + (GRID_SIZE * i.percent_to_tile * i.direction.front())


func _check_dir():
	if input.x == 0:
		input.y = int(Input.is_action_just_pressed("ui_down")) - int(Input.is_action_just_pressed("ui_up"))
	if input.y == 0:
		input.x = int(Input.is_action_just_pressed("ui_right")) - int(Input.is_action_just_pressed("ui_left"))

	if input != input_dir.back() and input != Vector2.ZERO:
		if input.x + input_dir.back().x != 0 or input.y + input_dir.back().y != 0:
			input_dir.append(input)
			head.direction.append(input)

	pass


func spawn_body():
	length += 1
	var instance = body.instance()
	var prev_body = get_child(get_child_count() - 1)
	instance.position = prev_body.position
	instance.direction.append(Vector2.ZERO)
	for i in prev_body.direction:
		instance.direction.append(i)
	add_child(instance)
	pass

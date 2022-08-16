extends Node2D

const GRID_SIZE = 8

var move_dir = Vector2.ZERO
var is_turning = false
var will_turn = false
var percent_to_tile = 0.0
var speed = 5.0
var input_dir = Vector2.ZERO

onready var body = preload("res://scenes/body.tscn")
onready var head = $head

func _ready():
	head.direction.append(Vector2(1, 0))
	$Timer.start()
	pass 

func _physics_process(delta):
	# if !is_turning:
	# 	_check_dir()
	# else:
		_check_dir()
		move(delta)

func _check_dir():
	if input_dir.x == 0:
		input_dir.y = int(Input.is_action_just_pressed("ui_down")) - int(Input.is_action_just_pressed("ui_up")) 
	if input_dir.y == 0:
		input_dir.x = int(Input.is_action_just_pressed("ui_right")) - int(Input.is_action_just_pressed("ui_left")) 

	if input_dir != move_dir and input_dir != Vector2.ZERO:
		if input_dir.x + move_dir.x != 0 or input_dir.y + move_dir.y != 0:
			move_dir = input_dir
			if head.direction.size() <= 2:
				head.direction.append(move_dir)
				print(head.direction)
			is_turning = true

func move(delta):
	percent_to_tile += speed * delta
	for i in range(2,get_child_count()):
		if get_child(i-1).direction.front() == get_child(i).direction.front(): 
			return
		else:
			get_child(i).direction.append(get_child(i-1).direction.front())
	for i in range(1,get_child_count()):
		if percent_to_tile >= 1.0:
			get_child(i).position = get_child(i).current_pos + (get_child(i).direction.front() * GRID_SIZE)
			get_child(i).current_pos = get_child(i).position
			percent_to_tile = 0.0
			if is_turning:
				print("pop")
				get_child(i).direction.pop_front()
				print(head.direction)
				is_turning = false
		else:
			get_child(i).position = get_child(i).current_pos + (GRID_SIZE * percent_to_tile * get_child(i).direction.front())
	pass

func spawn_body():
	# var instance = body.instance()
	# var prev_body = get_child(get_child_count() - 1)
	# instance.position = prev_body.position + gap
	# add_child(instance)
	pass

func _on_Timer_timeout():
	# print(is_turning)
	# print(head.direction)
	pass

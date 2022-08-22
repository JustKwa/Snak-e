extends Node2D

var input_dir = [Vector2(1, 0),Vector2(1, 0),Vector2(1, 0)] 
var old_input = [Vector2(1, 0)]
export var global_var: Resource = preload("res://global_var.tres")

# onready var body = preload("res://Scenes/body.tscn")
onready var body = $body
onready var head = $head


func _ready():
	head.direction = input_dir.back()
	body.direction = input_dir[1]
	head.connect("at_tile", self, "head_move")
	body.connect("at_tile", self, "body_move")



func _physics_process(_delta):
	_check_dir()


func head_move():
	input_dir.pop_front()
	input_dir.append(old_input.front())
	head.direction = input_dir.back()


func body_move():
	body.direction = input_dir[1]


func _check_dir():
	var input = Vector2.ZERO
	if input.x == 0:
		input.y = int(Input.is_action_just_pressed("ui_down")) - int(Input.is_action_just_pressed("ui_up"))
	if input.y == 0:
		input.x = int(Input.is_action_just_pressed("ui_right")) - int(Input.is_action_just_pressed("ui_left"))
	
	# if input_dir.size() <= 3: 
	if input != old_input.front() and input != Vector2.ZERO:
		if input.x + old_input.front().x != 0 or input.y + old_input.front().y != 0:
			old_input.append(input)
			old_input.pop_front()


# func spawn_body():
# 	var instance = body.instance()
# 	var prev_body = get_child(get_child_count() - 1)
# 	if prev_body.name == "head":
# 		instance.position = prev_body.position * global_var.gap * prev_body.direction.front()
# 	else:
# 		instance.position = prev_body.position
# 	instance.direction.append(Vector2.ZERO)
# 	for i in prev_body.direction:
# 		instance.direction.append(i)
# 	call_deferred("add_child", instance)

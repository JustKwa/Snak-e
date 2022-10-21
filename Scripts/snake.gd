extends Node2D

const GLOBAL_VAR: Resource = preload("res://global_var.tres")
const GAP: int = GLOBAL_VAR.gap

var input_dir = [Vector2(1, 0), Vector2(1, 0), Vector2(1, 0)]
var old_input = [Vector2(1, 0)]

onready var body = preload("res://Scenes/body.tscn")
onready var head = $head


func _ready():
	head.direction = input_dir.back()
	head.connect("at_tile", self, "head_move")


func _process(_delta):
	_check_dir()


func head_move():
	if old_input.size() > 1:
		old_input.pop_front()
	input_dir.pop_front()
	input_dir.append(old_input.front())
	head.direction = input_dir.back()


func _check_dir():
	var input = Vector2.ZERO
	if input.x == 0:
		input.y = (
			int(Input.is_action_just_pressed("ui_down"))
			- int(Input.is_action_just_pressed("ui_up"))
		)
	if input.y == 0:
		input.x = (
			int(Input.is_action_just_pressed("ui_right"))
			- int(Input.is_action_just_pressed("ui_left"))
		)

	if input != old_input.front() and input != Vector2.ZERO:
		if input.x + old_input.front().x != 0 or input.y + old_input.front().y != 0:
			old_input.append(input)
			# print(old_input)


func spawn_body():
	var instance = body.instance()
	instance.direction = head.direction * -1
	instance.position = head.position
	call_deferred("add_child", instance)


func _on_Level_area_exited(area):
	if area.name == "head":
		print(area.name)
	elif "body" in area.name:
		print(area.name)
		get_node(area.name).change_dir()
	pass  # Replace with function body.

extends Node2D

var input_dir = []
var input = Vector2.ZERO
export var global_var: Resource = preload("res://global_var.tres")

onready var body = preload("res://Scenes/body.tscn")
onready var head = $head


func _ready():
	input_dir.append(Vector2(1, 0))
	head.direction.append(input_dir.front())
	$body.direction.append(head.direction.front())


func _physics_process(_delta):
	_check_dir()


func _check_dir():
	if input.x == 0:
		input.y = int(Input.is_action_just_pressed("ui_down")) - int(Input.is_action_just_pressed("ui_up"))
	if input.y == 0:
		input.x = int(Input.is_action_just_pressed("ui_right")) - int(Input.is_action_just_pressed("ui_left"))

	if head.direction.size() <= 2:
		if input != input_dir.back() and input != Vector2.ZERO:
			if input.x + input_dir.back().x != 0 or input.y + input_dir.back().y != 0:
				input_dir.append(input)
				head.direction.append(input)

	head.connect("change_dir", self, "change_body_dir")


func change_body_dir():
	get_child(1).direction.append(head.direction.front())


func spawn_body():
	var instance = body.instance()
	var prev_body = get_child(get_child_count() - 1)
	if prev_body.name == "head":
		instance.position = prev_body.position * global_var.gap * prev_body.direction.front()
	else:
		instance.position = prev_body.position
	instance.direction.append(Vector2.ZERO)
	for i in prev_body.direction:
		instance.direction.append(i)
	call_deferred("add_child", instance)

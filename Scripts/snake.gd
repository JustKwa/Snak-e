extends Node2D

const GLOBAL_VAR: Resource = preload("res://global_var.tres")

var input_dir = [Vector2(1, 0), Vector2(1, 0), Vector2(1, 0)]
var old_input = Vector2(1, 0)

onready var body = preload("res://Scenes/body.tscn")
onready var head = $head
onready var animation_player = get_node("head").get_node("AnimationPlayer")

signal game_over


func _ready():
	head.direction = input_dir.back()
	head.connect("at_tile", self, "head_move")


func _process(_delta):
	_check_dir()


func head_move():
	input_dir.append(old_input)
	input_dir.pop_front()
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
	if input_dir.size() > 3:
		return
	if input != old_input and input != Vector2.ZERO:
		if input.x + old_input.x != 0 or input.y + old_input.y != 0:
			old_input = input


func spawn_body():
	var instance = body.instance()
	instance.direction = head.direction * -1
	instance.position = head.position
	instance.connect("game_over", self, "game_over")
	call_deferred("add_child", instance)


func food_eaten():
	animation_player.play("eat_shoot")


func game_over():
	emit_signal("game_over")


func _on_Level_area_entered(area: Area2D):
	if "head" in area.name:
		game_over()
	elif "body" in area.name:
		get_node(area.name).bounce()

extends Node2D

const DIRECTION = {
	"UP": Vector2(0, -8), "DOWN": Vector2(0, 8), "LEFT": Vector2(-8, 0), "RIGHT": Vector2(8, 0)
}

var gap = Vector2(7, 0);
var old_dir = Vector2(8, 0)
export var speed = 1

onready var body = preload("res://scenes/body.tscn")

func _ready():
	spawn_body()
	pass 

func _physics_process(delta):
	_move_snake(delta)
	pass

func _get_direction():
	if Input.is_action_just_pressed("ui_up"):
		return DIRECTION["UP"]
	elif Input.is_action_just_pressed("ui_down"):
		return DIRECTION["DOWN"]
	elif Input.is_action_just_pressed("ui_left"):
		return DIRECTION["LEFT"]
	elif Input.is_action_just_pressed("ui_right"):
		return DIRECTION["RIGHT"]
	else:
		return old_dir

func _move_snake(delta):
	for i in get_child_count():
		if old_dir != _get_direction():
			
			pass
		else:
			get_child(i).position = lerp(get_child(i).position, get_child(i).position + _get_direction(), speed * delta)

func spawn_body():
	var instance = body.instance()
	var prev_body = get_child(get_child_count() - 1)
	instance.position = prev_body.position + gap
	add_child(instance)


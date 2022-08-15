extends Node2D

var input_direction = Node2D.ZERO
var direction = "RIGHT"
var old_dir = "RIGHT"

onready var body = preload("res://scenes/body.tscn")

func _ready():
	pass 

func _physics_process(_delta):
	pass

func _check_dir():
	if input_direction.x == 0:
		pass
	if input_direction.y == 0:
		pass

func spawn_body():
	var instance = body.instance()
	var prev_body = get_child(get_child_count() - 1)
	instance.position = prev_body.position + gap
	add_child(instance)




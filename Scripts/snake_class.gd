class_name SnakeBody extends Area2D

const GLOBAL_VAR: Resource = preload("res://global_var.tres")
const GRID_SIZE = global_var.GRID_SIZE

var direction
var current_pos
var percent_to_tile = 0.0

onready var animation_player = get_node("AnimationPlayer")


func _ready():
	current_pos = self.position
	pass


func _physics_process(delta):
	_move(delta)


func _move(delta):
	percent_to_tile += (GLOBAL_VAR.speed * 0.8) * delta

	if percent_to_tile >= 1.0:
		position = current_pos + (direction * GRID_SIZE)
		current_pos = self.position
		percent_to_tile = 0.0

	else:
		position = current_pos + (GRID_SIZE * percent_to_tile * direction)

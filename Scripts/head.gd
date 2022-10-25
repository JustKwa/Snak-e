extends Area2D

const GLOBAL_VAR: Resource = preload("res://global_var.tres")
const GRID_SIZE = global_var.GRID_SIZE


var direction = Vector2.RIGHT
var current_pos
var percent_to_tile = 0.0

onready var animation_player = get_node("AnimationPlayer")

signal at_tile


func _ready():
	current_pos = self.position


func _physics_process(delta):
	_move(delta)


func _move(delta):
	rotate_sprite()

	percent_to_tile += GLOBAL_VAR.speed * delta

	if percent_to_tile >= 1.0:
		position = current_pos + (direction * GRID_SIZE)
		current_pos = self.position
		percent_to_tile = 0.0
		emit_signal('at_tile')

	else:
		position = current_pos + (GRID_SIZE * percent_to_tile * direction)


func rotate_sprite() -> void:

	match direction:
		Vector2.LEFT:
			get_child(0).set_rotation_degrees(0)
		Vector2.RIGHT:
			get_child(0).set_rotation_degrees(180)
		Vector2.DOWN:
			get_child(0).set_rotation_degrees(-90)
		Vector2.UP:
			get_child(0).set_rotation_degrees(90)
extends Area2D

var direction 
var current_pos
var percent_to_tile = 0.0
export var global_var: Resource = preload("res://global_var.tres")

signal at_tile

func _ready():
	current_pos = self.position


func _physics_process(delta):
	_move(delta)
	rotate_sprite()


func _move(delta):
	percent_to_tile += global_var.speed * delta

	if percent_to_tile >= 1.0:
		position = current_pos + (direction * global_var.GRID_SIZE)
		current_pos = position
		percent_to_tile = 0.0
		emit_signal("at_tile")

	else:
		position = current_pos + (global_var.GRID_SIZE * percent_to_tile * direction)


func rotate_sprite():
	match direction:
		Vector2(-1, 0):
			$Sprite.set_rotation_degrees(0)
		Vector2(1, 0):
			$Sprite.set_rotation_degrees(180)
		Vector2(0, 1):
			$Sprite.set_rotation_degrees(-90)
		Vector2(0, -1):
			$Sprite.set_rotation_degrees(90)

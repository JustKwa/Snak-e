extends Area2D

var direction = []
var current_pos
var percent_to_tile = 0.0
export var global_var: Resource = preload("res://global_var.tres")

signal change_dir


func _ready():
	current_pos = self.position
	rotate_sprite()


func _physics_process(delta):
	_move(delta)
	pass


func _move(delta):
	percent_to_tile += global_var.speed * delta
	if percent_to_tile >= 1.0:
		position = current_pos + (direction.front() * global_var.GRID_SIZE)
		current_pos = position
		percent_to_tile = 0.0
		if direction.size() > 1:
			direction.pop_front()
			rotate_sprite()
			emit_signal("change_dir")
	else:
		position = current_pos + (global_var.GRID_SIZE * percent_to_tile * direction.front())
	pass


func rotate_sprite():
	if direction.empty():
		return
	else:
		match direction.front():
			Vector2(-1, 0):
				$Sprite.set_rotation_degrees(0)
			Vector2(1, 0):
				$Sprite.set_rotation_degrees(180)
			Vector2(0, 1):
				$Sprite.set_rotation_degrees(-90)
			Vector2(0, -1):
				$Sprite.set_rotation_degrees(90)

extends Area2D

const GLOBAL_VAR: Resource = preload("res://global_var.tres")
const SPEED = GLOBAL_VAR.speed
const GRID_SIZE = global_var.GRID_SIZE

var direction
var current_pos
var percent_to_tile = 0.0

signal at_tile


func _ready():
	current_pos = self.position


func _physics_process(delta):
	_move(delta)
	rotate_sprite()
	if "body" in self.name:
		print(self.position)


func _move(delta):
	percent_to_tile += SPEED * delta

	if percent_to_tile >= 1.0:
		position = current_pos + (direction * GRID_SIZE)
		current_pos = self.position
		percent_to_tile = 0.0
		emit_signal("at_tile")

	else:
		position = current_pos + (GRID_SIZE * percent_to_tile * direction)


func change_dir():
	self.position = Vector2(round(self.position.x), round(self.position.y))
	current_pos = self.position
	percent_to_tile = 0.0
	direction *= -1
	emit_signal("at_tile")
	pass


func rotate_sprite():
	if self.name == "spawn_body":
		return
	else:
		match direction:
			Vector2(-1, 0):
				get_child(0).set_rotation_degrees(0)
			Vector2(1, 0):
				get_child(0).set_rotation_degrees(180)
			Vector2(0, 1):
				get_child(0).set_rotation_degrees(-90)
			Vector2(0, -1):
				get_child(0).set_rotation_degrees(90)

extends Area2D

const GLOBAL_VAR: Resource = preload("res://global_var.tres")
const GRID_SIZE = global_var.GRID_SIZE

var _disconnect: bool = false

var direction
var current_pos
var percent_to_tile = 0.0

onready var animation_player = get_node("AnimationPlayer")

signal at_tile
signal game_over
signal is_moving


func _ready():
	current_pos = self.position


func _physics_process(delta):
	_move(delta)


func _move(delta):
	rotate_sprite()

	if percent_to_tile == 0.0:
		emit_signal("is_moving")

	percent_to_tile += GLOBAL_VAR.speed * delta

	if percent_to_tile >= 1.0:
		position = current_pos + (direction * GRID_SIZE)
		current_pos = self.position
		percent_to_tile = 0.0
		emit_signal("at_tile")

	else:
		position = current_pos + (GRID_SIZE * percent_to_tile * direction)


func bounce():
	animation_player.play("bounce")


func change_dir() -> void:
	self.position = Vector2(round(self.position.x), round(self.position.y))
	current_pos = self.position
	percent_to_tile = 0.0
	direction *= -1
	emit_signal("at_tile")


func rotate_sprite() -> void:
	if "body" in self.name:
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


func _on_body_area_entered(area: Area2D) -> void:
	if "body" in area.name:
		queue_free()
		score.player_score += 1
	elif "head" in area.name && _disconnect:
		emit_signal("game_over")


func _on_body_area_exited(area: Area2D) -> void:
	if !_disconnect && "head" in area.name:
		_disconnect = true

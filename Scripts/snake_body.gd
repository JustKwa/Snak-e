extends Area2D

const GLOBAL_VAR: Resource = preload("res://global_var.tres")
const GRID_SIZE = global_var.GRID_SIZE

var _disconnect: bool = false

var direction
var current_pos
var percent_to_tile = 0.0

onready var animation_player = get_node("AnimationPlayer")

signal game_over


func _ready():
	current_pos = self.position


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


func bounce():
	animation_player.play("bounce")


func change_dir() -> void:
	self.position = Vector2(round(self.position.x), round(self.position.y))
	current_pos = self.position
	percent_to_tile = 0.0
	direction *= -1


func _on_body_area_entered(area: Area2D) -> void:
	if "body" in area.name:
		queue_free()
		score.player_score += 1
	elif "head" in area.name && _disconnect:
		emit_signal("game_over")


func _on_body_area_exited(area: Area2D) -> void:
	if !_disconnect && "head" in area.name:
		_disconnect = true

extends Node2D
class_name SpawnItem

signal spawned(grid_position)

onready var spawn_location = self.position


func _ready():
	emit_signal("spawned", spawn_location)

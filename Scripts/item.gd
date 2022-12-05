extends Node2D
class_name SpawnItem

signal spawned(grid_position)

onready var spawn_location = self.position


func _ready():
	var grid_position = Grid.world_to_map(spawn_location)
	emit_signal("spawned", grid_position)

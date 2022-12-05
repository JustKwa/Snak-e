extends Node2D
class_name SpawnItem

signal spawned(spawn_location)

var spawn_location = self.location


func _ready():
	emit_signal("spawned", spawn_location)

extends Node2D

signal cells_occupied(occupied_cells)

var grid_cells
var occupied_cells : PoolVector2Array

onready var obstacle = preload("res://Scenes/obstacle.tscn")
onready var grid = get_parent().get_node("grid")
onready var level = get_parent()


func _ready():
	level.connect("spawn_obstacle", self, "_on_spawn_obstacle")
	grid.connect("cells_available", self, "_on_cells_available")
	grid_cells = grid.get_used_cells()


func _on_cells_available(available_cells):
	grid_cells = available_cells


func _on_spawn_obstacle():
	var instance = obstacle.instance()
	var rand_index = randi() % grid_cells.size()
	instance.position = grid.map_to_world(grid_cells[rand_index]) + Vector2(8, 9)
	instance.connect("spawned", self, "_on_spawned")
	call_deferred("add_child", instance)


func _on_spawned(grid_position):
	var spawn_location = grid.world_to_map(grid_position)
	occupied_cells.append(spawn_location)
	emit_signal("cells_occupied", occupied_cells)

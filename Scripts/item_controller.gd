extends Node2D

signal cells_occupied(occupied_cells)
signal food_eaten

var grid_cells
var occupied_cells = []

onready var global_var = preload("res://global_var.tres")
onready var level_sheet = preload("res://resources/level_sheet.tres")
onready var obstacle = preload("res://Scenes/obstacle.tscn")
onready var food = preload("res://Scenes/food.tscn")
onready var grid = get_parent().get_node("grid")
onready var level = get_parent()
onready var timer = $Timer


func _ready():
	grid_cells = grid.get_used_cells()
	# global_var.connect("next_level", self, "_on_next_level")
	grid.connect("cells_available", self, "_on_cells_available")
	level.connect("game_start", self, "_on_game_start")


func _on_cells_available(available_cells):
	grid_cells = available_cells


func _on_spawn_obstacle(position):
	var instance = obstacle.instance()
	# var rand_index = randi() % grid_cells.size()
	# instance.position = grid.map_to_world(grid_cells[rand_index]) + Vector2(16, 16)
	instance.position = position
	instance.connect("spawned", self, "_on_spawned")
	# instance.connect("despawned", self, "_on_despawned")
	call_deferred("add_child", instance)


func _on_spawned(grid_position):
	var spawn_location = grid.world_to_map(grid_position)
	occupied_cells.append(spawn_location)
	emit_signal("cells_occupied", occupied_cells)


func _on_spawn_food():
	var instance = food.instance()
	var rand_index = randi() % grid_cells.size()

	instance.position = grid.map_to_world(grid_cells[rand_index]) + Vector2(16, 16)

	instance.connect("spawned", self, "_on_spawned")
	instance.connect("food_eaten", self, "_on_eaten")
	instance.connect("food_explode", self, "_on_explode")

	call_deferred("add_child", instance)


func _on_eaten():
	if global_var.is_transitioning:
		return

	_on_spawn_food()
	emit_signal("food_eaten")


func _on_explode(position):
	_on_spawn_obstacle(position)
	_on_spawn_food()


func _on_game_start():
	var food_amount = level_sheet.get_level().get("food_amount")

	for _i in range(food_amount):
		var temp_timer = Timer.new()
		self.add_child(temp_timer)
		temp_timer.set_wait_time(2)
		temp_timer.set_one_shot(true)
		temp_timer.start()
		yield(temp_timer, "timeout")

		_on_spawn_food()

		if !global_var.is_transitioning:
			return

		global_var.is_transitioning = false

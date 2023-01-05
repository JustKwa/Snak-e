extends Control

signal game_start

onready var global_var: Resource = preload("res://global_var.tres")
onready var level_sheet: Resource = preload("res://Resources/level_sheet.tres")
onready var restart = preload("res://Scenes/restart_popup.tscn")
onready var item_controller = get_node("item_controller")
onready var snake_controller = $snake


func _ready():
	_on_ready()
	var _connect_next_level = global_var.connect("next_level", self, "_on_next_level")
	var _connect_game_over = global_var.connect("game_over", self, "_on_game_over")


func restart_popup():
	var instance = restart.instance()
	get_tree().paused = true
	call_deferred("add_child", instance)


func _on_game_over():
	global_var.high_score = global_var.player_score
	_on_ready()


func _on_ready():
	randomize()
	level_sheet.current_level = 0
	global_var.food_required_for_next_level = level_sheet.get_level().get("food_required")
	print(global_var.food_required_for_next_level)
	emit_signal("game_start")


func _on_next_level():
	level_sheet.current_level += 1
	global_var.food_required_for_next_level = level_sheet.get_level().get("food_required")
	get_tree().call_group("self_destructable", "self_destruct")
	emit_signal("game_start")

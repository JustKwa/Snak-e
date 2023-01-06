extends Control

signal game_start

onready var global_var: Resource = preload("res://global_var.tres")
onready var level_sheet: Resource = preload("res://Resources/level_sheet.tres")
onready var restart = preload("res://Scenes/restart_popup.tscn")
onready var item_controller = get_node("item_controller")
onready var snake_controller = $snake


func _ready():
	_on_ready()
	global_var.connect("next_level", self, "_on_next_level")
	global_var.connect("game_over", self, "_on_game_over")
	global_var.connect("high_score", self, "_on_high_score")


func restart_popup():
	var instance = restart.instance()
	get_tree().paused = true
	call_deferred("add_child", instance)


func _on_game_over():
	restart_popup()
	_save()


func _on_ready():
	randomize()
	global_var.high_score = _load().high_score
	global_var.food_required_for_next_level = level_sheet.get_food_required(global_var.lv())
	emit_signal("game_start")


func _on_next_level():
	global_var.food_required_for_next_level = level_sheet.get_food_required(global_var.lv())
	get_tree().call_group("self_destructable", "self_destruct")
	emit_signal("game_start")


func _on_head_is_shoot():
	get_tree().paused = true


func _on_shoot_function_shoot_turn(_snake_direction):
	get_tree().paused = false


func _save():
	var save = ResourceSaver.save("user://save.tres", global_var)
	assert(save == OK)


func _load():
	if ResourceLoader.exists("user://save.tres"):
		var global_var_load = ResourceLoader.load("user://save.tres")
		return global_var_load


func _on_high_score():
	_save()

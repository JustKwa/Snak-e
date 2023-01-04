extends Control

export var speed: float
var food_required

onready var global_var: Resource = preload("res://global_var.tres")
onready var level_sheet: Resource = preload("res://Resources/level_sheet.tres")
onready var restart = preload("res://Scenes/restart_popup.tscn")
onready var item_controller = get_node("item_controller")
onready var snake_controller = $snake


func _ready():
	_on_ready()


func restart_popup():
	var instance = restart.instance()
	get_tree().paused = true
	call_deferred("add_child", instance)


func _on_game_over():
	global_var.high_score = global_var.player_score
	_on_ready()


func _on_ready():
	randomize()
	level_sheet.current_level = level_sheet.current_level + 1
	food_required = level_sheet.current_level.get("food_required")
	global_var.speed = speed
	global_var.player_score = 0
	return global_var.connect("game_over", self, "_on_game_over")

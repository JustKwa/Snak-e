extends Control

export var speed: float

onready var global_var: Resource = preload("res://global_var.tres")
onready var level_sheet: Resource = preload("res://Resources/level_sheet.tres")
onready var food = preload("res://Scenes/food.tscn")
onready var restart = preload("res://Scenes/restart_popup.tscn")
onready var snake_controller = $snake


func _ready():
	randomize()
	global_var.speed = speed
	global_var.player_score = 0
	return global_var.connect("game_over", self, "_on_game_over")


func restart_popup():
	var instance = restart.instance()
	get_tree().paused = true
	call_deferred("add_child", instance)


func _on_game_over():
	global_var.high_score = global_var.player_score

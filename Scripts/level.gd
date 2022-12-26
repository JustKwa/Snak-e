extends Node2D

signal spawn_obstacle

export var speed: float

var old_score: int = 0

onready var global_var: Resource = preload("res://global_var.tres")
onready var food = preload("res://Scenes/food.tscn")
onready var restart = preload("res://Scenes/restart_popup.tscn")
onready var snake_controller = $snake


func _ready():
	global_var.speed = speed
	global_var.player_score = 0
	return global_var.connect("game_over", self, "_on_game_over")


func _process(_delta):
	difficulty_check()


func difficulty_check():
	if global_var.player_score - old_score < 8:
		return

	old_score = global_var.player_score
	emit_signal("spawn_obstacle")


func restart_popup():
	var instance = restart.instance()
	get_tree().paused = true
	call_deferred("add_child", instance)


func _on_game_over():
	global_var.high_score = global_var.player_score
	snake_controller.get_node("head").animation_player.play("death")

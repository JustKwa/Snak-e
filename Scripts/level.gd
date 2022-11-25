extends Node2D


export var speed: float

onready var global_var: Resource = preload("res://global_var.tres")
onready var food = preload("res://Scenes/food.tscn")
onready var restart = preload("res://Scenes/restart_popup.tscn")
onready var snake = preload("res://Scenes/Snake.tscn")

var old_score: int = 0


func _ready():
	global_var.game_over = false
	global_var.speed = speed
	global_var.player_score = 0
	spawn_food()


func _process(_delta):
	difficulty_check()


func difficulty_check():
	if global_var.player_score - old_score >= 10:
		old_score = global_var.player_score
		global_var.speed += sqrt(global_var.speed) * 0.05


func spawn_food():
	var instance = food.instance()
	var x = rand_range(1, 11)
	var y = rand_range(1, 11)
	instance.position = $grid.map_to_world(Vector2(x, y)) + Vector2(9, 9)
	instance.connect("food_eaten", self, "is_eaten")
	call_deferred("add_child", instance)


func is_eaten():
	spawn_food()
	get_node("snake").food_eaten()


func _on_snake_game_over():
	global_var.game_over = true
	if global_var.player_score > global_var.high_score : global_var.high_score = global_var.player_score
	$snake.get_node('head').animation_player.play('death')
	global_var.speed = 0


func restart_popup():
	var instance = restart.instance()
	get_tree().paused = true
	call_deferred('add_child', instance)

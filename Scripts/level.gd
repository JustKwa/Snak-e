extends Node2D

const GLOBAL_VAR: Resource = preload("res://global_var.tres")

export var speed: float

onready var food = preload("res://Scenes/food.tscn")
onready var restart = preload("res://Scenes/restart_popup.tscn")
onready var snake = preload("res://Scenes/Snake.tscn")

var old_score: int = 0


func _ready():
	GLOBAL_VAR.speed = speed
	score.player_score = 0
	spawn_food()


func _process(_delta):
	difficulty_check()


func difficulty_check():
	if score.player_score - old_score >= 10:
		old_score = score.player_score
		GLOBAL_VAR.speed += sqrt(GLOBAL_VAR.speed) * 0.05


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
	if score.player_score > score.high_score : score.high_score = score.player_score
	$snake.get_node('head').animation_player.play('death')
	GLOBAL_VAR.speed = 0



func restart_popup():
	var instance = restart.instance()
	get_tree().paused = true
	call_deferred('add_child', instance)

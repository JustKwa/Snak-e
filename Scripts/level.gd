extends Node2D


export var speed: float

onready var global_var: Resource = preload("res://global_var.tres")
onready var food = preload("res://Scenes/food.tscn")
onready var restart = preload("res://Scenes/restart_popup.tscn")
onready var snake_controller = $snake
onready var level_collision = $level_collision

var old_score: int = 0


func _ready():
	global_var.speed = speed
	global_var.player_score = 0
	spawn_food()
	return global_var.connect('game_over', self, '_on_game_over')


func _process(_delta):
	difficulty_check()


func difficulty_check():
	if global_var.player_score - old_score >= 10:
		old_score = global_var.player_score
		global_var.speed += sqrt(global_var.speed) * 0.05


func spawn_food():
	var instance = food.instance()
	var random_grid_coord = Vector2(rand_range(1, 13),rand_range(1, 13)) 
	var spawn_coord =  $grid.map_to_world(random_grid_coord) + Vector2(8, 9)
	instance.position = spawn_coord
	instance.connect("food_eaten", self, "_on_eaten")
	call_deferred("add_child", instance)


func _on_eaten():
	spawn_food()
	snake_controller.food_eaten()


func restart_popup():
	var instance = restart.instance()
	get_tree().paused = true
	call_deferred('add_child', instance)


func _on_game_over():
	global_var.high_score = global_var.player_score
	snake_controller.get_node('head').animation_player.play('death')

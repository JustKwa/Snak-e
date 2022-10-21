extends Node2D

onready var food = preload("res://Scenes/food.tscn")


func _ready():
	spawn_food()
	pass


func spawn_food():
	var instance = food.instance()
	var x = rand_range(9, 28)
	var y = rand_range(2, 21)
	instance.position = $grid.map_to_world(Vector2(x, y)) + Vector2(4, 4)
	instance.connect("food_eaten", self, "is_eaten")
	call_deferred("add_child", instance)


func is_eaten():
	spawn_food()
	get_node('snake').spawn_body()

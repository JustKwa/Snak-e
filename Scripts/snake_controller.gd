extends Node2D

signal food_eaten

onready var global_var: Resource = preload("res://global_var.tres")
onready var body = preload("res://Scenes/body.tscn")
onready var head = $head
onready var item_controller = get_parent().get_node("item_controller")


func _ready():
	item_controller.connect("food_eaten", self, "_on_food_eaten")


func spawn_body(body_direction) -> void:
	var instance = body.instance()
	instance.direction = body_direction * -1
	instance.position = head.position
	call_deferred("add_child", instance)


func _on_food_eaten() -> void:
	emit_signal("food_eaten")

func _on_shoot_function_shoot_turn(snake_direction):
	spawn_body(snake_direction)

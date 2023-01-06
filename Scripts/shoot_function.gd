extends Node2D

signal shoot_turn(snake_direction)

var speed_holder

onready var global_var = preload("res://global_var.tres")


func _ready():
	pass


func _on_shoot():
	self.visible = true
	speed_holder = global_var.speed
	global_var.speed = 8


func _input(event):
	if visible == false:
		return
	
	if !get_parent().is_in_tile:
		return 
	
	if not event is InputEventKey:
		return

	match event.as_text():
		"Right":
			emit_signal("shoot_turn", Vector2.RIGHT)
			_disable_event()
		"Left":
			emit_signal("shoot_turn", Vector2.LEFT)
			_disable_event()
		"Up":
			emit_signal("shoot_turn", Vector2.UP)
			_disable_event()
		"Down":
			emit_signal("shoot_turn", Vector2.DOWN)
			_disable_event()


func _disable_event():
	visible = false
	global_var.speed = speed_holder

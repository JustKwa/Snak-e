extends ColorRect

onready var global_var = preload("res://global_var.tres")

func _ready():
	visible = true
	global_var.connect("next_level", self, "_on_next_level")
	pass # Replace with function body.


func _on_Line2D_shoot_time():
	visible = false


func _on_next_level():
	visible = true


func _on_Line2D_shoot():
	visible = true

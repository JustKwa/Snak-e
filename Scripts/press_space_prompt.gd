extends Node2D

onready var global_var = preload("res://global_var.tres")


func _ready():
	visible = false
	$AnimationPlayer.stop()
	global_var.connect("next_level", self, "_on_next_level")


func _on_Line2D_shoot_time():
	visible = true
	$AnimationPlayer.play("press_space")


func _on_Line2D_shoot():
	visible = false
	$AnimationPlayer.stop()


func _on_next_level():
	visible = false
	$AnimationPlayer.stop()

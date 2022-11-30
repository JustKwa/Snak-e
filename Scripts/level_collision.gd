extends Area2D

onready var global_var = preload("res://global_var.tres")


func _on_level_collision_area_entered(area):
	if "head" in area.name:
		global_var.game_over = true
	elif "body" in area.name:
		area.collided()

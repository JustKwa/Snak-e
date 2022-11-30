extends Node2D

signal food_eaten

onready var global_var = preload("res://global_var.tres")


func _on_Area2D_area_entered(area: Area2D):
	if !global_var.game_over:
		if area.name == "head":
			emit_signal("food_eaten")
			global_var.player_score += 1
			queue_free()

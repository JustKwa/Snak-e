extends Node2D

signal food_eaten

onready var global_var = preload("res://global_var.tres")


func _on_Area2D_area_entered(area: Area2D):
	var is_head = "head" in area.name

	if global_var.game_over:
		return

	if is_head:
		global_var.player_score += 1
		emit_signal("food_eaten")
		queue_free()

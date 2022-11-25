extends Area2D

signal game_over

func _on_level_collision_area_entered(area):
	if "head" in area.name:
		emit_signal("game_over")
	elif "body" in area.name:
		area.bounce()


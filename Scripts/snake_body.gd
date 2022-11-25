extends SnakeBody

var disconnect: bool = false


func bounce():
	animation_player.play("bounce")


func change_dir() -> void:
	self.position = Vector2(round(self.position.x), round(self.position.y))
	current_pos = self.position
	percent_to_tile = 0.0
	direction *= -1


func _on_body_area_entered(area: Area2D) -> void:
	if global_var.game_over: return
	elif disconnect:
		if "body" in area.name:
			queue_free()
			global_var.player_score += 1
		elif "head" in area.name:
			global_var.game_over = true

func _on_body_area_exited(area: Area2D) -> void:
	if !disconnect && "head" in area.name:
		disconnect = true

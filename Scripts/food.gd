extends Node2D

signal food_eaten


func _ready():
	print(self.position)
	pass


func _on_Area2D_area_entered(area: Area2D):
	if area.name == "head":
		emit_signal("food_eaten")
		score.player_score += 1
		queue_free()
	else:
		return

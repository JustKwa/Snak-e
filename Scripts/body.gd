extends Area2D

var direction = []
var current_pos
var percent_to_tile = 0.0


func _ready():
	current_pos = self.position


func _on_body_area_entered(area: Area2D):
	if area.name == "head":
		return get_tree().reload_current_scene()
	elif area.name == "body":
		queue_free()
	else:
		return

extends ColorRect


func _ready():
	visible = false


func _on_shoot():
	visible = true


func _on_shoot_function_shoot_turn(_snake_direction):
	visible = false

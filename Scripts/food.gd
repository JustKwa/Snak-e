extends Node2D

signal food_eaten

func _ready():
	pass

func _on_Area2D_area_entered(area:Area2D):	
	if area.name == "head":
		emit_signal("food_eaten")
		queue_free()
	pass 

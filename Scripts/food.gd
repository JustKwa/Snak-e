extends Node2D

signal food_eaten

func _ready():
	pass

# func _physics_process(_delta):
# 	_test()

# func _test():
# 	if Input.is_action_just_pressed("ui_down"):
# 		emit_signal("food_eaten")
# 		queue_free()

func _on_Area2D_area_entered(area:Area2D):	
	if area.name == "head":
		emit_signal("food_eaten")
		queue_free()
	pass 

extends Button

onready var global_var: Resource = preload("res://global_var.tres")


func _on_Button_pressed():
	global_var.test_signal()

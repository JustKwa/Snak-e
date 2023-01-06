extends Sprite

var multiplier = 1  

onready var global_var = preload("res://global_var.tres")
onready var label = get_parent().get_node("Label")


func _ready():
	global_var.connect("next_level", self, "_on_next_level")


func _on_next_level():
	multiplier += 1
	label.set_text("x%1d" % multiplier)

extends ColorRect


func _ready():
	visible = false


func _on_dimmed_bar_visible(value):
	if value:
		visible = false
		return
	
	visible = true

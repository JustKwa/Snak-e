extends Line2D

signal snake_explode

var canon_timer: float
var count = 0 

onready var level_sheet = preload("res://resources/level_sheet.tres")
onready var global_var = preload("res://global_var.tres")


func _ready():
	global_var.connect("next_level", self, "_on_next_level")
	canon_timer = level_sheet.get_level().get("canon_timer")


func _increment():
	var step: float = ceil(529.0/canon_timer)
	points[0].y +=  step
	points[0].y = clamp(points[0].y, 0, 529)
	count += 1


func _on_Timer_timeout():
	_increment()

	if count < canon_timer:
		return

	emit_signal("snake_explode")


func _on_next_level():
	$Timer.stop()
	canon_timer = level_sheet.get_level().get("canon_timer")
	count = 0
	points[0].y = 0


func _on_snake_food_eaten():
	if !$Timer.is_stopped():
		return

	$Timer.start()

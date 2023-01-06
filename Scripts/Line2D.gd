extends Line2D

signal snake_explode
signal shoot_time
signal shoot

var canon_timer: float
var _count = 0 
var shoot_mode = false
var wait_time = 0.1

onready var level_sheet = preload("res://resources/level_sheet.tres")
onready var global_var = preload("res://global_var.tres")


func _ready():
	$Timer.set_wait_time(wait_time)
	global_var.connect("next_level", self, "_on_next_level")
	canon_timer = level_sheet.get_level().get("canon_timer")


func _increment():
	var step: float = ceil( (529.0/canon_timer) / 10)
	points[0].y +=  step
	points[0].y = clamp(points[0].y, 0, 529)
	_count += 1


func _on_Timer_timeout():
	_increment()

	if points[0].y < (529/3) * 2:
		return

	emit_signal("shoot_time")
	shoot_mode = true

	if !points[0].y == 529:
		return

	emit_signal("snake_explode")


func _on_next_level():
	_reset()
	canon_timer = level_sheet.get_level().get("canon_timer")


func _on_snake_food_eaten():
	if !$Timer.is_stopped():
		wait_time -= 0.01
		$Timer.set_wait_time(wait_time)
		return

	$Timer.start()


func _input(event):
	if !shoot_mode:
		return
	
	if not event is InputEventKey:
		return

	if event.is_action_pressed("ui_shoot"):
		emit_signal("shoot")
		_reset()


func _reset():
	$Timer.stop()
	shoot_mode = false
	_count = 0
	points[0].y = 0
	wait_time = 0.1
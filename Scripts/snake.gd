extends Node2D

var gap = Vector2(7, 0);
var direction = Vector2.ZERO


onready var body = preload("res://scenes/body.tscn")
onready var timer = $speed_timer

func _ready():
	# spawn_body()
	timer.start()
	pass 

func _physics_process(_delta):
	_check_direction()
	pass

func _timer_timeout():
	_move()
	pass

func _check_direction():
	if Input.is_action_just_pressed("ui_up"):
		direction = Vector2(0, -8)
	elif Input.is_action_just_pressed("ui_down"):
		direction = Vector2(0, 8)
	elif Input.is_action_just_pressed("ui_left"):
		direction = Vector2(-8, 0)
	elif Input.is_action_just_pressed("ui_right"):
		direction = Vector2(8, 0)
	pass

func _move():
	self.position += direction
func spawn_body():
	var instance = body.instance()
	instance.position = $head.position + gap
	add_child(instance)


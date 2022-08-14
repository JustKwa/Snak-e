extends Node2D

const DIRECTION = {
	"UP": Vector2(0, -8), "DOWN": Vector2(0, 8), "LEFT": Vector2(-8, 0), "RIGHT": Vector2(8, 0)
}

var gap = Vector2(7, 0);
var old_dir = Vector2(8, 0)
var speed = 0.01

onready var body = preload("res://scenes/body.tscn")

func _ready():
	# spawn_body()
	$Timer.start()
	pass 

func _on_Timer_timeout():
	print("working")
	_move_snake()
	pass 

func _get_direction():
	if Input.is_action_just_pressed("ui_up"):
		return DIRECTION["UP"]
	elif Input.is_action_just_pressed("ui_down"):
		return DIRECTION["DOWN"]
	elif Input.is_action_just_pressed("ui_left"):
		return DIRECTION["LEFT"]
	elif Input.is_action_just_pressed("ui_right"):
		return DIRECTION["RIGHT"]
	else:
		return old_dir

func _move_snake():
	for i in range(0,get_child_count()-1):
		print(get_child(i).name)
		get_child(i).add_dir(_get_direction())
		print(speed)
		get_child(i).position = lerp(get_child(i).position, get_child(i).current_pos + get_child(i).direction.front(), speed)
		print(get_child(i).current_pos + get_child(i).direction.front())
		print(get_child(i).position)
		if get_child(i).position == get_child(i).current_pos + get_child(i).direction.front():
			get_child(i).del_dir()

func spawn_body():
	var instance = body.instance()
	var prev_body = get_child(get_child_count() - 1)
	instance.position = prev_body.position + gap
	add_child(instance)




extends Node2D


const DIRECTION = {
	"up" 	  : Vector2( 0, -15 ),
	"down"  : Vector2( 0, 15 ),
	"left"  : Vector2( -15, 0 ),
	"right" : Vector2( 15, 0 )
}


var snake = []
var turn_direction
var old_turn_direction 
var snake_length_counter
var counter
var direction_change

onready var head = $head
onready var body = $body
onready var body2 = $body2
onready var grid = get_parent().get_node("grid")
onready var speed_timer = $speed


func _ready():
	_default_state()
	# snake[0].turn_to(turn_direction)


func _process(_delta):
	_check_direction()

	
func _on_speed_timeout():
	move_snake()


func _check_direction():
	if turn_direction != "down" and Input.is_action_just_pressed("ui_up"):
		turn_direction = "up"
	if turn_direction != "up" and Input.is_action_just_pressed("ui_down"):
		turn_direction = "down"
	if turn_direction != "left" and Input.is_action_just_pressed("ui_right"):
		turn_direction = "right"
	if turn_direction != "right" and Input.is_action_just_pressed("ui_left"):
		turn_direction = "left"


func move_snake():
	if snake[0].direction != turn_direction:
		snake[0].direction = turn_direction
	for i in snake:
		if _out_of_bound(i) == true:
			counter += 1
		i.turn()
		if counter < 2:
			_move(i,DIRECTION[i.direction])
		else:
			snake.clear()

	for i in range( snake.size() - 1, 0, -1):
		if snake[i].direction != snake[i-1].direction:
			snake[i].direction = snake[i-1].direction


# out_of_bound = (23, 143) , (143,23)


# OUT OF BOUND SYSTEM
func _out_of_bound(body_part):
	if body_part.global_position.x == 23 and turn_direction == "left":
		return true
	elif body_part.global_position.x == 143 and turn_direction == "right": 
		return true
	elif body_part.global_position.y == 23 and turn_direction == "up":
		return true
	elif body_part.global_position.y == 143 and turn_direction == "down": 
		return true
	else:
		return false


func _move(body_part ,vector):
	body_part.global_translate(vector)
	pass


func _default_state():
	snake = [head, body, body2]
	counter = 1
	turn_direction = "left"
	old_turn_direction = turn_direction
	direction_change = false
	for i in snake:
		i.direction = turn_direction
	speed_timer.start()



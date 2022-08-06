extends Node2D


const DIRECTION = {
	"up" 	  : Vector2( 0, -15 ),
	"down"  : Vector2( 0, 15 ),
	"left"  : Vector2( -15, 0 ),
	"right" : Vector2( 15, 0 )
}

var snake_length = []
var move_direction = Vector2( 0, 0 )


onready var head = $head
onready var body = $body
onready var tail = $tail
onready var grid = get_parent().get_node("grid")
onready var speed_timer = $speed


func _ready():
	snake_length = [head, body, tail]
	speed_timer.start()


func _process(_delta):
	_check_movement()
	

func _check_movement():
	if move_direction != DIRECTION["down"] and Input.is_action_just_pressed("ui_up"):
		move_direction = DIRECTION["up"]
	if move_direction != DIRECTION["up"] and Input.is_action_just_pressed("ui_down"):
		move_direction = DIRECTION["down"]
	if move_direction != DIRECTION["left"] and Input.is_action_just_pressed("ui_right"):
		move_direction = DIRECTION["right"]
	if move_direction != DIRECTION["right"] and Input.is_action_just_pressed("ui_left"):
		move_direction = DIRECTION["left"]


func move_snake():
	self.position += move_direction


	
func _on_speed_timeout():
	_out_of_bound()
	move_snake()


# out_of_bound = (23, 143) , (143,23)


# OUT OF BOUND SYSTEM
func _out_of_bound():
	for i in snake_length:
		if i.global_position.x == 23 and move_direction == DIRECTION["left"]:
			_teleport(i, Vector2( 135, 0)) 
		elif i.global_position.x == 143 and move_direction == DIRECTION["right"]: 
			_teleport(i, Vector2( -135, 0))
		elif i.global_position.y == 23 and move_direction == DIRECTION["up"]: 
			_teleport(i, Vector2( 0, 135))
		elif i.global_position.y == 143 and move_direction == DIRECTION["down"]: 
			_teleport(i, Vector2( 0, -135))

func _teleport(part ,vector):
	part.global_translate(vector)
	pass

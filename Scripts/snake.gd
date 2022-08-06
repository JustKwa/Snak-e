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
	# for i in grid.get_used_cells_by_id(1):
	# 	print(i)
	# 	print( grid.map_to_world(i) + Vector2(ceil(16/2),ceil(16/2)) )
		# print(snake_length[0].global_position)
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
	for i in snake_length:
		self.position += move_direction
	pass

	
func _on_speed_timeout():	
	# _out_of_bound()
	move_snake()

# out_of_bound = (23, 143) , (143,23)

func _out_of_bound():
	for i in snake_length:
		print(i.get_name())
		print(i.global_position.x)
		print(typeof(i.global_position.x) == TYPE_VECTOR2)
		match int(i.global_position):
			23:
				_teleport(i,Vector2(135,0))
			
		# if i.global_position.x == grid.cell:
		# 	_teleport(i,Vector2(135,0))
			
func _teleport(part ,vector):
	part.global_translate(vector)
	pass

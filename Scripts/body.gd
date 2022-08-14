extends Area2D

var direction = []
var current_pos

func _ready():
	current_pos = self.position
	pass

func del_dir():
	if direction.Empty():
		return
	else: 
		direction.pop_front()
		current_pos = self.position


func add_dir(dir_vector):
	direction.append(dir_vector)

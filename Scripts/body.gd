extends Area2D

var direction = []
var current_pos
var percent_to_tile = 0.0
var is_connected = true
export var global_var: Resource = preload("res://global_var.tres")


func _ready():
	current_pos = self.position


func _physics_process(delta):
	print("body:" + str(direction))
	# _move(delta)
	pass


func _move(delta):
	percent_to_tile += global_var.speed * delta
	if percent_to_tile >= 1.0:
		position = current_pos + (direction.front() * global_var.GRID_SIZE)
		current_pos = position
		percent_to_tile = 0.0
		if direction.size() > 1:
			remove_dir()
	else:
		position = current_pos + (global_var.GRID_SIZE * percent_to_tile * direction.front())
	pass


func add_dir(dir):
	direction.append(dir)


func remove_dir():
	direction.pop_front()
	rotate_sprite()


func _on_body_area_entered(area: Area2D):
	if area.name == "head":
		return get_tree().reload_current_scene()
	elif area.name == "body":
		queue_free()
	else:
		return


func rotate_sprite():
	pass

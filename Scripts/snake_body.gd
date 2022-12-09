extends SnakeBody

enum State { MOVE, BOUNCE }

var disconnect: bool = false
var is_bounce: bool = false

onready var collision_shape = $CollisionShape2D
onready var disconnect_check = $disconnect_check


func _ready() -> void:
	state = State.MOVE


func _physics_process(delta) -> void:
	match state:
		State.MOVE:
			_move(delta)
		State.BOUNCE:
			_bounce()
			state = State.MOVE


func collided():
	state = State.BOUNCE


func _bounce() -> void:
	match direction:
		Vector2.LEFT, Vector2.RIGHT:
			animation_player.play("bounce_v")
		Vector2.UP, Vector2.DOWN:
			animation_player.play("bounce_h")


func _move(delta):
	# use to slow down the bullet movement
	var speed_dampener = 0.8

	percent_to_tile += (global_var.speed * speed_dampener) * delta

	if percent_to_tile >= 1.0:
		position = current_pos + (direction * GRID_SIZE)
		current_pos = self.position
		percent_to_tile = 0.0
	else:
		position = current_pos + (GRID_SIZE * percent_to_tile * direction)


func _change_dir() -> void:
	self.position = Vector2(round(self.position.x), round(self.position.y))
	current_pos = self.position
	percent_to_tile = 0.0
	direction *= -1


func _on_body_area_entered(area: Area2D) -> void:
	if global_var.game_over:
		return
	elif disconnect:
		print("work")
		if "body" in area.name:
			queue_free()
			global_var.player_score += 1
		else:
			collided()


func _on_disconnect_check_area_exited(area):
	if !disconnect && "head" in area.name:
		disconnect = true
		collision_shape.set_deferred("disabled", false)
		disconnect_check.get_node("CollisionShape2D").set_deferred("disabled", true)

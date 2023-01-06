extends SnakeBody

enum State { MOVE, BOUNCE, EXPLODE }

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
		State.EXPLODE:
			_explode()


func collided():
	state = State.BOUNCE


func _bounce() -> void:
	match direction:
		Vector2.LEFT, Vector2.RIGHT:
			animation_player.play("bounce_v")
		Vector2.UP, Vector2.DOWN:
			animation_player.play("bounce_h")


func _move(delta):
	var speed_modifier = level_sheet.get_level().get("speed_modifier")

	percent_to_tile += (global_var.speed * speed_modifier) * delta

	if percent_to_tile >= 1.0:
		position = current_pos + (direction * GRID_SIZE)
		current_pos = self.position
		percent_to_tile = 0.0

	position = current_pos + (GRID_SIZE * percent_to_tile * direction)


func _change_dir() -> void:
	self.position = Vector2(round(self.position.x), round(self.position.y))
	current_pos = self.position
	percent_to_tile = 0.0
	direction *= -1


func _on_body_area_entered(area: Area2D) -> void:
	if global_var.game_over:
		return


	if area.is_in_group("bullet_ignore"):
		return

	collided()


func _on_disconnect_check_area_exited(area):
	var is_head = "head" in area.name

	if is_head:
		collision_shape.set_deferred("disabled", false)
		disconnect_check.get_node("CollisionShape2D").set_deferred("disabled", true)


func _explode():
	animation_player.play("explode")
	collision_shape.set_deferred("disabled", true)
	yield(animation_player, "animation_finished")
	queue_free()


func self_destruct():
	state = State.EXPLODE

extends SpawnItem

signal food_eaten
signal food_explode(position)

enum State { IDLE, EXPLODE, EATEN }

var state = State.IDLE

onready var global_var = preload("res://global_var.tres")
onready var level_sheet = preload("res://resources/level_sheet.tres")
onready var animation_player = $food_area/AnimationPlayer
onready var collision_shape = $food_area/CollisionShape2D


func _ready():
	emit_signal("spawned", self.position)
	$Timer.set_wait_time(level_sheet.get_bomb_timer(global_var.lv()))
	$Timer.start()


func _physics_process(_delta):
	match state:
		State.IDLE:
			_idle()
			return
		State.EXPLODE:
			_explode()
			emit_signal("food_explode", self.position)
			state = State.IDLE
			return
		State.EATEN:
			_eaten()
			_queue_free()


func _queue_free():
	queue_free()


func _idle():
	if $Timer.time_left == 0:
		return
	if $Timer.time_left > 2:
		return
	animation_player.play("about_to_explode")

	return


func _explode():
	collision_shape.set_deferred("disabled", true)
	animation_player.play("explode")


func _eaten():
	global_var.increase_score()
	global_var.increase_current_food_has()
	emit_signal("food_eaten")


func _on_Area2D_area_entered(area: Area2D):
	if global_var.game_over:
		return

	if area.is_in_group("eat_food"):
		state = State.EATEN
		return

	if area.is_in_group("food_explode"):
		state = State.EXPLODE
		return


func _on_Timer_timeout():
	state = State.EXPLODE


func self_destruct():
	_explode()
